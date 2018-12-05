if not exist "%HOMEDRIVE%\laz4lamwpaths.txt"  SETX /M PATH "%PATH%;C:\laz4android1.8\fpc\3.0.4\bin\i386-win32"
if not exist "%HOMEDRIVE%\laz4lamwpaths.txt"  SETX /M PATH "%PATH%;C:\tools\msys32\usr\bin"
if not exist "%HOMEDRIVE%\laz4lamwpaths.txt"  SETX /M PATH "%PATH%;C:\Program Files\Git\bin"
if %errorlevel% EQU 0 echo "%PATH%" > "%HOMEDRIVE%\laz4lamwpaths.txt"