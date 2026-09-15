@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title NISSA 12U Configuration Update

echo ============================================================
echo NISSA 12U - Design Configuration Update
echo ============================================================
echo Project root: %CD%
echo.

set "STATUS_FILE=%CD%\UpdateConfig_last_status.txt"
set "EXCEL_FILE=%CD%\DesignConfig.xlsx"
set "SCRIPT_FILE=%CD%\tools\update_nissa_config.py"

> "%STATUS_FILE%" echo RUNNING

echo [1/5] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo [FAILED] The "python" command is not available.
    > "%STATUS_FILE%" echo FAILED - python command unavailable
    goto :FAIL
)
python --version
python -c "import sys; print('Python executable:', sys.executable)"
echo.

echo [2/5] Checking fixed Python dependencies...
python -c "import sys; sys.path.insert(0, r'tools\vendor'); import openpyxl, numpy, scipy, astropy, erfa, jplephem; print('openpyxl:', openpyxl.__version__); print('numpy:', numpy.__version__); print('scipy:', scipy.__version__); print('astropy:', astropy.__version__); print('pyerfa:', erfa.__version__); print('jplephem:', jplephem.__version__)"
if errorlevel 1 (
    echo [FAILED] One or more fixed Python dependencies cannot be imported.
    echo Run:
    echo   python -m pip install -r tools\requirements-ephemeris.txt
    echo The project-local tools\vendor\jplephem package is also required.
    > "%STATUS_FILE%" echo FAILED - Python dependency unavailable
    goto :FAIL
)
echo.

if not exist "%EXCEL_FILE%" (
    echo [FAILED] DesignConfig.xlsx was not found in the project root.
    > "%STATUS_FILE%" echo FAILED - DesignConfig.xlsx not found
    goto :FAIL
)

if not exist "%SCRIPT_FILE%" (
    echo [FAILED] tools\update_nissa_config.py was not found.
    > "%STATUS_FILE%" echo FAILED - updater script not found
    goto :FAIL
)

echo [3/5] Checking fixed ephemeris and Earth-orientation resources...
set "RESOURCE_MISSING=0"
if not exist "%CD%\Resources\Ephemeris\de440s.bsp" set "RESOURCE_MISSING=1"
if not exist "%CD%\Resources\Ephemeris\finals2000A.all" set "RESOURCE_MISSING=1"
if not exist "%CD%\Resources\Ephemeris\Leap_Second.dat" set "RESOURCE_MISSING=1"
if "%RESOURCE_MISSING%"=="1" (
    echo [FAILED] A fixed ephemeris or Earth-orientation resource is missing.
    echo See Resources\Ephemeris\SOURCE_MANIFEST.md for official sources and SHA-256 values.
    > "%STATUS_FILE%" echo FAILED - ephemeris resource missing
    goto :FAIL
)
echo Fixed resource set found.
echo.

echo [4/5] Updating NISSA configuration and environment table...
echo ------------------------------------------------------------
python "%SCRIPT_FILE%" --excel "%EXCEL_FILE%"
set "RC=%ERRORLEVEL%"
echo ------------------------------------------------------------
if not "%RC%"=="0" (
    echo [FAILED] Configuration updater returned error code %RC%.
    > "%STATUS_FILE%" echo FAILED - updater returned error code %RC%
    goto :FAIL
)
echo.

echo [5/5] Verifying generated files...
set "MISSING=0"
if not exist "%CD%\Scenarios\GeneratedSpacecraftDesignConfig.mo" (
    echo [MISSING] Scenarios\GeneratedSpacecraftDesignConfig.mo
    set "MISSING=1"
)
if not exist "%CD%\Scenarios\GeneratedScenario.mo" (
    echo [MISSING] Scenarios\GeneratedScenario.mo
    set "MISSING=1"
)
if not exist "%CD%\Scenarios\GeneratedMassProperties.mo" (
    echo [MISSING] Scenarios\GeneratedMassProperties.mo
    set "MISSING=1"
)
if not exist "%CD%\Simulation\CompleteMission.mo" (
    echo [MISSING] Simulation\CompleteMission.mo
    set "MISSING=1"
)
if not exist "%CD%\Resources\Data\GeneratedEphemeris\environment.txt" (
    echo [MISSING] Resources\Data\GeneratedEphemeris\environment.txt
    set "MISSING=1"
)
if not exist "%CD%\Resources\Data\GeneratedEphemeris\environment_metadata.json" (
    echo [MISSING] Resources\Data\GeneratedEphemeris\environment_metadata.json
    set "MISSING=1"
)

if "%MISSING%"=="1" (
    echo [FAILED] Required generated files are missing.
    > "%STATUS_FILE%" echo FAILED - generated file verification failed
    goto :FAIL
)

> "%STATUS_FILE%" echo SUCCESS
echo.
echo ============================================================
echo [SUCCESS] NISSA configuration update completed successfully.
echo ============================================================
echo Simulation entry:
echo   NISSA_12UCubeSat.Simulation.CompleteMission
echo.
echo Press any key to close this window...
pause >nul
exit /b 0

:FAIL
echo.
echo ============================================================
echo Configuration update did NOT complete successfully.
echo ============================================================
echo Status:
type "%STATUS_FILE%" 2>nul
echo.
echo Press any key to close this window...
pause >nul
exit /b 1
