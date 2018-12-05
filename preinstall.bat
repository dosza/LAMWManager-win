@echo off
REM ========================================================
SET exec_path="%HOMEDRIVE%""%HOMEPATH%\Downloads\LAMWAutoRunScripts-master"
cd %exec_path%
SET update_paths="%HOMEDRIVE%\ProgramData\chocolatey\bin"
echo %exec_path%
systeminfo | findstr x64-based
if %errorlevel% EQU 0 (preinstall-win64.bat) else (preinstall-win32.bat) 
pause