
@echo true
SET ARCH="NONE"
echo "%ARCH%"
systeminfo | findstr "x64"
if "%ERRORLEVEL%" EQU "0"  ( SET ARCH="x64" ) else (set ARCH="x86" )
echo "%ARCH%"

powershell $PSVersionTable.PSVersion