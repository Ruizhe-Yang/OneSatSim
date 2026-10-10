#!/usr/bin/env python3
"""Generate a deterministic GCRS orbit and celestial/EOP environment table."""

from __future__ import annotations

import hashlib
import json
import math
import re
import sys
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError

PACKAGE_ROOT = Path(__file__).resolve().parents[1]
VENDOR = Path(__file__).resolve().with_name("vendor")
if str(VENDOR) not in sys.path:
    sys.path.insert(0, str(VENDOR))

import astropy.units as u
import erfa
import numpy as np
from astropy.time import Time, TimeDelta
from astropy.utils import iers
from jplephem.spk import SPK
from scipy.integrate import solve_ivp
from scipy.interpolate import Akima1DInterpolator, CubicSpline


MU_EARTH = 3.986004418e14
EARTH_RADIUS = 6378137.0
J2_EARTH = 1.08262668e-3
MU_SUN = 1.32712440018e20
MU_MOON = 4.902800066e12
ARCSEC_RAD = math.pi / (180.0 * 3600.0)


class EphemerisPreparationError(ValueError):
    """Raised when absolute-time or environment generation is unsafe."""


@dataclass(frozen=True)
class ResourceSettings:
    spk_path: Path
    iers_path: Path
    leap_seconds_path: Path
    allow_predicted_eop: bool
    sample_interval: float
    propagation_model: str
    propagation_rtol: float
    propagation_atol_position: float
    propagation_atol_velocity: float


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def configure_astropy(leap_seconds_path: Path) -> None:
    if not leap_seconds_path.is_file():
        raise EphemerisPreparationError(f"Leap-second file is missing: {leap_seconds_path}")
    iers.conf.auto_download = False
    iers.conf.auto_max_age = None
    iers.conf.iers_degraded_accuracy = "error"
    leaps = iers.LeapSeconds.open(str(leap_seconds_path))
    leaps.update_erfa_leap_seconds()


def _normalise_datetime_text(value: str) -> str:
    text = value.strip().replace("：", ":").replace("／", "/").replace("－", "-")
    match = re.fullmatch(
        r"(\d{4})年\s*(\d{1,2})月\s*(\d{1,2})日\s*(\d{1,2}):(\d{1,2}):(\d{1,2}(?:\.\d+)?)",
        text,
    )
    if match:
        year, month, day, hour, minute, second = match.groups()
        text = f"{int(year):04d}-{int(month):02d}-{int(day):02d}T{int(hour):02d}:{int(minute):02d}:{float(second):06.3f}"
    return text


def parse_absolute_time(value: Any, time_zone: str, field: str) -> Time:
    """Parse an Excel/string civil time, requiring an explicit IANA/UTC zone."""
    zone_name = str(time_zone or "").strip()
    if not zone_name:
        raise EphemerisPreparationError(f"{field}: TimeZone is blank")
    try:
        zone = ZoneInfo(zone_name)
    except ZoneInfoNotFoundError as exc:
        raise EphemerisPreparationError(f"{field}: unknown time zone {zone_name!r}") from exc
    if isinstance(value, datetime):
        parsed = value
    else:
        text = _normalise_datetime_text(str(value or ""))
        if not text:
            raise EphemerisPreparationError(f"{field}: date/time is blank")
        if re.search(r":60(?:\.\d+)?(?:Z|[+-]\d\d:?\d\d)?$", text):
            if zone_name not in {"UTC", "Etc/UTC"}:
                raise EphemerisPreparationError(f"{field}: leap-second notation requires TimeZone=UTC")
            clean = text[:-1] if text.endswith("Z") else text
            if re.search(r"[+-]\d\d:?\d\d$", clean):
                raise EphemerisPreparationError(f"{field}: explicit offset is not accepted for leap-second notation")
            try:
                return Time(clean.replace(" ", "T"), format="isot", scale="utc")
            except Exception as exc:
                raise EphemerisPreparationError(f"{field}: invalid leap-second date {value!r}") from exc
        try:
            parsed = datetime.fromisoformat(text.replace("Z", "+00:00"))
        except ValueError as exc:
            raise EphemerisPreparationError(f"{field}: invalid date/time {value!r}") from exc
    if parsed.tzinfo is not None:
        expected = parsed.replace(tzinfo=None, fold=parsed.fold).replace(tzinfo=zone).utcoffset()
        if parsed.utcoffset() != expected:
            raise EphemerisPreparationError(
                f"{field}: explicit UTC offset {parsed.utcoffset()} conflicts with TimeZone={zone_name}"
            )
        aware = parsed
    else:
        fold0 = parsed.replace(tzinfo=zone, fold=0)
        fold1 = parsed.replace(tzinfo=zone, fold=1)
        if fold0.utcoffset() != fold1.utcoffset():
            raise EphemerisPreparationError(f"{field}: daylight-saving time is ambiguous; provide an explicit UTC offset")
        aware = fold0
        roundtrip = aware.astimezone(timezone.utc).astimezone(zone).replace(tzinfo=None)
        if roundtrip != parsed:
            raise EphemerisPreparationError(f"{field}: local civil time does not exist in TimeZone={zone_name}")
    return Time(aware.astimezone(timezone.utc), scale="utc")


