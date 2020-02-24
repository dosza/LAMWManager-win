@echo off
SET BASH_PATH="C:\tools\msys64\usr\bin\bash.exe"
cd C:\lamw_manager

if exist %BASH_PATH% (goto :RunLAMWMgr ) else (goto :RestoreMsys)


:RestoreMsys
C:\lamw_manager\repair-msys.bat
C:\lamw_manager\preinstall.bat
goto :End


:RunLAMWMgr
echo %BASH_PATH%
"%BASH_PATH%" simple-lamw-install.sh %*
goto :End


:End
pause