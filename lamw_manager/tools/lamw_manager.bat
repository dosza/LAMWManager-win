@echo off
SET BASH_PATH="C:\tools\msys64\usr\bin\bash.exe"

if exist %BASH_PATH% (goto :RunLAMWMgr ) else (goto :RestoreMsys)


:RestoreMsys
"%~dp0\repair-msys.bat"
"%~dp0\preinstall.bat"
goto :End


:RunLAMWMgr
echo %BASH_PATH%
"%BASH_PATH%" "%~dp0\simple-lamw-install.sh" %*
goto :End


:End
pause