def time_iso_utc(value: Time) -> str:
    result = value.utc.copy()
    result.precision = 3
    return result.isot + "Z"


def add_physical_seconds(start: Time, seconds: Any) -> Time:
    return (start.tai + TimeDelta(seconds, format="sec")).utc


def duration_seconds(value: Any, unit: str) -> float:
    try:
        number = float(value)
    except (TypeError, ValueError) as exc:
        raise EphemerisPreparationError(f"Duration must be numeric, got {value!r}") from exc
    factors = {"s": 1.0, "min": 60.0, "h": 3600.0}
    if unit not in factors:
        raise EphemerisPreparationError(f"Duration unit must be s, min, or h; got {unit!r}")
    result = number * factors[unit]
    if not math.isfinite(result) or result <= 0:
        raise EphemerisPreparationError("Duration must be a positive finite value")
    return result


def solve_kepler(mean_anomaly: float, eccentricity: float) -> float:
    anomaly = math.remainder(mean_anomaly, 2.0 * math.pi)
    estimate = anomaly if eccentricity < 0.8 else math.copysign(math.pi, anomaly or 1.0)
    for _ in range(30):
        residual = estimate - eccentricity * math.sin(estimate) - anomaly
        step = residual / (1.0 - eccentricity * math.cos(estimate))
        estimate -= step
        if abs(step) <= 2e-15:
            return estimate
    raise EphemerisPreparationError("Kepler equation did not converge")


def _rotation3(angle: float) -> np.ndarray:
    c, s = math.cos(angle), math.sin(angle)
    return np.array([[c, -s, 0.0], [s, c, 0.0], [0.0, 0.0, 1.0]])


def _rotation1(angle: float) -> np.ndarray:
    c, s = math.cos(angle), math.sin(angle)
    return np.array([[1.0, 0.0, 0.0], [0.0, c, -s], [0.0, s, c]])


def keplerian_to_state(elements: dict[str, float]) -> np.ndarray:
    a = float(elements["semiMajorAxis"])
    e = float(elements["eccentricity"])
    inc = float(elements["inclination"])
    raan = float(elements["initialRAAN"])
    mean = float(elements["initialMeanAnomaly"])
    argp = float(elements["argumentOfPerigee"])
    if not (a > EARTH_RADIUS and 0.0 <= e < 1.0):
        raise EphemerisPreparationError("Keplerian state must be elliptic and outside Earth")
    eccentric = solve_kepler(mean, e)
    scale = math.sqrt(1.0 - e * e)
    denominator = 1.0 - e * math.cos(eccentric)
    perifocal_r = np.array([a * (math.cos(eccentric) - e), a * scale * math.sin(eccentric), 0.0])
    mean_motion = math.sqrt(MU_EARTH / a**3)
    perifocal_v = np.array([
        -a * mean_motion * math.sin(eccentric) / denominator,
        a * mean_motion * scale * math.cos(eccentric) / denominator,
        0.0,
    ])
    rotation = _rotation3(raan) @ _rotation1(inc) @ _rotation3(argp)
    return np.concatenate((rotation @ perifocal_r, rotation @ perifocal_v))


