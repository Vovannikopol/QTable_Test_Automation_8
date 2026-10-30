@echo off
chcp 65001 > nul
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
    py -3 -m venv .venv
    if errorlevel 1 goto :failed
)
".venv\Scripts\python.exe" -m pip install -r requirements-dev.txt
if errorlevel 1 goto :failed
".venv\Scripts\python.exe" -m playwright install chromium
if errorlevel 1 goto :failed
".venv\Scripts\python.exe" -m pytest -v --junitxml=artifacts/junit.xml
echo.
echo [QTable] Open artifacts\report.html for the report.
pause
exit /b 0
:failed
echo [QTable] Cannot prepare tests. Check Python and Internet access.
pause
exit /b 1
