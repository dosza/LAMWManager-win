#!/bin/bash
#Universidade federal de Mato Grosso
#Curso ciencia da computação
#AUTOR: Daniel Oliveira Souza
#Versao LAMW-INSTALL: 0.3.0-r16-03-2020
#Descrição: Este script configura o ambiente de desenvolvimento para o LAMW
#---------------------------------



#----ColorTerm
export VERDE=$'\e[1;32m' 
export AMARELO=$'\e[01;33m'
export SUBLINHADO='4'
export NEGRITO=$'\e[1m'
export VERMELHO=$'\e[1;31m'
export VERMELHO_SUBLINHADO=$'\e[1;4;31m'
export AZUL=$'\e[1;34m'
export NORMAL=$'\e[0m'

#--------------------------
export ROOT_LAMW="$HOMEDRIVE${HOMEPATH}\\LAMW" #DIRETORIO PAI DE TODO O AMBIENTE DE DESENVOLVIMENTO LAMW
export ANDROID_HOME=$ROOT_LAMW
ANDROID_SDK="$ANDROID_HOME\\sdk"
export LAMW4WINDOWS_HOME="$HOMEDRIVE\\LAMW4Windows"
export LAZ4ANDROID_STABLE_VERSION="2.0.0"
export LAZ4ANDROID_HOME="$LAMW4WINDOWS_HOME\\laz4android${LAZ4ANDROID_STABLE_VERSION}"
export LAZANDROID_HOME_CFG="${LAZ4ANDROID_HOME}\\config"
export FPC_STABLE_EXEC=$LAZ4ANDROID_HOME\\fpc\\3.0.4\\bin\\i386-win32

LAMW_INSTALL_VERSION="0.3.0-r16-03-2020"
LAMW_INSTALL_WELCOME=(
	"\t\tWelcome LAMW  Manager from MSYS2  version: [$LAMW_INSTALL_VERSION]\n"
	"\t\tPowerd by DanielTimelord\n"

)

export USE_LOCAL_ENV=0
export GDB_INDEX=0
export LAMW_MANAGER_PATH=$(dirname $0)

#Critical Functions to Translate Calls Bash to  WinCalls 
if [ -e "$HOMEDRIVE\\tools\\msys64\\usr\\bin" ]; then
	export PATH="$PATH:\\$HOMEDRIVE\\tools\\msys64\\usr\\bin" 
else
	if [ -e "$HOMEDRIVE\\tools\\msys32" ]; then
		export PATH="$PATH:$HOMEDRIVE\\tools\\msys32"
	fi
fi 

winCallfromPS(){
	if [ $USE_LOCAL_ENV = 0 ];  then
		if [ $FLAG_SCAPE = 1 ]; then
			echo -e "$*" > /tmp/pscommand.ps1
		else
			echo "$*" > /tmp/pscommand.ps1
		fi
		unix2dos /tmp/pscommand.ps1 2>/dev/null
		cat /tmp/pscommand.ps1;
		powershell.exe Set-ExecutionPolicy Bypass
		powershell.exe  /tmp/pscommand.ps1
	 else
		#this array of script powershellF
		pscommand_str=(
		"\$JAVA_HOME=\"$JAVA_HOME\""
		#"echo \$env:path"
		"\$env:PATH=\"$JAVA_EXEC_PATH\" + \$env:path"
		"$*"
		)
		for((i=0;i<${#pscommand_str[*]};i++))
		do
			if [ $i = 0 ]; then 
				echo "${pscommand_str[i]}" > /tmp/pscommand.ps1
			else
				echo "${pscommand_str[i]}" >> /tmp/pscommand.ps1
			fi
		done
		
		cat /tmp/pscommand.ps1
		powershell.exe Set-ExecutionPolicy Bypass
		powershell.exe  /tmp/pscommand.ps1
	fi
}


getWinEnvPaths(){
	command='$env:'
	command="$command$1"
	echo "$command" > /tmp/pscommand.ps1
	powershell.exe Set-ExecutionPolicy Bypass
	powershell.exe  /tmp/pscommand.ps1
}
#retorna a letra do drivewind
getSystemLetterDrivertoLinux(){
	aux=$1
	aux=${aux%:}  #remove ':' ao final da string  , expansão bash
	aux=$(echo $aux | tr 'A-Z' 'a-z' ) # converte para minuscula 
	letter=""
	for i in {a..z}  # for usando expansao 
	do
		if [ "$i" = "$aux" ] ; then  # condicao de parada 
			letter=$i
			break
		fi
	done
	echo $letter
}

getLinuxPath(){
	echo "$1" | sed   's|\\|\/|g'
}
#---------------------------------------------------------------
#GLOBAL VARIABLES 

export WINDOWS_CMD_WRAPPERS=1
export WGET_EXE=""
export NDK_URL=""
export NDK_ZIP_FILE=""
export ZULU_JDK_URL=""
export ZULU_JDK_ZIP=""
export ZULU_TMP_PATH=""
export USE_LOCAL_ENV=0
export LOCAL_ENV=""
export WIN_LOCAL_ENV=""

if [  $WINDOWS_CMD_WRAPPERS  = 1 ]; then
	echo "Please wait ..."
	if [ ! -e "$HOMEDRIVE${HOMEPATH}\\.android" ]; then 
		mkdir "$HOMEDRIVE${HOMEPATH}\\.android"
	fi
	echo ""  > "$HOMEDRIVE${HOMEPATH}\\.android\\repositories.cfg"
	which wget 
	if [ $? = 0 ]; then
		export WGET_EXE=$(which wget)
	else
		export WGET_EXEC="$HOMEDRIVE\\ProgramData\\chocolatey\\bin\\wget"
	fi
	
	export _7ZEXE="$HOMEDRIVE\\Program Files\\7-Zip\\7z"	
	export ARCH=$(arch)
	export OS_PREBUILD=""
	case "$ARCH" in
		"x86_64")
			
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_x64"
			export JAVA_EXEC_PATH="$HOMEDRIVE\\Program Files\\Zulu\\zulu-8\\bin"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys64\\tmp"
			#export USE_LOCAL_ENV=1
		;;
		"amd64")
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_x64"
			export JAVA_EXEC_PATH="$HOMEDRIVE\\Program Files\\Zulu\\zulu-8\\bin"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys64\\tmp"
			#export USE_LOCAL_ENV=1
		;;
		*)
			#export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys32"
			export OS_PREBUILD="windows"
			export WGET_EXE="/$HOMEDRIVE\\ProgramData\\chocolatey\\bin\\wget.exe"
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86.zip"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_i686.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_i686.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_i686"
			export JAVA_EXEC_PATH="$HOMEDRIVE\\Program Files\\Zulu\\zulu-8\\bin"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys32\\tmp"
			#export USE_LOCAL_ENV=1
		;;
	esac
	 #MSYS_TEMP != %temp%
	which git
	if [ $? != 0 ]; then
		export PATH="$PATH:$HOMEDRIVE\\Program Files\\Git\\bin"
	fi
