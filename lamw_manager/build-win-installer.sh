#!/bin/bash
LAMW_MANAGER_PATH="/c/lamw_builder"
if [ ! -e $LAMW_MANAGER_PATH ]
then
	mkdir $LAMW_MANAGER_PATH
fi
	files=(
		"../Getting Started.txt"
		"tools/preinstall.bat"
		"tools/simple-lamw-install.sh"
		"tools/newinstaller.ps1"
		"tools/repair-msys.bat"
		"innosetup/lamw_manager.iss"
	)
	qt=${#files[*]}
	for((i=0;i<qt;i++))
	do 
		if [ -e "${files[i]}" ]; then
			cp "${files[i]}" $LAMW_MANAGER_PATH
		fi
	done

	if [ -e "C:\Program Files (x86)\Inno Setup 6" ]; then
		printf "\n\nBuild lamw_manager_setup.exe ...\n\n"
		"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "$LAMW_MANAGER_PATH\lamw_manager.iss"
		if [ -e "$LAMW_MANAGER_PATH\Output\lamw_manager_setup.exe" ]; then 
			cp "$LAMW_MANAGER_PATH\Output\lamw_manager_setup.exe" ./
		fi
	fi