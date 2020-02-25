choco uninstall mingw -y
choco uninstall msys2 -y
if exist "%HOMEDRIVE%\tools" ( rmdir /Q /S "%HOMEDRIVE%\tools" )
%~dp0\preinstall.bat
