@echo off
chcp 65001 > nul
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
    echo [QTable] Creating Python virtual environment...
    py -3 -m venv .venv
    if errorlevel 1 goto :failed
)
echo [QTable] Installing app requirements...
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto :failed
set SEED_DEMO_WAITER=1
set DATABASE_PATH=instance/qtable.sqlite3
echo.
echo [QTable] Open http://127.0.0.1:8000 in your browser.
echo [QTable] Press Ctrl+C to stop the server.
echo.
".venv\Scripts\python.exe" -m uvicorn app.main:app --host 127.0.0.1 --port 8000
pause
exit /b 0
:failed
echo [QTable] Setup failed. Check that Python 3.11+ is installed.
pause
exit /b 1