fi

BARRA_INVERTIDA='\'
#------------ PATHS translated for windows------------------------------

#export WIN_CFG_PATH=""

#--------------------------------------------------------------------------
APT_OPT=""
export PROXY_SERVER="internet.cua.ufmt.br"
export PORT_SERVER=3128
PROXY_URL="http://$PROXY_SERVER:$PORT_SERVER"
export USE_PROXY=0
export SDK_TOOLS_URL="http://dl.google.com/android/repository/sdk-tools-windows-4333796.zip"
export SDK_TOOLS_VERSION="r26.1.1" 

export ANDROID_SDK_TARGET=28
export ANDROID_BUILD_TOOLS_TARGET="28.0.3"
export GRADLE_MIN_BUILD_TOOLS='27.0.3'

SDK_VERSION="28"
SDK_MANAGER_CMD_PARAMETERS=()
SDK_MANAGER_CMD_PARAMETERS2=()
SDK_MANAGER_CMD_PARAMETERS2_PROXY=()
SDK_LICENSES_PARAMETERS=()
SDK_MANAGER_CMD_PARAMETERS=(
	"platforms;android-$ANDROID_SDK_TARGET"
	"platform-tools" 
	"build-tools;$ANDROID_BUILD_TOOLS_TARGET" 
	"ndk-bundle" 
	"extras;android;m2repository"
	"build-tools;$GRADLE_MIN_BUILD_TOOLS"
)	
SDK_MANAGER_CMD_PARAMETERS2=(
	"android-$ANDROID_SDK_TARGET"
	"platform-tools"
	"build-tools-$ANDROID_BUILD_TOOLS_TARGET" 
	"extra-google-google_play_services"
	"extra-android-m2repository"
	"extra-google-m2repository"
	"extra-google-market_licensing"
	"extra-google-market_apk_expansion"
	"extra-google-usb_driver"
	"build-tools-$GRADLE_MIN_BUILD_TOOLS"
)
SDK_LICENSES_PARAMETERS=(--licenses )
LAZARUS4ANDROID_LNK="http://sourceforge.net/projects/laz4android/files/laz4android${LAZ4ANDROID_STABLE_VERSION}-FPC3.0.4.7z"
LAZARUS4ANDROID_ZIP="laz4android${LAZ4ANDROID_STABLE_VERSION}-FPC3.0.4.7z"

LAMW_SRC_LNK="http://github.com/jmpessoa/lazandroidmodulewizard"
LAMW_WORKSPACE_HOME="$HOMEDRIVE${HOMEPATH}\\Dev\\LAMWProjects"  #piath to lamw_workspace

GRADLE_HOME="$ANDROID_HOME\\gradle-4.4.1"
ANT_HOME="$ANDROID_HOME\\apache-ant-1.10.5"

GRADLE_CFG_HOME="$HOMEDRIVE${HOMEPATH}\\.gradle"
GRADLE_ZIP_LNK="https://services.gradle.org/distributions/gradle-4.4.1-bin.zip"
GRADLE_ZIP_FILE="gradle-4.4.1-bin.zip"
ANT_ZIP_LINK="http://archive.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip"
ANT_ZIP_FILE="apache-ant-1.10.5-bin.zip"

ADB_WIN_DRIVER_LINK="http://dl.adbdriver.com/upload/adbdriver.zip"
ADB_WIN_DRIVER_ZIP="adbdriver.zip"

FPC_ID_DEFAULT=0

export OLD_ANDROID_SDK=1
export NO_GUI_OLD_SDK=0
export LAMW_INSTALL_STATUS=0
export LAMW_IMPLICIT_ACTION_MODE=0
export FLAG_SCAPE=0
#help of lamw
lamw_opts=(
	"syntax:\n"
	"bash simple-lamw-install.sh\tor\t./lamw_manger\t${NEGRITO}[actions]${NORMAL} ${VERDE}[options]${NORMAL}\n"
	"${NEGRITO}Usage${NORMAL}:\n"
	"\t${NEGRITO}bash simple-lamw-install.sh${NORMAL}                              Install LAMW and dependecies¹\n"
	"\tbash simple-lamw-install.sh\t${VERDE}--sdkmanager${NORMAL}                Install LAMW and Run Android SDK Manager²\n"
	"\tbash simple-lamw-install.sh\t${VERDE}--update-lamw${NORMAL}               To just upgrade LAMW framework (with the latest version available in git)\n"
	"\tbash simple-lamw-install.sh\t${VERDE}--reset${NORMAL}                     To clean and reinstall\n"
	"\tbash simple-lamw-install.sh\t${NEGRITO}uninstall${NORMAL}                   To uninstall LAMW :(\n"
	"\tbash simple-lamw-install.sh\t${VERDE}--help${NORMAL}                      Show help\n"                 
	"\n"
	"${NEGRITO}Proxy Options:${NORMAL}\n"
	"\tbash simple-lamw-install.sh ${NEGRITO}[action]${NORMAL}  --use_proxy --server ${VERDE}[HOST]${NORMAL} --port ${VERDE}[NUMBER]${NORMAL}\n"
	"sample:\n\tbash simple-lamw-install.sh --update-lamw --use_proxy --server 10.0.16.1 --port 3128\n"
	"\n\n${NEGRITO}Note:\n${NORMAL}"
	"\t¹ By default the installation waives the use of parameters, if LAMW is installed, it will only be updated!\n"
	"\t² If it is already installed, just run the Android SDK Tools\n"
	"\n"
	
)

