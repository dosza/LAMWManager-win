choco uninstall mingw -y
choco uninstall msys2 -y
if exist "%HOMEDRIVE%\tools\msys64" ( rmdir /Q /S "%HOMEDRIVE%\tools\msys64" )
if exist "%HOMEDRIVE%\tools\msys32" ( rmdir /Q /S "%HOMEDRIVE%\tools\msys32" )
%~dp0\preinstall.bat