def state_to_keplerian(state: np.ndarray) -> dict[str, float]:
    position, velocity = state[:3], state[3:]
    radius, speed = np.linalg.norm(position), np.linalg.norm(velocity)
    angular = np.cross(position, velocity)
    h = np.linalg.norm(angular)
    if radius <= EARTH_RADIUS or h <= 1e-8:
        raise EphemerisPreparationError("Initial state is inside Earth or has zero angular momentum")
    energy = speed * speed / 2.0 - MU_EARTH / radius
    if energy >= 0:
        raise EphemerisPreparationError("Only bound elliptic initial states are supported")
    a = -MU_EARTH / (2.0 * energy)
    evec = np.cross(velocity, angular) / MU_EARTH - position / radius
    e = np.linalg.norm(evec)
    if e >= 1.0 or a * (1.0 - e) <= EARTH_RADIUS + 100000.0:
        raise EphemerisPreparationError("Initial state produces an unsupported re-entry/perigee altitude")
    inclination = math.acos(np.clip(angular[2] / h, -1.0, 1.0))
    node = np.cross(np.array([0.0, 0.0, 1.0]), angular)
    n = np.linalg.norm(node)
    raan = math.atan2(node[1], node[0]) % (2.0 * math.pi) if n > 1e-12 else 0.0
    if e > 1e-12 and n > 1e-12:
        argp = math.acos(np.clip(np.dot(node, evec) / (n * e), -1.0, 1.0))
        if evec[2] < 0:
            argp = 2.0 * math.pi - argp
    else:
        argp = 0.0
    if e > 1e-12:
        true_anomaly = math.acos(np.clip(np.dot(evec, position) / (e * radius), -1.0, 1.0))
        if np.dot(position, velocity) < 0:
            true_anomaly = 2.0 * math.pi - true_anomaly
        eccentric = 2.0 * math.atan2(
            math.sqrt(1.0 - e) * math.sin(true_anomaly / 2.0),
            math.sqrt(1.0 + e) * math.cos(true_anomaly / 2.0),
        )
        mean = (eccentric - e * math.sin(eccentric)) % (2.0 * math.pi)
    else:
        mean = math.atan2(position[2] / max(math.sin(inclination), 1e-12), np.dot(node, position) / max(n, 1e-12)) % (2.0 * math.pi)
    return {
        "semiMajorAxis": a,
        "eccentricity": e,
        "inclination": inclination,
        "raan": raan,
        "argumentOfPerigee": argp,
        "meanAnomaly": mean,
        "period": 2.0 * math.pi * math.sqrt(a**3 / MU_EARTH),
    }


def _spk_position(kernel: SPK, target: str, times: Time) -> np.ndarray:
    jd1, jd2 = times.tdb.jd1, times.tdb.jd2
    emb = kernel[0, 3].compute(jd1, jd2)
    earth = emb + kernel[3, 399].compute(jd1, jd2)
    if target == "earth":
        result = earth
    elif target == "sun":
        result = kernel[0, 10].compute(jd1, jd2)
    elif target == "moon":
        result = emb + kernel[3, 301].compute(jd1, jd2)
    else:
        raise KeyError(target)
    return np.asarray(result, dtype=float).T * 1000.0


def _earth_orientation(times: Time, eop: iers.IERS_A) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    dut1 = eop.ut1_utc(times).to_value(u.s)
    xp, yp = eop.pm_xy(times)
    work = times.copy()
    work.delta_ut1_utc = dut1
    celestial_to_terrestrial = erfa.c2t06a(
        work.tt.jd1,
        work.tt.jd2,
        work.ut1.jd1,
        work.ut1.jd2,
        xp.to_value(u.rad),
        yp.to_value(u.rad),
    )
    return np.transpose(celestial_to_terrestrial, (0, 2, 1)), dut1, xp.to_value(u.rad), yp.to_value(u.rad)


