@echo off
setlocal
cd /d "%~dp0"
python "%~dp0Scripts\update_transaction.py" %*
exit /b %ERRORLEVEL%
