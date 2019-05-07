if not exist "C:\LAMW4Windows\laz4android2.0.0\lazarus.exe" (goto :BuildLazarus)


:BuildLazarus
echo "vazio"
taskkill /im make.exe /f
cd "C:\LAMW4Windows\laz4android2.0.0"
make clean
make