def _eop_status(eop: iers.IERS_A, times: Time, allow_predicted: bool) -> dict[str, Any]:
    mjd = np.asarray(eop["MJD"].value, dtype=float)
    first, last = float(np.nanmin(mjd)), float(np.nanmax(mjd))
    requested_min, requested_max = float(np.min(times.utc.mjd)), float(np.max(times.utc.mjd))
    if requested_min < first or requested_max > last:
        raise EphemerisPreparationError(
            f"IERS coverage {first:.1f}..{last:.1f} MJD does not cover {requested_min:.6f}..{requested_max:.6f}"
        )
    selected = (mjd >= math.floor(requested_min) - 1) & (mjd <= math.ceil(requested_max) + 1)
    flags = set()
    for column in ("UT1Flag", "PolPMFlag", "NutFlag"):
        flags.update(str(item) for item in eop[column][selected] if str(item) not in {"--", ""})
    predicted = "P" in flags
    if predicted and not allow_predicted:
        raise EphemerisPreparationError("Requested interval uses predicted IERS EOP but AllowPredictedEOP is FALSE")
    return {
        "coverageMJD": [first, last],
        "requestedMJD": [requested_min, requested_max],
        "flags": sorted(flags),
        "usesPredicted": predicted,
        "label": "PREDICTED" if predicted else "OBSERVED_OR_FINAL",
    }


def _make_ephemeris_splines(kernel: SPK, start: Time, minimum: float, maximum: float) -> tuple[Callable[[float], np.ndarray], Callable[[float], np.ndarray]]:
    grid = np.unique(np.concatenate(([minimum], np.arange(math.floor(minimum / 300.0) * 300.0, maximum + 300.0, 300.0), [maximum])))
    times = add_physical_seconds(start, grid)
    earth = _spk_position(kernel, "earth", times)
    sun = _spk_position(kernel, "sun", times) - earth
    moon = _spk_position(kernel, "moon", times) - earth
    sun_spline = CubicSpline(grid, sun, axis=0)
    moon_spline = CubicSpline(grid, moon, axis=0)
    return lambda t: np.asarray(sun_spline(t), dtype=float), lambda t: np.asarray(moon_spline(t), dtype=float)


def _make_pole_spline(start: Time, minimum: float, maximum: float, eop: iers.IERS_A) -> Callable[[float], np.ndarray]:
    grid = np.unique(np.concatenate(([minimum], np.arange(math.floor(minimum / 300.0) * 300.0, maximum + 300.0, 300.0), [maximum])))
    rotation, _, _, _ = _earth_orientation(add_physical_seconds(start, grid), eop)
    spline = CubicSpline(grid, rotation[:, :, 2], axis=0)
    return lambda t: np.asarray(spline(t), dtype=float) / np.linalg.norm(spline(t))


def _dynamics(sun: Callable[[float], np.ndarray], moon: Callable[[float], np.ndarray], pole: Callable[[float], np.ndarray]) -> Callable[[float, np.ndarray], np.ndarray]:
    def equations(t: float, state: np.ndarray) -> np.ndarray:
        r = state[:3]
        rnorm = np.linalg.norm(r)
        acceleration = -MU_EARTH * r / rnorm**3
        axis = pole(t)
        z = float(np.dot(r, axis))
        factor = 1.5 * J2_EARTH * MU_EARTH * EARTH_RADIUS**2 / rnorm**5
        acceleration += factor * ((5.0 * z * z / rnorm**2 - 1.0) * r - 2.0 * z * axis)
        for body, mu in ((sun(t), MU_SUN), (moon(t), MU_MOON)):
            relative = body - r
            acceleration += mu * (relative / np.linalg.norm(relative) ** 3 - body / np.linalg.norm(body) ** 3)
        return np.concatenate((state[3:], acceleration))

    return equations


