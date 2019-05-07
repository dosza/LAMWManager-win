@echo off
REM ========================================================
SET exec_path="%HOMEDRIVE%""%HOMEPATH%\Downloads\LAMWAutoRunScripts-master"
cd %exec_path%
SET PATH=%exec_path%;%PATH%
echo %PATH%
echo %exec_path%
systeminfo | findstr x64-based
REM if %errorlevel% EQU 0 (preinstall-win64.bat) else (preinstall-win32.bat) 
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" Set-ExecutionPolicy Bypass
powershell newinstaller.ps1
pause