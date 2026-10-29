@echo off
title Spotify Automix Studio
echo ===================================================
echo   Spotify Automix Studio - Native DSP Acceleration
echo ===================================================
echo.
echo Starting Native DSP Server (NumPy, SciPy STFT, Viterbi Beat Tracking)...

start "SpotifyAutomixDSPEngine" /min python native_dsp_server.py

:: Give server a moment to bind port 8765
timeout /t 2 /nobreak >nul

:: Launch Desktop App Window using Edge or Chrome app mode
echo Launching Desktop Studio Window...
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" (
    start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --app=http://localhost:8765
) else if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --app=http://localhost:8765
) else (
    start http://localhost:8765
)

echo.
echo Studio is running at http://localhost:8765
echo (You can minimize this launcher window while using the studio)