#Flag tratador de sinal 
magicTrapIndex=-1 
#remove /bin of JAVA_HOME
JAVA_HOME=${JAVA_EXEC_PATH%'\bin'}
#atalhos pro menu iniciar

LAMW_MENU_PATH="$HOMEDRIVE\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\LAMW4Windows"

#Rotina que trata control+c
TrapControlC(){
	sdk_tools_zip=$ANDROID_SDK
	#echo "magicTrapIndex=$magicTrapIndex";read
	magic_trap=(
		"$ANT_TAR_FILE" #0 
		"$ANT_HOME"		#1
		"$GRADLE_ZIP_FILE" #2
		"$GRADLE_HOME"   #3
		"$sdk_tools_zip" #4
		"$ANDROID_SDK\\tools" #5
		"android-ndk-r18b-linux-x86_64.zip" #6
		"android-ndk-r18b" #7
	)
	
	if [ "$magicTrapIndex" != "-1" ]; then
		file_deleted="${magic_trap[magicTrapIndex]}"
		if [ -e "$file_deleted" ]; then
			echo "deleting... $file_deleted"
			rm  -rv $file_deleted
		fi
	fi
	exit 2
}
installJava(){
	#if [ "$ARCH" != "x86_64" ]; then
		#pwd;read;
		changeDirectory "$HOMEDRIVE\\Program Files"
		if [ ! -e "$HOMEDRIVE\\Program Files\\Zulu" ]; then
			mkdir -p "$HOMEDRIVE\\Program Files\\Zulu"
		fi
		changeDirectory "$HOMEDRIVE\\Program Files\\Zulu"

		if [ ! -e "zulu-8" ]; then
			$WGET_EXE -c "$ZULU_JDK_URL"
			if [ $? != 0 ]; then
				$WGET_EXE -c "$ZULU_JDK_URL"
				if [ $? != 0 ]; then
					echo "possible network instability! Try later!"
					exit 1
				fi
			fi
			unzip "$ZULU_JDK_ZIP"
			mv "$ZULU_TMP_PATH" "zulu-8"
			rm $ZULU_JDK_ZIP
			export PATH=$PATH:$JAVA_EXEC_PATH
			java -version
		else
			export PATH=$PATH:$JAVA_EXEC_PATH
			java -version
		fi
}
getTerminalDeps(){
	pacman -Syy  unzip dos2unix --noconfirm
	if [ $? != 0 ]; then 
		pacman -Syy  unzip  dos2unix --noconfirm
	fi
}
getImplicitInstall(){
	if [  -e  "$ANDROID_HOME\\lamw-install.log" ]; then
		printf "Checking the Android SDK version installed :"
		cat "$ANDROID_HOME\\lamw-install.log" |  grep "OLD_ANDROID_SDK=0"
		if [ $? = 0 ]; then
			export OLD_ANDROID_SDK=0
		else 
			export OLD_ANDROID_SDK=1
			export NO_GUI_OLD_SDK=1
		fi
		printf "Checking the LAMW Manager version :"
		cat "$ANDROID_HOME\\lamw-install.log" |  grep "Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION"
		if [ $? = 0 ]; then  
			echo "Only Update LAMW"
			export LAMW_IMPLICIT_ACTION_MODE=1 #apenas atualiza o lamw 
		else
			echo "You need upgrade your LAMW4Linux!"
			export LAMW_IMPLICIT_ACTION_MODE=0
		fi
	else
		export OLD_ANDROID_SDK=1 #obetem por padrão o old sdk 
		export NO_GUI_OLD_SDK=1
	fi
}
#--------------Win32 functions-------------------------

