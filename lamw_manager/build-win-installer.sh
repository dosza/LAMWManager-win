#!/bin/bash
LAMW_MANAGER_PATH="/c/lamw_builder"
if [ ! -e $LAMW_MANAGER_PATH ]
then
	mkdir $LAMW_MANAGER_PATH
fi
	files=(
		"../Getting Started.txt"
		"tools/preinstall.bat"
		#"preinstall-win32.bat"
		#"preinstall-win64.bat"
		"tools/simple-lamw-install.sh"
		#"lamw_manager.bat"
		"tools/newinstaller.ps1"
		"tools/repair-msys.bat"
		"tools/repair-lamw4windows.bat"
		"innosetup/lamw_manager.iss"
	)
	qt=${#files[*]}
	for((i=0;i<qt;i++))
	do 
		if [ -e "${files[i]}" ]; then
			cp "${files[i]}" $LAMW_MANAGER_PATH
		fi
	done

	# file_str=()
	# i=0
	# str=""
	# while read str
	# do
	# 	#echo "str=$str"
	# 	echo "$str" | grep "SET exec_path="
	# 	if [ $? != 0 ]; then
	# 		file_str[i]=$str
	# 	else
	# 		bar='\'
	# 		aux="SET exec_path=%HOMEDRIVE%"
	# 		aux=$aux$bar
	# 		aux=$aux"lamw_manager"
	# 		file_str[i]=$aux
	# 		echo "aux=$aux"
	# 	fi
	# 	((i++))

	# done  < $LAMW_MANAGER_PATH/preinstall.bat
	# for((i=0;i<${#file_str[*]};i++))
	# do 
	# 	echo "i=$i ${file_str[i]}"
	# 	if [ $i = 0 ]; then
	# 		echo ${file_str[i]} > $LAMW_MANAGER_PATH/preinstall.bat
	# 	else
	# 		echo ${file_str[i]} >> $LAMW_MANAGER_PATH/preinstall.bat
	# 	fi
	# done
	# printf "%b" "${file_str[*]}"

	if [ -e "C:\Program Files (x86)\Inno Setup 6" ]; then
		printf "\n\nBuild lamw_manager_setup.exe ...\n\n"
		"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "$LAMW_MANAGER_PATH\lamw_manager.iss"
		if [ -e "$LAMW_MANAGER_PATH\Output\lamw_manager_setup.exe" ]; then 
			cp "$LAMW_MANAGER_PATH\Output\lamw_manager_setup.exe" ./
		fi
	fi