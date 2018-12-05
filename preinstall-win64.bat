@echo off
REM ========================================================
SET MSYS_PROGS="msys2"						
SET FPC_EXE="C:\laz4android1.8\fpc\3.0.4\bin\i386-win32"
SET GIT_EXEC="C:\Program Files\Git\bin"
SET MSYS_EXEC="C:\tools\msys64\usr\bin"
SET FLAG_PATHS=-2
SET CHOCO_OPTS="--force"
REM ========================================================

echo "running laz4lamw installer to win64"
echo "install apt for windows ..."
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" Set-ExecutionPolicy AllSigned
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" Set-ExecutionPolicy Bypass
rem @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" "%HoMePath%/Downloads/LAMWAutoRunScripts-master/getMingw.ps1"



choco install mingw -y 
IF   %ERRORLEVEL% NEQ 0  choco install mingw -y --force 
choco install msys2  -y 
IF   %ERRORLEVEL% NEQ 0  choco install msys2  -y --force 
choco install git.install -y 
IF   %ERRORLEVEL% NEQ 0 choco install git.install -y --force 
choco install jdk8  -y  
IF   %ERRORLEVEL% NEQ 0 choco install jdk8  -y --force  
choco install 7zip.install -y  
IF   %ERRORLEVEL% NEQ 0 choco install 7zip.install -y --force  
choco install wget -y 
IF   %ERRORLEVEL% NEQ 0 choco install wget -y --force

SET exec_path="%HOMEDRIVE%""%HOMEPATH%\Downloads\LAMWAutoRunScripts-master"
cd %exec_path%
if not exist "%HOMEDRIVE%\laz4lamwpaths.txt"  SETX /M PATH "C:\laz4android1.8\fpc\3.0.4\bin\i386-win32;C:\tools\msys64\usr\bin;C:\Program Files\Git\bin;%PATH%"
if %errorlevel% EQU 0 echo "%PATH%" > "%HOMEDRIVE%\laz4lamwpaths.txt"
SET PATH=%MSYS_EXEC%;%PATH%
SET PATH=%GIT_EXEC%;%PATH%
SET PATH=%FPC_EXE%;%PATH%
rem start "%exec_path%\bridge-install-cmd-sh.bat"
pause 