@echo off
setlocal
cd /d "%~dp0"
python "%~dp0Scripts\run_acceptance.py" %*
exit /b %ERRORLEVEL%
