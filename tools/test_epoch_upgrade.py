#!/usr/bin/env python3
"""Deterministic unit tests for the absolute-time and ephemeris upgrade."""

from __future__ import annotations

import math
import sys
import unittest
from datetime import datetime
from pathlib import Path

import astropy.units as u
import numpy as np
from astropy.time import Time
from astropy.utils import iers
from scipy.integrate import solve_ivp

TOOLS = Path(__file__).resolve().parent
ROOT = TOOLS.parent
if str(TOOLS) not in sys.path:
    sys.path.insert(0, str(TOOLS))

from prepare_ephemeris import (  # noqa: E402
    EARTH_RADIUS,
    MU_EARTH,
    EphemerisPreparationError,
    _earth_orientation,
    _eop_status,
    _spk_position,
    add_physical_seconds,
    configure_astropy,
    duration_seconds,
    keplerian_to_state,
    parse_absolute_time,
    state_to_keplerian,
    time_iso_utc,
)
from jplephem.spk import SPK  # noqa: E402


RESOURCE_DIR = ROOT / "Resources" / "Ephemeris"


class AbsoluteTimeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        configure_astropy(RESOURCE_DIR / "Leap_Second.dat")

    def test_standard_chinese_fullwidth_and_excel_datetime(self) -> None:
        expected = "2026-09-06T00:00:00.000Z"
        self.assertEqual(time_iso_utc(parse_absolute_time("2026-09-06 00:00:00", "UTC", "test")), expected)
        self.assertEqual(time_iso_utc(parse_absolute_time("2026年9月6日00：00：00", "UTC", "test")), expected)
        self.assertEqual(time_iso_utc(parse_absolute_time(datetime(2026, 9, 6), "UTC", "test")), expected)

    def test_timezone_and_explicit_offset(self) -> None:
        expected = "2026-09-05T16:00:00.000Z"
        self.assertEqual(time_iso_utc(parse_absolute_time("2026-09-06 00:00:00", "Asia/Shanghai", "test")), expected)
        self.assertEqual(time_iso_utc(parse_absolute_time("2026-09-06T00:00:00+08:00", "Asia/Shanghai", "test")), expected)
        with self.assertRaises(EphemerisPreparationError):
            parse_absolute_time("2026-09-06T00:00:00+08:00", "UTC", "test")

    def test_invalid_missing_and_dst_ambiguous_dates(self) -> None:
        with self.assertRaises(EphemerisPreparationError):
            parse_absolute_time("2026-02-30 00:00:00", "UTC", "test")
        with self.assertRaises(EphemerisPreparationError):
            parse_absolute_time("2026-09-06 00:00:00", "", "test")
        with self.assertRaises(EphemerisPreparationError):
            parse_absolute_time("2024-11-03 01:30:00", "America/New_York", "test")
        with self.assertRaises(EphemerisPreparationError):
            parse_absolute_time("2024-03-10 02:30:00", "America/New_York", "test")

    def test_leap_year_and_recorded_leap_second(self) -> None:
        self.assertEqual(
            time_iso_utc(parse_absolute_time("2024-02-29 12:00:00", "UTC", "test")),
            "2024-02-29T12:00:00.000Z",
        )
        leap = parse_absolute_time("2016-12-31T23:59:60", "UTC", "test")
        self.assertEqual(time_iso_utc(add_physical_seconds(leap, 2)), "2017-01-01T00:00:01.000Z")
        self.assertAlmostEqual((add_physical_seconds(leap, 2).tai - leap.tai).to_value(u.s), 2.0, places=10)

    def test_duration_units(self) -> None:
        self.assertEqual(duration_seconds(6, "h"), 21600.0)
        self.assertEqual(duration_seconds(24, "h"), 86400.0)
        self.assertEqual(duration_seconds(48, "h"), 172800.0)
        self.assertEqual(duration_seconds(15, "min"), 900.0)
        with self.assertRaises(EphemerisPreparationError):
            duration_seconds(0, "h")


