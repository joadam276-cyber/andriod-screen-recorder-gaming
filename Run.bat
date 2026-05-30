@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :runScrcpy
) else (
    goto :getAdmin
)

:getAdmin
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b

:runScrcpy
cd /d "%~dp0"
if not exist ".\Output" mkdir ".\Output"
set "t=%time: =0%"
set "timestamp=%date:~12,2%-%date:~4,2%-%date:~7,2%_%t:~0,2%-%t:~3,2%"
scrcpy --max-size=0 --max-fps=120 --video-bit-rate=64M --no-window --no-control --record=".\Output\Sc%timestamp%.mp4"