def _propagate(
    initial_state: np.ndarray,
    epoch_offset: float,
    minimum: float,
    maximum: float,
    equations: Callable[[float, np.ndarray], np.ndarray],
    rtol: float,
    atol_position: float,
    atol_velocity: float,
) -> Any:
    atol = np.array([atol_position] * 3 + [atol_velocity] * 3)
    if abs(epoch_offset - minimum) <= 1e-12:
        state_at_minimum = initial_state
    else:
        first = solve_ivp(equations, (epoch_offset, minimum), initial_state, method="DOP853", rtol=rtol, atol=atol)
        if not first.success:
            raise EphemerisPreparationError("Failed to propagate the input state to the environment coverage start: " + first.message)
        state_at_minimum = first.y[:, -1]
    solution = solve_ivp(
        equations,
        (minimum, maximum),
        state_at_minimum,
        method="DOP853",
        rtol=rtol,
        atol=atol,
        dense_output=True,
    )
    if not solution.success or solution.sol is None:
        raise EphemerisPreparationError("Orbit propagation failed: " + solution.message)
    return solution


def _rotation_error_angle(reference: np.ndarray, candidate: np.ndarray) -> float:
    relative = reference.T @ candidate
    return math.acos(float(np.clip((np.trace(relative) - 1.0) / 2.0, -1.0, 1.0)))


def _validate_interpolation(
    nodes: np.ndarray,
    positions: np.ndarray,
    rotations: np.ndarray,
    sun_directions: np.ndarray,
    solution: Any,
    start: Time,
    eop: iers.IERS_A,
    kernel: SPK,
    duration: float,
) -> dict[str, float]:
    candidates = np.unique(np.concatenate((nodes[:-1] + 0.5 * np.diff(nodes), np.linspace(0.0, duration, 97))))
    candidates = candidates[(candidates >= 0.0) & (candidates <= duration)]
    direct_state = solution.sol(candidates).T
    position_interpolators = [Akima1DInterpolator(nodes, positions[:, i]) for i in range(3)]
    interpolated_position = np.column_stack([item(candidates) for item in position_interpolators])
    interpolated_velocity = np.column_stack([item.derivative()(candidates) for item in position_interpolators])
    position_error = np.linalg.norm(interpolated_position - direct_state[:, :3], axis=1)
    velocity_error = np.linalg.norm(interpolated_velocity - direct_state[:, 3:], axis=1)
    rotation_interpolators = [[Akima1DInterpolator(nodes, rotations[:, i, j]) for j in range(3)] for i in range(3)]
    interpolated_rotation = np.empty((len(candidates), 3, 3))
    for i in range(3):
        for j in range(3):
            interpolated_rotation[:, i, j] = rotation_interpolators[i][j](candidates)
    direct_rotation, _, _, _ = _earth_orientation(add_physical_seconds(start, candidates), eop)
    orthogonality = np.max(np.linalg.norm(np.transpose(interpolated_rotation, (0, 2, 1)) @ interpolated_rotation - np.eye(3), axis=(1, 2)))
    determinant = np.max(np.abs(np.linalg.det(interpolated_rotation) - 1.0))
    rotation_angle = max(_rotation_error_angle(direct_rotation[i], interpolated_rotation[i]) for i in range(len(candidates)))
    sun_interpolators = [Akima1DInterpolator(nodes, sun_directions[:, i]) for i in range(3)]
    interpolated_sun = np.column_stack([item(candidates) for item in sun_interpolators])
    interpolated_sun /= np.linalg.norm(interpolated_sun, axis=1)[:, None]
    times = add_physical_seconds(start, candidates)
    earth = _spk_position(kernel, "earth", times)
    direct_sun = _spk_position(kernel, "sun", times) - earth - direct_state[:, :3]
    direct_sun /= np.linalg.norm(direct_sun, axis=1)[:, None]
    sun_angle = np.max(np.arccos(np.clip(np.sum(interpolated_sun * direct_sun, axis=1), -1.0, 1.0)))
    return {
        "maxPositionError_m": float(np.max(position_error)),
        "maxVelocityError_m_s": float(np.max(velocity_error)),
        "maxEarthRotationAngleError_arcsec": float(rotation_angle / ARCSEC_RAD),
        "maxEarthRotationOrthogonalityError": float(orthogonality),
        "maxEarthRotationDeterminantError": float(determinant),
        "maxSunDirectionError_arcsec": float(sun_angle / ARCSEC_RAD),
    }


