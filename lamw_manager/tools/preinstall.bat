@echo off
REM ========================================================
REM systeminfo | findstr x64-based
REM if %errorlevel% EQU 0 (preinstall-win64.bat) else (preinstall-win32.bat) 
powershell.exe Set-ExecutionPolicy Bypass
powershell %~dp0\newinstaller.ps1
pause