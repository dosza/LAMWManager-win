@echo off
REM ========================================================
SET FPC_EXE="C:\laz4android1.8\fpc\3.0.4\bin\i386-win32"
SET MSYS_EXEC="C:\tools\msys32\usr\bin"
SET GIT_EXEC="C:\Program Files\Git\bin"
SET FLAG_PATHS=-2
SET CHOCO_OPTS="--force"
REM ========================================================

echo "running laz4lamw installer to win32..."
echo "install apt for windows ..."
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" Set-ExecutionPolicy AllSigned
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"




choco install mingw -y 
IF   %ERRORLEVEL% NEQ 0  choco install mingw -y --force 
choco install msys2  -y 
IF   %ERRORLEVEL% NEQ 0  choco install msys2  -y --force 
choco install git.install -y 
IF   %ERRORLEVEL% NEQ 0 choco install git.install -y --force 
choco install jdk8  -y  
IF   %ERRORLEVEL% NEQ 0 choco install jdk8  -y --force  
choco install 7zip.install -y  
IF   %ERRORLEVEL% NEQ 0 choco install unzip -y --force 
choco install wget -y 
IF   %ERRORLEVEL% NEQ 0 choco install wget -y --force
if not exist "%HOMEDRIVE%\laz4lamwpaths.txt"  SETX /M PATH "C:\laz4android1.8\fpc\3.0.4\bin\i386-win32;C:\tools\msys32\usr\bin;C:\Program Files\Git\bin;%PATH%"
if %errorlevel% EQU 0 echo "%PATH%" > "%HOMEDRIVE%\laz4lamwpaths.txt"
SET PATH=%MSYS_EXEC%;%PATH%
SET PATH=%GIT_EXEC%;%PATH%
SET PATH=%FPC_EXE%;%PATH%
rem start bash simple-lamw-install.sh install 