class StateAndDynamicsTests(unittest.TestCase):
    def setUp(self) -> None:
        self.elements = {
            "semiMajorAxis": 6835361.4,
            "eccentricity": 0.002106700032949448,
            "inclination": 1.7005001741659893,
            "initialRAAN": 2.3704619932490054,
            "initialMeanAnomaly": 4.691670298595813,
            "argumentOfPerigee": 0.0,
        }

    def test_keplerian_migration_state_and_roundtrip(self) -> None:
        expected = np.array([
            -493801.273999,
            -752595.496556,
            -6776165.492715,
            -5490.252537677,
            5304.349223451,
            -172.811574358,
        ])
        state = keplerian_to_state(self.elements)
        np.testing.assert_allclose(state[:3], expected[:3], rtol=0.0, atol=1e-6)
        np.testing.assert_allclose(state[3:], expected[3:], rtol=0.0, atol=1e-9)
        recovered = state_to_keplerian(state)
        self.assertAlmostEqual(recovered["semiMajorAxis"], self.elements["semiMajorAxis"], delta=2e-6)
        self.assertAlmostEqual(recovered["eccentricity"], self.elements["eccentricity"], delta=2e-13)
        self.assertAlmostEqual(recovered["inclination"], self.elements["inclination"], delta=2e-13)
        self.assertAlmostEqual(recovered["raan"], self.elements["initialRAAN"], delta=2e-13)

    def test_invalid_cartesian_states_are_rejected(self) -> None:
        with self.assertRaises(EphemerisPreparationError):
            state_to_keplerian(np.array([EARTH_RADIUS - 1.0, 0, 0, 0, 7500, 0], dtype=float))
        with self.assertRaises(EphemerisPreparationError):
            state_to_keplerian(np.array([EARTH_RADIUS + 500000.0, 0, 0, 0, 0, 0], dtype=float))

    def test_two_body_reference_orbit(self) -> None:
        state0 = keplerian_to_state(self.elements)
        period = state_to_keplerian(state0)["period"]

        def rhs(_time: float, state: np.ndarray) -> np.ndarray:
            position = state[:3]
            return np.concatenate((state[3:], -MU_EARTH * position / np.linalg.norm(position) ** 3))

        solution = solve_ivp(rhs, (0.0, period), state0, method="DOP853", rtol=1e-11, atol=[1e-5] * 3 + [1e-8] * 3)
        self.assertTrue(solution.success)
        final = solution.y[:, -1]
        self.assertLess(np.linalg.norm(final[:3] - state0[:3]), 0.2)
        energy0 = np.dot(state0[3:], state0[3:]) / 2 - MU_EARTH / np.linalg.norm(state0[:3])
        energy1 = np.dot(final[3:], final[3:]) / 2 - MU_EARTH / np.linalg.norm(final[:3])
        h0 = np.cross(state0[:3], state0[3:])
        h1 = np.cross(final[:3], final[3:])
        self.assertLess(abs((energy1 - energy0) / energy0), 2e-10)
        self.assertLess(np.linalg.norm(h1 - h0) / np.linalg.norm(h0), 2e-10)


class EphemerisAndEarthOrientationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        configure_astropy(RESOURCE_DIR / "Leap_Second.dat")
        cls.eop = iers.IERS_A.open(str(RESOURCE_DIR / "finals2000A.all"))
        cls.kernel = SPK.open(str(RESOURCE_DIR / "de440s.bsp"))

    @classmethod
    def tearDownClass(cls) -> None:
        cls.kernel.close()

    def test_earth_center_is_not_emb(self) -> None:
        epoch = Time("2026-09-06T00:00:00", scale="utc")
        earth = _spk_position(self.kernel, "earth", epoch.reshape((1,)))[0]
        emb = np.asarray(self.kernel[0, 3].compute(epoch.tdb.jd1, epoch.tdb.jd2), dtype=float) * 1000.0
        self.assertGreater(np.linalg.norm(earth - emb), 1.0e6)

    def test_rotation_orthogonality_roundtrip_and_station_velocity(self) -> None:
        epoch = Time("2026-09-06T00:00:00", scale="utc")
        delta = 0.1
        epochs = add_physical_seconds(epoch, np.array([-delta, 0.0, delta]))
        rotations, _, _, _ = _earth_orientation(epochs, self.eop)
        rotation = rotations[1]
        rotation_rate = (rotations[2] - rotations[0]) / (2.0 * delta)
        self.assertLess(np.linalg.norm(rotation.T @ rotation - np.eye(3)), 1e-10)
        self.assertLess(abs(np.linalg.det(rotation) - 1.0), 1e-10)

        position_i = np.array([7000000.0, -1200000.0, 900000.0])
        velocity_i = np.array([1200.0, 7200.0, -400.0])
        position_e = rotation.T @ position_i
        velocity_e = rotation.T @ velocity_i - rotation.T @ rotation_rate @ position_e
        recovered_position = rotation @ position_e
        recovered_velocity = rotation_rate @ position_e + rotation @ velocity_e
        self.assertLess(np.linalg.norm(recovered_position - position_i), 1e-3)
        self.assertLess(np.linalg.norm(recovered_velocity - velocity_i), 1e-6)

        station_e = np.array([EARTH_RADIUS, 0.0, 0.0])
        analytical = rotation_rate @ station_e
        finite_difference = (rotations[2] @ station_e - rotations[0] @ station_e) / (2.0 * delta)
        self.assertLess(np.linalg.norm(analytical - finite_difference), 1e-9)

    def test_absolute_date_changes_sun_and_earth_orientation(self) -> None:
        first = Time("2026-09-06T00:00:00", scale="utc")
        second = Time("2026-12-06T00:00:00", scale="utc")
        times = Time([first, second])
        earth = _spk_position(self.kernel, "earth", times)
        sun = _spk_position(self.kernel, "sun", times) - earth
        sun /= np.linalg.norm(sun, axis=1)[:, None]
        self.assertLess(float(np.dot(sun[0], sun[1])), 0.5)
        rotations, _, _, _ = _earth_orientation(times, self.eop)
        self.assertGreater(np.linalg.norm(rotations[0] - rotations[1]), 0.1)

    def test_predicted_eop_gate(self) -> None:
        times = Time(["2026-09-06T00:00:00", "2026-09-07T00:00:00"], scale="utc")
        info = _eop_status(self.eop, times, True)
        self.assertEqual(info["label"], "PREDICTED")
        with self.assertRaises(EphemerisPreparationError):
            _eop_status(self.eop, times, False)


if __name__ == "__main__":
    unittest.main(verbosity=2)