winMKLinkDir(){
	if [ $# = 2 ]; then
		if [ ! -e "$2" ]; then
			win_temp_path="$MSYS_TEMP\\winMKLink.bat"
			echo " /D $2 $1" > "$MSYS_TEMP\\winMKLink.bat" 
			winCallfromPS "$win_temp_path"
			if [ -e "$MSYS_TEMP\\winMKLink.bat"  ]; then
				rm  "$MSYS_TEMP\\winMKLink.bat" 
			fi
		fi
	fi
}
winMKLink(){
	if [ $# = 2 ]; then
		if [ ! -e "$2" ]; then
			local win_mklink="New-Item -ItemType SymbolicLink -Path \"$2\" -Target \"$1\""
			winCallfromPS "$win_mklink"
		fi
	fi
}
#this function delete a windows 
winRMDirf(){
	local rm_cmd_pwsh="try{\n\tif ( Test-Path \"$*\" ){\n\t\tRemove-Item \"$*\" -Force -Recurse\n\t}\n}catch{\n\t echo \"trying remove with cmd\"\n\tcmd.exe /c 'if exist \"$*\" ( rmdir \"$*\" /Q /S )'\n}\n"
	export FLAG_SCAPE=1
	winCallfromPS "$rm_cmd_pwsh"
	export FLAG_SCAPE=0

}
InstallWinADB(){
	changeDirectory "$ANDROID_HOME"
	if [ ! -e "adbdriver" ]; then 
		mkdir "adbdriver"
		changeDirectory "adbdriver" 
		$WGET_EXE -c "$ADB_WIN_DRIVER_LINK"
		if [ $? != 0 ]; then
			$WGET_EXE -c "$ADB_WIN_DRIVER_LINK"
		fi
			unzip "$ADB_WIN_DRIVER_ZIP"
		if [ -e "$ADB_WIN_DRIVER_ZIP" ]; then
			rm "$ADB_WIN_DRIVER_ZIP"
		fi
	fi

	if  [ -e "$ANDROID_HOME\\adbdriver" ]; then
		changeDirectory "$ANDROID_HOME\\adbdriver"
		printf "\n\n%s\n\n" "please conect your smartphone to PC and Install the ADBDriver ..."
		./ADBDriverInstaller.exe
	fi
}
getAnt(){
	changeDirectory "$ANDROID_HOME" 
	if [ ! -e "$ANT_HOME" ]; then
		magicTrapIndex=-1
		trap TrapControlC 2
		$WGET_EXE -c "$ANT_ZIP_LINK"

		if [ $? != 0 ] ; then
			$WGET_EXE -c "$ANT_ZIP_LINK"
			if [ $? != 0 ]; then 
				echo "possible network instability! Try later!"
				exit 1
			fi
		fi
		magicTrapIndex=1
		trap TrapControlC 2
		unzip "$ANT_ZIP_FILE"
	fi

	if [ -e  "$ANT_ZIP_FILE" ]; then
		rm "$ANT_ZIP_FILE"
	fi
}
getAndroidSDKToolsW32(){
	changeDirectory "$HOMEPATH"
	if [ ! -e "$ANDROID_HOME" ]; then
		mkdir "$ANDROID_HOME"
	fi
	
	changeDirectory "$ANDROID_HOME"
	if [ ! -e "$GRADLE_HOME" ]; then
		magicTrapIndex=-1
		trap TrapControlC 2
		$WGET_EXE -c "$GRADLE_ZIP_LNK"
		if [ $? != 0 ] ; then
			$WGET_EXE -c "$GRADLE_ZIP_LNK"
		fi
		magicTrapIndex=3
		trap TrapControlC 2
		unzip "$GRADLE_ZIP_FILE"
	fi

	if [ -e  "$GRADLE_ZIP_FILE" ]; then
		rm "$GRADLE_ZIP_FILE"
	fi
	
	if [ ! -e "sdk" ] ; then
		mkdir "sdk"
	fi
		changeDirectory "sdk"
		if [ ! -e "tools" ]; then  
			$WGET_EXE -c "$SDK_TOOLS_URL" #getting sdk 
			if [ $? != 0 ]; then 
				$WGET_EXE -c "$SDK_TOOLS_URL"
			fi
			unzip "sdk-tools-windows-4333796.zip"
		fi
		
		#mv "sdk-tools-windows-3859397" "tools"

		if [ -e "sdk-tools-windows-4333796.zip" ]; then
			rm  "sdk-tools-windows-4333796.zip"
		fi
	#fi
}
#Get Gradle and SDK Tools
getOldAndroidSDKToolsW32(){
	export SDK_TOOLS_VERSION="r25.2.5"
	export SDK_TOOLS_URL="http://dl.google.com/android/repository/tools_r25.2.5-windows.zip" 
	changeDirectory "$USER_DIRECTORY"
	if [ ! -e "$ANDROID_HOME" ]; then
		mkdir "$ANDROID_HOME"
	fi
	
	changeDirectory "$ANDROID_HOME"
	getAnt
	if [ ! -e "$GRADLE_HOME" ]; then
		magicTrapIndex=-1
		trap TrapControlC 2
		$WGET_EXE -c "$GRADLE_ZIP_LNK"
		if [ $? != 0 ] ; then
			#rm *.zip*
			$WGET_EXE -c "$GRADLE_ZIP_LNK"
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1
			fi 
		fi
		#echo "$PWD"
		#sleep 3
		magicTrapIndex=3
		trap TrapControlC 2
		unzip "$GRADLE_ZIP_FILE"
	fi
	
	if [ -e  "$GRADLE_ZIP_FILE" ]; then
		rm "$GRADLE_ZIP_FILE"
	fi
	#mkdir
	#changeDirectory $ANDROID_SDK
	if [ ! -e "$ANDROID_SDK" ] ; then
		mkdir "$ANDROID_SDK"
	fi
		changeDirectory "$ANDROID_SDK"
		if [ ! -e "$ANDROID_SDK\\tools" ]; then
			magicTrapIndex=-1
			trap TrapControlC 2  
			$WGET_EXE -c "$SDK_TOOLS_URL" #getting sdk 
			if [ $? != 0 ]; then 
				$WGET_EXE -c "$SDK_TOOLS_URL"
				if [ $? != 0 ]; then
					echo "possible network instability! Try later!"
					exit 1
				fi
			fi
			#./installer_r24.0.2-windows.exe
			magicTrapIndex=5
			trap TrapControlC 2 
			unzip "tools_r25.2.5-windows.zip"
			rm "tools_r25.2.5-windows.zip"
		fi

	#fi

	if [ ! -e "$ANDROID_SDK\\ndk-bundle" ]; then
		magicTrapIndex=-1
		changeDirectory "$ANDROID_SDK"
		trap TrapControlC 2 
		$WGET_EXE -c "$NDK_URL"
		if [ $? != 0 ]; then 
			$WGET_EXE -c "$NDK_URL"
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1
			fi
		fi
		magicTrapIndex=7
		trap TrapControlC 2 
		unzip $NDK_ZIP_FILE
		mv "android-ndk-r18b" "ndk-bundle"
		
		if [ -e "$NDK_ZIP_FILE" ]; then
			rm "$NDK_ZIP_FILE"
		fi
	fi
	trap - SIGINT  #removendo a traps
	magicTrapIndex=-1


}



winCallfromPS1(){
	args=($*)
	changeDirectory "/tmp"
	pscommand_str=(
		"\$JAVA_HOME=\"$JAVA_HOME\""
		#"echo \$env:path"
		"\$env:PATH=\"$JAVA_EXEC_PATH;\" + \$env:path"
		"\$SDK_MANAGER_FAILS=@(
		\"platform\",
		\"platform-tools\", 
		\"build-tools\", 
		\"extras\\google\\google-google_play_services\", 
		\"extras\\android\\m2repository\", 
		\"extras\\google\\market_licensing\", 
		\"extras\\google\\market_apk_expansion\"
		)"   
    	"\$SDK_MANAGER_CMD_PARAMETERS2=@( 
    	\"android-$ANDROID_SDK_TARGET\",
    	\"platform-tools\" ,
    	\"build-tools-$ANDROID_BUILD_TOOLS_TARGET\",
    	\"extra-google-google_play_services\",
    	\"extra-android-m2repository\",
    	\"extra-google-m2repository\",
    	\"extra-google-market_licensing\", 
    	\"extra-google-market_apk_expansion\",
    	\"build-tools-$GRADLE_MIN_BUILD_TOOLS\"
    	)"
    	"\$env:PATH=\"$ANDROID_SDK\\tools;\" + \$env:path"
    	#"echo \$env:path"
		"for(\$i=0; \$i -lt \$SDK_MANAGER_CMD_PARAMETERS2.Count; \$i++){"
		"	\$aux=\"${ANDROID_SDK}\tools\" + '\' + \$SDK_MANAGER_FAILS[\$i]"
    	"	echo y | android.bat \"update\" \"sdk\" \"--all\" \"--no-ui\" \"--filter\" \$SDK_MANAGER_CMD_PARAMETERS2[\$i] "
   		"	if ( \$? -eq \$false ){"
   		"		if ( Test-Path \$aux){"
       	"			rmdir -Recurse -Force \$aux"
       	"		}"
       	"		echo y | android.bat \"update\" \"sdk\" \"--all\" \"--no-ui\" \"--filter\" \$SDK_MANAGER_CMD_PARAMETERS2[\$i] "
       	"		if ( \$? -eq \$false ){"
   		"			if ( Test-Path \$aux){"
       	"				rmdir -Recurse -Force \$aux"
       	"			}"
       	"			exit 1"
       	"		}"
       	"	}"
   		"}"
	)
		for((i=0;i<${#pscommand_str[*]};i++))
		do
			if [ $i = 0 ]; then 
				echo "${pscommand_str[i]}" > "/tmp/pscommand.ps1"
			else
				echo "${pscommand_str[i]}" >> "/tmp/pscommand.ps1"
			fi
		done
	cat "/tmp/pscommand.ps1"
	#read
	powershell Set-ExecutionPolicy Bypass
	powershell "/tmp/pscommand.ps1"

}
	



#setJRE8 as default

# searchLineinFile(FILE *fp, char * str )
#$1 is File Path
#$2 is a String to search 
#this function return 0 if not found or 1  if found
searchLineinFile(){
	flag=0
	if [ "$1" != "" ];then
		if [ -e "$1" ];then
			if [ "$2" != "" ];then
				line="/dev/nullL"
				#file=$1
				while read line # read a line from
				do
					if [ "$line" = "$2" ];then # if current line is equal $2
						flag=1
						break #break loop 
					fi
				done < "$1"
			fi
		fi
	fi
	return $flag # return value 
}
#args $1 is str
#args $2 is delimeter token 
#call this function output=($(SplitStr $str $delimiter))
splitStr(){
	str=""
	token=""
	str_spl=()
	if [ "$1" != "" ] && [ "$2" != "" ] ; then 
		str="$1"
		delimeter=$2
		case "$delimeter" in 
			"/")
			str_spl=(${str//\// })
			echo "${str_spl[@]}"
			;;
			*)
				#if [ $(echo $str | grep [a-zA-Z0-9;]) = 0 ] ; then  # if str  regex alphanumeric
					str_spl=(${str//$delimeter/ })
					echo "${str_spl[@]}"
				#fi
			;;
		esac
	fi
}


#unistall java not supported


#iniciandoparametros
initParameters(){
	if [ $# = 1 ]; then  
		if [ "$1" = "--use_proxy" ] ;then
					USE_PROXY=1
		fi
	else
		if [ "$1" = "--use_proxy" ]; then 
			export USE_PROXY=1
			export PROXY_SERVER=$2
			export PORT_SERVER=$3
			export PROXY_URL="http://$2:$3"
			printf "PROXY_SERVER=$2\nPORT_SERVER=$3\n"
		fi
	fi

	if [ $USE_PROXY = 1 ]; then

		SDK_MANAGER_CMD_PARAMETERS[${#SDK_MANAGER_CMD_PARAMETERS[*]}]="--no_https"
		SDK_MANAGER_CMD_PARAMETERS[${#SDK_MANAGER_CMD_PARAMETERS[*]}]="--proxy=http" 
		SDK_MANAGER_CMD_PARAMETERS[${#SDK_MANAGER_CMD_PARAMETERS[*]}]="--proxy_host=$PROXY_SERVER"
		SDK_MANAGER_CMD_PARAMETERS[${#SDK_MANAGER_CMD_PARAMETERS[*]}]="--proxy_port=$PORT_SERVER" 

		SDK_MANAGER_CMD_PARAMETERS2_PROXY=(
			--no_https 
			#--proxy=http 
			--proxy-host=$PROXY_SERVER 
			--proxy-port=$PORT_SERVER 
		)
		SDK_LICENSES_PARAMETERS=( --licenses --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		export http_proxy=$PROXY_URL
		export https_proxy=$PROXY_URL
	fi
}


#GET LAMW FrameWork
getLAMWFramework(){
	changeDirectory "$ANDROID_HOME"
	export git_param=("clone" "$LAMW_SRC_LNK")
	if [ -e "$ANDROID_HOME\\lazandroidmodulewizard\\.git" ]  ; then
		changeDirectory "$ANDROID_HOME\\lazandroidmodulewizard"
		export git_param=("pull")
	fi
	
	git ${git_param[*]}
	if [ $? != 0 ]; then #case fails last command , try svn chekout
		
		export git_param=("clone" "$LAMW_SRC_LNK")
		cd $ANDROID_HOME
		winRMDirf "$ANDROID_HOME\\lazandroidmodulewizard"
		git ${git_param[*]}
		if [ $? != 0 ]; then 
			winRMDirf "$ANDROID_HOME\\lazandroidmodulewizard"
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
	
}



getSDKAndroid(){
	export USE_LOCAL_ENV=1
	#changeDirectory $ANDROID_SDK\\tools\\bin #change directory
	
	#   winCallfromPS1 "yes" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	# if [ $? != 0 ]; then 
	# 		winCallfromPS1 "yes" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	# 		if [ $? != 0 ]; then 
	# 			echo "possible network instability! Try later!"
	# 			exit 1
	# 		fi
	# fi

	#echo "len(SDK_MANAGER_CMD_PARAMETERS)=${#SDK_MANAGER_CMD_PARAMETERS[*]}";read;
	for((i=0;i<${#SDK_MANAGER_CMD_PARAMETERS[*]};i++))
	do
		echo "please wait... "
		 winCallfromPS1 "echo"  "y" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""  # instala sdk sem intervenção humana  

		if [ $? != 0 ]; then 
			winCallfromPS1 "echo" "y" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1;
			fi
		fi
	done
	export USE_LOCAL_ENV=0

}

getOldAndroidSDK(){

	if [ -e "$ANDROID_SDK\\tools\\android.bat"  ]; then 
		#echo "PWD=$PWD";read;
		export USE_LOCAL_ENV=1
		if [ $NO_GUI_OLD_SDK = 0 ]; then
			echo "--> Running Android SDK Tools manager"
			winCallfromPS "$ANDROID_SDK\\tools\\android.bat" "update" "sdk"
		else
			winCallfromPS1 
		fi
		export USE_LOCAL_ENV=0
	fi

}


WrappergetAndroidSDK(){
	if [ $WINDOWS_CMD_WRAPPERS = 1 ]; then 
		if [ $OLD_ANDROID_SDK =  0 ]; then
			getSDKAndroid
		else
			getOldAndroidSDK
		fi
	fi
}
WrappergetAndroidSDKTools(){
	if [ $WINDOWS_CMD_WRAPPERS = 1 ]; then
		if [ $OLD_ANDROID_SDK = 0 ]; then
			getAndroidSDKToolsW32
		else
			getOldAndroidSDKToolsW32
		fi
	fi 
	
}

#Build lazarus ide
getLazarus4Android(){
	if [ ! -e "$LAMW4WINDOWS_HOME" ]; then
		mkdir "$LAMW4WINDOWS_HOME"
	fi
	changeDirectory "$LAMW4WINDOWS_HOME"
	if [ ! -e "$LAZ4ANDROID_HOME" ]; then
		wget -c "$LAZARUS4ANDROID_LNK"
		if [ $? != 0 ]; then
			wget -c "$LAZARUS4ANDROID_LNK"
		fi
		"$_7ZEXE" x "$LAZARUS4ANDROID_ZIP"
		if [ -e "$LAZARUS4ANDROID_ZIP" ]; then
			rm "$LAZARUS4ANDROID_ZIP"
		fi
	fi
}
BuildLazarusIDE(){

	#changeDirectory $LAMW_IDE_HOME
	changeDirectory "$LAZ4ANDROID_HOME"
	if [ $# = 0 ]; then 
		#echo "aux=$aux";read
		local aux="$LAZ4ANDROID_HOME\\build.bat"
		winCallfromPS "$aux"
	fi
	changeDirectory "$HOMEDRIVE"
	local build_win_cmd="$HOMEDRIVE\\generate-lazarus.bat"

	LAZBUILD_PARAMETERS=(
		"--build-ide= --add-package \"$ANDROID_HOME\\lazandroidmodulewizard\\android_bridges\\tfpandroidbridge_pack.lpk\""
		"--build-ide= --add-package \"$ANDROID_HOME\\lazandroidmodulewizard\\android_wizard\\lazandroidwizardpack.lpk\""
		"--build-ide= --add-package \"$ANDROID_HOME\\lazandroidmodulewizard\\ide_tools\\amw_ide_tools.lpk\""
	)

	for((i=0;i< ${#LAZBUILD_PARAMETERS[@]};i++))
	do
		echo "BEFORE PATH=%PATH%" > "$build_win_cmd"
		echo "SET PATH=$LAZ4ANDROID_HOME;%PATH%" > "$build_win_cmd"
		echo "NOW %PATH%"
		echo "cd \"$LAZ4ANDROID_HOME\"" >> "$build_win_cmd"
		echo "lazbuild ${LAZBUILD_PARAMETERS[i]}" >> "$build_win_cmd"
		winCallfromPS "$HOMEDRIVE\\generate-lazarus.bat"
		if [ $? != 0 ]; then 
			winCallfromPS "$HOMEDRIVE\\generate-lazarus.bat"
		fi
		#prevent no exists lazarus (common bug)
		if [ ! -e "$LAZ4ANDROID_HOME\\lazarus.exe" ]; then
			winCallfromPS "taskkill /im make.exe /f" > /dev/null
			winCallfromPS "$HOMEDRIVE\\generate-lazarus.bat"
		fi

	done
	
	if [ -e "$build_win_cmd" ]; then
		"$build_win_cmd"
	fi
}

#this  fuction create a INI file to config  all paths used in lamw framework 

CreateLauncherLAMW(){
	
	if [ ! -e "$LAMW_MENU_PATH" ]; then
		mkdir "$LAMW_MENU_PATH"
	fi

	if [ -e "$LAMW_MENU_PATH\\LAMW4Windows.lnk" ]; then 
		rm "$LAMW_MENU_PATH\\LAMW4Windows.lnk"
	fi
	powershell_create_launcher=(
		"function CreateLauncher(){"
	    "	echo \$ARGS[0]"
	    "	echo \$ARGS[1]"
	    '	$wscript= New-Object -comObject WScript.Shell'
	    '	$atalho= $wscript.CreateShortcut($ARGS[1])'
	    '	$atalho.TargetPath = $ARGS[0]'
	    '	$atalho.iconLocation=$ARGS[2]'
	    '	$atalho.Save()'
	    '}'
	    ''
	    "\$lamw_path_target=\"$LAZ4ANDROID_HOME\\start-lamw.vbs\""
		"\$lamw_path_destination=\"$LAMW_MENU_PATH\\LAMW4Windows.lnk\""
		"\$lamw_icon_path=\"$LAZ4ANDROID_HOME\\images\\icons\\lazarus_orange.ico\""
		"CreateLauncher \$lamw_path_target \$lamw_path_destination \$lamw_icon_path"
	)

	for ((i=0; i < ${#powershell_create_launcher[*]};i++))
	do
		if [ $i = 0 ]; then
			echo "${powershell_create_launcher[i]}" > /tmp/createlauncher.ps1
		else
			echo "${powershell_create_launcher[i]}" >> /tmp/createlauncher.ps1
		fi
	done

	cat /tmp/createlauncher.ps1
	sleep 5
	powershell.exe Set-ExecutionPolicy Bypass
	powershell.exe  /tmp/createlauncher.ps1
	
}

LAMW4LinuxPostConfig(){
	old_lamw_workspace="$USER_DIRECTORY/Dev/lamw_workspace"
	if [ ! -e "$LAZANDROID_HOME_CFG" ] ; then
		mkdir "$LAZANDROID_HOME_CFG"
	fi

	if [ -e "$old_lamw_workspace" ]; then
		mv "$old_lamw_workspace" "$LAMW_WORKSPACE_HOME"
	fi
	if [ ! -e "$LAMW_WORKSPACE_HOME" ] ; then
		mkdir -p "$LAMW_WORKSPACE_HOME"
	fi

# contem o arquivo de configuração do lamw
	LAMW_init_str=(
		"[NewProject]"
		"PathToWorkspace=$LAMW_WORKSPACE_HOME"
		"PathToJavaTemplates=$ANDROID_HOME\\lazandroidmodulewizard\\android_wizard\\smartdesigner\\java"
		"PathToSmartDesigner=$ANDROID_HOME\\lazandroidmodulewizard\\android_wizard\\smartdesigner"
		"PathToJavaJDK=$JAVA_HOME"
		"PathToAndroidNDK=$ANDROID_SDK\\ndk-bundle"
		"PathToAndroidSDK=$ANDROID_SDK"
		"PathToAntBin=$ANT_HOME\\bin"
		"PathToGradle=$GRADLE_HOME"
		"PrebuildOSYS=$OS_PREBUILD"
		"MainActivity=App"
		"FullProjectName="
		"InstructionSet=1"
		"AntPackageName=org.lamw"
		"AndroidPlatform=0"
		"AntBuildMode=debug"
		"NDK=5"
		
	)

	lamw_loader_bat_str=(
		"@echo off"
		"SET PATH=$JAVA_EXEC_PATH;%PATH%"
		"cd \"$LAZ4ANDROID_HOME\""
		"SET JAVA_HOME=\"$JAVA_HOME\""
		'lazarus %*'
	)


	lamw_loader_vbs_str="CreateObject(\"Wscript.Shell\").Run  \"$LAZ4ANDROID_HOME\\lamw-ide.bat\",0,True"
	#escreve o arquivo LAMW.ini
	for ((i=0;i<${#LAMW_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${LAMW_init_str[i]}" > "$LAZANDROID_HOME_CFG\\LAMW.ini" 
		else
			echo "${LAMW_init_str[i]}" >> "$LAZANDROID_HOME_CFG\\LAMW.ini"
		fi
	done

	#escreve o arquivo lamw.bat que contém as variáveis de ambiente do lamw
	for ((i=0;i<${#LAMW_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${lamw_loader_bat_str[i]}" > "$LAZ4ANDROID_HOME\\lamw-ide.bat"
		else
			echo "${lamw_loader_bat_str[i]}" >>  "$LAZ4ANDROID_HOME\\lamw-ide.bat"
		fi
	done

	echo "$lamw_loader_vbs_str" >  "$LAZ4ANDROID_HOME\\start-lamw.vbs"
	unix2dos "$LAZ4ANDROID_HOME\\lamw-ide.bat" 2>/dev/null
	unix2dos "$WIN_PATH_LAZ4ANDROID_CFG\\LAMW.ini" 2>/dev/null
	winMKLink "$ANDROID_SDK\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK\\ndk-bundle\\toolchains\\mipsel-linux-android-4.9"
	winMKLink "$ANDROID_SDK\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK\\ndk-bundle\\toolchains\\mips64el-linux-android-4.9"
	CreateLauncherLAMW

}

#cd not a native command, is a systemcall used to exec, read more in exec man 
changeDirectory(){
	#echo "args=$# args=$*";read
	if [ $# = 1 ]; then 
		if [ "$1" != "" ] ; then
			if [ -e "$1"  ]; then
				cd "$1"
			fi
		fi
	else 
		path="$*"
		cd "$path"
	fi
}
#this code add support a proxy 



#this function remove old config of Laz4Lamw  
CleanOldConfig(){

	local root_java=$(dirname "$JAVA_HOME")
	local list_to_del=(
			"$ROOT_LAMW"
			"$root_java"
			"$HOMEPATH\\.android"
			"$LAMW_MENU_PATH"
			"$LAMW4WINDOWS_HOME"
			"$GRADLE_CFG_HOME"
	)
	winCallfromPS "taskkill /im adb.exe /f"    2>/dev/null
	winCallfromPS "taskkill /im java.exe /f"   2>/dev/null
	winCallfromPS "taskkill /im javac.exe /f"  2>/dev/null
	winCallfromPS "taskkill /im make.exe /f"   2>/dev/null

	for((i=0;i<${#list_to_del[*]};i++))
	do
		if [ -e "${list_to_del[i]}" ]; then 
			if [ -d "${list_to_del[i]}" ]; then 
				winRMDirf "${list_to_del[i]}"
				if [ $? != 0 ]; then
					echo "falls"
					rm -rf "${list_to_del[i]}"
				fi
			else
				rm "${list_to_del[i]}"
			fi
		fi
	done
}


#this function returns a version fpc 


#write log lamw install 
writeLAMWLogInstall(){
	lamw_log_str=(
		"Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" 
		"LAMW workspace : $WIN_LAMW_WORKSPACE_HOME" 
		"Android SDK:$ANDROID_HOME\sdk" 
		"Android NDK:$ANDROID_HOME\ndk" 
		"Gradle:$GRADLE_HOME" 
		"OLD_ANDROID_SDK=$OLD_ANDROID_SDK"
		"SDK_TOOLS_VERSION=$SDK_TOOLS_VERSION"
		"Install-date:$(date)"
	)
	for((i=0; i<${#lamw_log_str[*]};i++)) 
	do
		printf "%s\n"  "${lamw_log_str[i]}"
		if [ $i = 0 ] ; then 
			printf "%s\n" "${lamw_log_str[i]}" > "$ANDROID_HOME\\lamw-install.log"
		else
			printf "%s\n" "${lamw_log_str[i]}" >> "$ANDROID_HOME\\lamw-install.log" 
		fi
	done

	unix2dos "$ANDROID_HOME\\lamw-install.log" 2> /dev/null
}
getStatusInstalation(){
	if [  -e "$ANDROID_HOME\\lamw-install.log" ]; then
		#cat $LAMW4LINUX_HOME/lamw-install.log
		export LAMW_INSTALL_STATUS=1
		return 1

	else 
		#echo "not installed" >&2
		export OLD_ANDROID_SDK=1
		export NO_GUI_OLD_SDK=1
		return 0;
	fi
}
Repair(){
	flag_need_repair=0
	getStatusInstalation
	if [ $LAMW_INSTALL_STATUS = 1 ]; then
		if [ ! -e "$JAVA_HOME" ]; then
			installJava
		fi
		if [ ! -e "$LAZ4ANDROID_HOME" ]; then
			getLazarus4Android
			BuildLazarusIDE
			LAMW4LinuxPostConfig
		fi
	fi

}
mainInstall(){

	getTerminalDeps
	installJava
	WrappergetAndroidSDKTools
	WrappergetAndroidSDK
	getLazarus4Android
	getLAMWFramework
	BuildLazarusIDE
	changeDirectory "$ANDROID_HOME"
	LAMW4LinuxPostConfig
	InstallWinADB
	winCallfromPS "taskkill /im adb.exe /f" 2>/dev/null
	writeLAMWLogInstall
}

if  [  "$(whoami)" = "root" ] #impede que o script seja executado pelo root 
then
	echo "Error: this version  of LAMW4Linux was designed  to run without root priveleges" >&2 # >&2 is a file descriptor to /dev/stderror
	echo "Exiting ..."
	exit 1
fi
	echo "----------------------------------------------------------------------"
	printf "${LAMW_INSTALL_WELCOME[*]}"
	echo "----------------------------------------------------------------------"
	echo "LAMW Manager (Native Support:Linux supported Debian 9, Ubuntu 16.04 LTS, Linux Mint 18)
	Windows Compability (from MSYS2): Only Windows 8.1 and Windows 10"

	#configure parameters sdk before init download and build

	#Checa se necessario habilitar remocao forcada
	#checkForceLAMW4LinuxInstall $*

	if [ $# = 6 ] || [ $# = 7 ]; then
		if [ "$2" = "--use_proxy" ] ;then 
			if [ "$3" = "--server" ]; then
				if [ "$5" = "--port" ] ;then
					initParameters $2 $4 $6
				fi
			fi
		fi
	else
		initParameters $2
	fi
	#GenerateScapesStr
	

#Parameters are useful for understanding script operation
case "$1" in
	"version")
	echo "LAMW4Linux  version $LAMW_INSTALL_VERSION"
	;;
	"uninstall")
		export USE_LOCAL_ENV=0	
		CleanOldConfig
	 ;;
	 "--reset")
		CleanOldConfig
		export OLD_ANDROID_SDK=1
		export NO_GUI_OLD_SDK=1
		mainInstall
	;;
	"install")
			export OLD_ANDROID_SDK=1
			export NO_GUI_OLD_SDK=1
			mainInstall
	;;
	"update-lamw.ini")
		export OLD_ANDROID_SDK=1
		export NO_GUI_OLD_SDK=1
		LAMW4LinuxPostConfig
	;;
	
	"update-config")
		LAMW4LinuxPostConfig
	;;

	"--sdkmanager")
		getStatusInstalation;
		if [ $LAMW_INSTALL_STATUS = 1 ];then
			Repair
			echo "Starting Android SDK Manager...."
			export USE_LOCAL_ENV=1
			"$ANDROID_SDK\\tools\\android.bat" "update" "sdk"

		else
			mainInstall
			export USE_LOCAL_ENV=1
			"$ANDROID_SDK\\tools\\android.bat" "update" "sdk"
		fi 	
;;
	"--update-lamw")
		getStatusInstalation
		if [ $LAMW_INSTALL_STATUS = 1 ]; then
			Repair
			echo "Updating LAMW";
			getLAMWFramework "pull";
			BuildLazarusIDE "1";
		else
			mainInstall
		fi
	;;
	"")
		getImplicitInstall
		if [ $LAMW_IMPLICIT_ACTION_MODE = 0 ]; then
			echo "Please wait..."
			printf "${NEGRITO}Implicit installation of LAMW starting in 10 seconds  ... ${NORMAL}\n"
			printf "Press control+c to exit ...\n"
			sleep 10

			mainInstall
		else
			echo "Please wait ..."
			printf "${NEGRITO}Implicit LAMW Framework update starting in 10 seconds ... ${NORMAL}...\n"
			printf "Press control+c to exit ...\n"
			sleep 10 
			Repair
			echo "Updating LAMW";
			getLAMWFramework;
			BuildLazarusIDE "1";
		fi					
	;;
	"getlaz4android")
		getLazarus4Android
		BuildLazarusIDE
	;;
	*)
		printf "%b" "${lamw_opts[*]}"
	;;
	
esac