def _write_modelica_table(path: Path, table: np.ndarray) -> None:
    header = [
        "#1",
        f"# time_s, r_GCRS_m[3], sun_direction_GCRS[3], ITRS_basis_in_GCRS row-major[9]",
        f"double environment({table.shape[0]},{table.shape[1]})",
    ]
    with path.open("w", encoding="ascii", newline="\n") as stream:
        stream.write("\n".join(header) + "\n")
        np.savetxt(stream, table, fmt="%.16e")


def prepare_environment(config: dict[str, Any], output_dir: Path) -> dict[str, Any]:
    settings: ResourceSettings = config["resources"]
    configure_astropy(settings.leap_seconds_path)
    for path in (settings.spk_path, settings.iers_path, settings.leap_seconds_path):
        if not path.is_file():
            raise EphemerisPreparationError(f"Required fixed resource is missing: {path}")
    if settings.propagation_model != "J2SunMoon":
        raise EphemerisPreparationError(f"Unsupported propagation model {settings.propagation_model!r}")
    start: Time = config["start_time"]
    state_epoch: Time = config["state_epoch"]
    duration = float(config["duration_seconds"])
    epoch_offset = float((state_epoch.tai - start.tai).to_value(u.s))
    requested_interval = float(settings.sample_interval)
    if requested_interval <= 0 or abs(duration / requested_interval - round(duration / requested_interval)) > 1e-9:
        raise EphemerisPreparationError("EnvironmentSampleInterval must divide Duration within floating-point tolerance")
    initial_state = np.asarray(config["initial_state"], dtype=float)
    initial_elements = state_to_keplerian(initial_state)
    margin = requested_interval
    minimum = min(-margin, epoch_offset)
    maximum = max(duration + margin, epoch_offset)
    coverage_times = add_physical_seconds(start, np.array([minimum - 300.0, maximum + 300.0]))
    kernel = SPK.open(str(settings.spk_path))
    required_segments = [kernel[0, 3], kernel[3, 399], kernel[0, 10], kernel[3, 301]]
    coverage_jd = [max(item.start_jd for item in required_segments), min(item.end_jd for item in required_segments)]
    requested_jd = [float(np.min(coverage_times.tdb.jd)), float(np.max(coverage_times.tdb.jd))]
    if requested_jd[0] < coverage_jd[0] or requested_jd[1] > coverage_jd[1]:
        raise EphemerisPreparationError(f"SPK coverage {coverage_jd} does not cover requested TDB JD {requested_jd}")
    eop = iers.IERS_A.open(str(settings.iers_path))
    eop_info = _eop_status(eop, coverage_times, settings.allow_predicted_eop)
    sun_spline, moon_spline = _make_ephemeris_splines(kernel, start, minimum - 300.0, maximum + 300.0)
    pole_spline = _make_pole_spline(start, minimum - 300.0, maximum + 300.0, eop)
    equations = _dynamics(sun_spline, moon_spline, pole_spline)
    solution = _propagate(
        initial_state,
        epoch_offset,
        minimum,
        maximum,
        equations,
        settings.propagation_rtol,
        settings.propagation_atol_position,
        settings.propagation_atol_velocity,
    )
    tight = _propagate(
        initial_state,
        epoch_offset,
        minimum,
        maximum,
        equations,
        settings.propagation_rtol * 0.1,
        settings.propagation_atol_position * 0.1,
        settings.propagation_atol_velocity * 0.1,
    )
    convergence_times = np.linspace(0.0, duration, 49)
    convergence_error = np.max(np.linalg.norm(solution.sol(convergence_times)[:3].T - tight.sol(convergence_times)[:3].T, axis=1))
    if convergence_error > 1.0:
        raise EphemerisPreparationError(f"Tightened propagation differs by {convergence_error:.6g} m (>1 m)")
    interval = requested_interval
    validation: dict[str, float] = {}
    while True:
        nodes = np.arange(-interval, duration + interval * 1.5, interval)
        nodes[-1] = min(nodes[-1], duration + interval)
        states = solution.sol(nodes).T
        times = add_physical_seconds(start, nodes)
        earth = _spk_position(kernel, "earth", times)
        sun_vector = _spk_position(kernel, "sun", times) - earth - states[:, :3]
        sun_direction = sun_vector / np.linalg.norm(sun_vector, axis=1)[:, None]
        rotations, dut1, xp, yp = _earth_orientation(times, eop)
        validation = _validate_interpolation(nodes, states[:, :3], rotations, sun_direction, solution, start, eop, kernel, duration)
        if (
            validation["maxPositionError_m"] <= 10.0
            and validation["maxVelocityError_m_s"] <= 0.02
            and validation["maxEarthRotationAngleError_arcsec"] <= 1.0
        ):
            break
        if interval <= 1.0:
            raise EphemerisPreparationError("Environment interpolation validation failed at 1 s sampling: " + json.dumps(validation))
        interval = max(1.0, interval / 2.0)
    start_state = solution.sol(0.0)
    derived = state_to_keplerian(start_state)
    table = np.column_stack((nodes, states[:, :3], sun_direction, rotations.reshape(len(nodes), 9)))
    output_dir.mkdir(parents=True, exist_ok=True)
    table_path = output_dir / "environment.txt"
    _write_modelica_table(table_path, table)
    resource_hashes = {
        "spkSHA256": sha256(settings.spk_path),
        "iersSHA256": sha256(settings.iers_path),
        "leapSecondsSHA256": sha256(settings.leap_seconds_path),
    }
    cache_payload = {
        "startUTC": time_iso_utc(start),
        "durationSeconds": duration,
        "stateEpochUTC": time_iso_utc(state_epoch),
        "inputState": [float(value) for value in initial_state],
        "stateFrame": config["state_frame"],
        "stateInputMode": config["state_input_mode"],
        "model": settings.propagation_model,
        "requestedSampleInterval": requested_interval,
        "finalSampleInterval": interval,
        "resources": resource_hashes,
        "constants": {
            "muEarth_m3_s2": MU_EARTH,
            "earthRadius_m": EARTH_RADIUS,
            "J2": J2_EARTH,
            "muSun_m3_s2": MU_SUN,
            "muMoon_m3_s2": MU_MOON,
        },
    }
    cache_key = hashlib.sha256(json.dumps(cache_payload, sort_keys=True, separators=(",", ":")).encode("utf-8")).hexdigest()
    metadata = {
        **cache_payload,
        "cacheKey": cache_key,
        "endUTC": time_iso_utc(add_physical_seconds(start, duration)),
        "inputFrame": config["state_frame"],
        "internalFrame": "GCRS",
        "stateAtSimulationStart": [float(value) for value in start_state],
        "derivedElementsAtSimulationStart": derived,
        "spkCoverageTDB_JD": coverage_jd,
        "iers": eop_info,
        "tableRows": int(table.shape[0]),
        "tableColumns": int(table.shape[1]),
        "tableCoverageSeconds": [float(nodes[0]), float(nodes[-1])],
        "tableSHA256": sha256(table_path),
        "propagationConvergenceMaxPosition_m": float(convergence_error),
        "interpolationValidation": validation,
        "software": {
            "python": sys.version.split()[0],
            "numpy": np.__version__,
            "scipy": __import__("scipy").__version__,
            "astropy": __import__("astropy").__version__,
            "pyerfa": erfa.__version__,
            "jplephem": __import__("jplephem").__version__,
        },
        "sourceURLs": {
            "spk": "https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de440s.bsp",
            "iers": "https://datacenter.iers.org/data/9/finals2000A.all",
            "leapSeconds": "https://hpiers.obspm.fr/iers/bul/bulc/Leap_Second.dat",
        },
        "modelBoundary": "Given initial state propagated with central gravity, J2 and Sun/Moon third bodies; not a measured or precision-determined satellite ephemeris.",
    }
    (output_dir / "environment_metadata.json").write_text(json.dumps(metadata, ensure_ascii=False, indent=2), encoding="utf-8")
    kernel.close()
    return metadata
