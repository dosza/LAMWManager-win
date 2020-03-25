#!/bin/bash
#Universidade federal de Mato Grosso
#Curso ciencia da computação
#AUTOR: Daniel Oliveira Souza
#Versao LAMW-INSTALL: 0.3.1-beta
#Descrição: Este script configura o ambiente de desenvolvimento para o LAMW
#=========================================================================================================

#----ColorTerm
export VERDE=$'\e[1;32m' 
export AMARELO=$'\e[01;33m'
export SUBLINHADO='4'
export NEGRITO=$'\e[1m'
export VERMELHO=$'\e[1;31m'
export VERMELHO_SUBLINHADO=$'\e[1;4;31m'
export AZUL=$'\e[1;34m'
export NORMAL=$'\e[0m'

export FLAG_FORCE_ANDROID_AARCH64=1

#Critical Functions to Translate Calls Bash to  WinCalls 
C_DRIVE=${HOMEDRIVE%:*} #replace :
C_DRIVE=/${C_DRIVE,,}	#letras em caixa baixa

if [ -e "${C_DRIVE}/tools/msys64/usr/bin" ]; then
	export PATH="${C_DRIVE}/tools/msys64/usr/bin:$PATH"
else
	if [ -e "${C_DRIVE}/tools/msys32" ]; then
		export PATH="${C_DRIVE}/tools/msys32/usr/bin:$PATH"
	fi
fi
export OLD_ROOT_LAMW=""
if [ -e "$PWD/simple-lamw-install.sh" ]; then
	LAMW_MANAGER_PATH=$(powershell.exe "cmd.exe /c echo %cd%" )
else
	tmp_cd(){ cd "$1" ; }
	tmp_cd $(dirname "$0" )
	LAMW_MANAGER_PATH=$(powershell.exe "cmd.exe /c echo %cd%" )
	unset tmp_cd
fi

if [ ! -e "$HOMEPATH\\LAMW" ]; then
	echo "${VERMELHO} Now  ROOT_LAMW=$LAMW_MANAGER_PATH\\LAMW${NORMAL}"
	export ROOT_LAMW="$LAMW_MANAGER_PATH\\LAMW" 	
	echo "$ROOT_LAMW"; sleep 3;
else
	export ROOT_LAMW="$HOMEDRIVE${HOMEPATH}\\LAMW" #DIRETORIO PAI DE TODO O AMBIENTE DE DESENVOLVIMENTO LAMW
fi

export ANDROID_HOME=$ROOT_LAMW
ANDROID_SDK="$ANDROID_HOME\\sdk"
export OLD_LAMW4WINDOWS_HOME="$HOMEDRIVE\\LAMW4Windows"
export LAMW4WINDOWS_HOME="$ROOT_LAMW\\LAMW4Windows"
export LAZ4ANDROID_STABLE_VERSION="2.0.0"
export LAZ4ANDROID_HOME="$LAMW4WINDOWS_HOME\\laz4android${LAZ4ANDROID_STABLE_VERSION}"
export LAMW_IDE_HOME="$LAZ4ANDROID_HOME"
export LAZANDROID_HOME_CFG="${LAZ4ANDROID_HOME}\\config"
export LAMW_IDE_HOME_CFG="$LAZANDROID_HOME_CFG"
export FPC_STABLE_EXEC=$LAMW_IDE_HOME\\fpc\\3.0.4\\bin\\i386-win32

LAMW_INSTALL_VERSION="0.3.1-beta"
LAMW_INSTALL_WELCOME=(
	"\t\tWelcome LAMW  Manager from MSYS2  version: [$LAMW_INSTALL_VERSION]\n"
	"\t\tPowerd by DanielTimelord\n"

)
  
export USE_LOCAL_ENV=0
export GDB_INDEX=0
JDK_VERSION="zulu8.44.0.11-ca-jdk8.0.242"
JAVA_VERSION="1.8.0_242"
export WINDOWS_CMD_WRAPPERS=1
export ZULU_TMP_PATH=""
export LOCAL_ENV=""
export WIN_LOCAL_ENV=""
if [  $WINDOWS_CMD_WRAPPERS  = 1 ]; then
	export ARCH=$(arch)
	export OS_PREBUILD=""
	case "$ARCH" in
		"x86_64")
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/${JDK_VERSION}-win_x64.zip"
			export ZULU_JDK_ZIP="${JDK_VERSION}-win_x64.zip"
			export ZULU_TMP_PATH="${JDK_VERSION}-win_x64"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys64\\tmp"
		;;
		"amd64")
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/${JDK_VERSION}-win_x64.zip"
			export ZULU_JDK_ZIP="${JDK_VERSION}-win_x64.zip"
			export ZULU_TMP_PATH="${JDK_VERSION}-win_x64"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys64\\tmp"
		;;
		*)
			export OS_PREBUILD="windows"
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86.zip"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/${JDK_VERSION}-win_i686.zip"
			export ZULU_JDK_ZIP="${JDK_VERSION}-win_i686.zip"
			export ZULU_TMP_PATH="${JDK_VERSION}-win_i686"
			export MSYS_TEMP="$HOMEDRIVE\\tools\\msys32\\tmp"
		;;
	esac
fi

BARRA_INVERTIDA='\'
PACMAN_LOCK="/var/lib/pacman/db.lck"
PROGR="unzip dos2unix subversion tar wget git p7zip"
export PROXY_SERVER="internet.cua.ufmt.br"
export PORT_SERVER=3128
PROXY_URL="http://$PROXY_SERVER:$PORT_SERVER"
export USE_PROXY=0
export SDK_TOOLS_URL="http://dl.google.com/android/repository/sdk-tools-windows-4333796.zip"
export SDK_TOOLS_VERSION="r26.1.1" 

export ANDROID_SDK_TARGET=28
export ANDROID_BUILD_TOOLS_TARGET="28.0.3"
export GRADLE_MIN_BUILD_TOOLS='27.0.3'

SDK_MANAGER_CMD_PARAMETERS2_PROXY=()
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

LAMW_PACKAGES=(
	"$ANDROID_HOME\\lazandroidmodulewizard\\android_bridges\\tfpandroidbridge_pack.lpk"
	"$ANDROID_HOME\\lazandroidmodulewizard\\android_wizard\\lazandroidwizardpack.lpk"
	"$ANDROID_HOME\\lazandroidmodulewizard\\ide_tools\\amw_ide_tools.lpk"
)

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

#Flag tratador de sinal 
MAGIC_TRAP_INDEX=-1
export OLD_JAVA_EXEC_PATH="$HOMEDRIVE\\Program Files\\Zulu\\zulu-8\\bin"
export JAVA_EXEC_PATH="$ROOT_LAMW\\jdk\\zulu-8\\bin"
export JAVA_HOME=${JAVA_EXEC_PATH%'\bin'} #remove /bin of JAVA_HOME

OLD_LAMW_MENU_PATH="$HOMEDRIVE\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\LAMW4Windows"
LAMW_MENU_PATH="$HOMEDRIVE${HOMEPATH}\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\LAMW4Windows"

export ARM_ANDROID_TOOLS="$ROOT_LAMW\\sdk\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9\\prebuilt\\$OS_PREBUILD\\bin"
#-------------------- AARCH64 SUPPORT HEADERS-------------------------------------------------------------
export AARCH64_ANDROID_TOOLS="$ROOT_LAMW\\sdk\\ndk-bundle\\toolchains\\aarch64-linux-android-4.9\\prebuilt\\$OS_PREBUILD\\bin"
export PATH="$ARM_ANDROID_TOOLS:$AARCH64_ANDROID_TOOLS:$PATH"
#https://wiki.freepascal.org/Multiple_Lazarus#Using_lazarus.cfg_file 
BINUTILS_URL="https://svn.freepascal.org/svn/fpcbuild/branches/fixes_3_2/install/binw32"
FPC_TRUNK_SOURCE_URL="https://svn.freepascal.org/svn/fpc/branches/fixes_3_2@43981"
FPC_TRUNK_VERSION=3.2.0-beta
_FPC_TRUNK_VERSION=3.2.0
FPC_TRUNK_SVNTAG=fixes_3_2
FPC_TRUNK_PARENT=$LAMW4WINDOWS_HOME\\fpc
FPC_TRUNK_PATH="$FPC_TRUNK_PARENT\\${_FPC_TRUNK_VERSION}"
FPC_TRUNK_SOURCE_PATH="$FPC_TRUNK_PATH\\source"
LAZARUS_STABLE_VERSION="2.0.6"
LAZARUS_STABLE=lazarus_${LAZARUS_STABLE_VERSION//\./_}
LAZARUS_STABLE_SRC_LNK="https://svn.freepascal.org/svn/lazarus/tags/$LAZARUS_STABLE"


#help of lamw
LAMW_OPTS=(
	"syntax:\n"
	"bash simple-lamw-install.sh\tor\t./lamw_manger\t${NEGRITO}[actions]${NORMAL} ${VERDE}[options]${NORMAL}\n"
	"${NEGRITO}Usage${NORMAL}:\n"
	"\t${NEGRITO}bash simple-lamw-install.sh${NORMAL}                              Install LAMW and dependencies¹\n"
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

#============================================================================================================================

#cd not a native command, is a systemcall used to exec, read more in exec man 
changeDirectory(){
	#echo "args=$# args=$*";read4
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

#==============================================================================================
#							Linux2Win32 translate (Call) functions
#----------------------------------------------------------------------------------------------

winCallfromPS(){
		if [ $FLAG_SCAPE = 1 ]; then
			echo -e "$*" > /tmp/pscommand.ps1
		else
			echo "$*" > /tmp/pscommand.ps1
		fi
		unix2dos /tmp/pscommand.ps1 2>/dev/null
		cat /tmp/pscommand.ps1; sleep 2
		powershell.exe Set-ExecutionPolicy Bypass
		powershell.exe  /tmp/pscommand.ps1
}


getLinuxPath(){
	local linux_path=$(echo "$1" | sed   's/://g' | sed 's|\\|\/|g')
	echo "/$linux_path"
}
#--------------Win32 functions-------------------------

winMKLinkDir(){
	if [ $# = 2 ]; then
		if [ ! -e "$2" ]; then
			local mklink_cmd_str="cmd.exe /c 'mklink /D \"$2\" \"$1\"" 
			winCallfromPS "$mklink_cmd_str"

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
	local try_rm="$*"
	local rm_cmd_pwsh="cmd.exe /c 'if exist \"${try_rm}\" ( rmdir \"${try_rm}\" /Q /S )'"
	winCallfromPS "$rm_cmd_pwsh"

}

#==========================================================================================================
#									LAMW Manager Core functions
#----------------------------------------------------------------------------------------------------------

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


	if [ $FLAG_FORCE_ANDROID_AARCH64 = 1 ]; then
		LAMW_IDE_HOME="$LAMW4WINDOWS_HOME\\$LAZARUS_STABLE"
		LAMW_IDE_HOME_CFG="$LAMW4WINDOWS_HOME\\.lamw4windows"
		FPC_STABLE_EXEC="${LAMW4WINDOWS_HOME}\\fpc\\3.0.4\\bin\\i386-win32"
		FPC_STABLE_ZIP="fpc-3.0.4-i386-win32.tar.xz"
		FPC_STABLE_URL="https://raw.githubusercontent.com/DanielOliveiraSouza/LAMW4Windows-installer/v0.3.1/lamw_manager/tools/fpc-3.0.4-i386-win32.tar.xz"
	fi
}

#Rotina que trata control+c
TrapControlC(){
	local sdk_tools_zip=$ANDROID_SDK
	#echo "MAGIC_TRAP_INDEX=$MAGIC_TRAP_INDEX";read
	local magic_trap=(
		"$ANT_TAR_FILE" #0 
		"$ANT_HOME"		#1
		"$GRADLE_ZIP_FILE" #2
		"$GRADLE_HOME"   #3
		"$sdk_tools_zip" #4
		"$ANDROID_SDK\\tools" #5
		"android-ndk-r18b-linux-x86_64.zip" #6
		"android-ndk-r18b" #7
	)
	
	if [ "$MAGIC_TRAP_INDEX" != "-1" ]; then
		local file_deleted="${magic_trap[MAGIC_TRAP_INDEX]}"
		if [ -e "$file_deleted" ]; then
			echo "deleting... $file_deleted"
			rm  -rv "$file_deleted"
		fi
	fi
	exit 2
}
#Get Linux common tools
getTerminalDeps(){
	pacman -Sy $PROGR --noconfirm
	if [ $? != 0 ]; then 
		rm -f "$PACMAN_LOCK"
		pacman  $PROGR -Syy  --noconfirm
	fi
}

getJDK(){
		WGET_EXE=$(which wget)
		local old_jdK_parent=$(dirname "$OLD_JAVA_EXEC_PATH" )
		local old_jdK_parent=$(dirname "$old_jdK_parent")
		local jdk_parent=$(dirname "$JAVA_HOME")

		if [ -e "$old_jdK_parent" ]; then
			winRMDirf "$old_jdK_parent"
		fi

		#remove old jdk version 
		if [ -e "$JAVA_EXEC_PATH" ]; then 
			cat "$JAVA_HOME\\release" | grep "$JAVA_VERSION"
			if [ $? != 0 ]; then 
				winRMDirf "$jdk_parent" 
			fi
		fi
		if [ ! -e "$jdk_parent" ]; then 
			mkdir -p "$jdk_parent"
		fi

		changeDirectory "$jdk_parent"

		if [ ! -e "zulu-8" ]; then
			"$WGET_EXE" -c "$ZULU_JDK_URL"
			if [ $? != 0 ]; then
				wget -c "$ZULU_JDK_URL"
				if [ $? != 0 ]; then
					echo "possible network instability! Try later!"
					exit 1
				fi
			fi
			unzip "$ZULU_JDK_ZIP"
			mv "$ZULU_TMP_PATH" "zulu-8"
			rm "$ZULU_JDK_ZIP"
			export PATH=$PATH:$JAVA_EXEC_PATH
			java -version
		else
			export PATH=$PATH:$JAVA_EXEC_PATH
			java -version
		fi
}

getImplicitInstall(){
	if [  -e  "$ANDROID_HOME\\lamw-install.log" ]; then
		printf "Checking the Android SDK version installed :"
		cat "$ANDROID_HOME\\lamw-install.log" |  grep "OLD_ANDROID_SDK=0" > /dev/null
		if [ $? = 0 ]; then
			export OLD_ANDROID_SDK=0
		else 
			export OLD_ANDROID_SDK=1
			export NO_GUI_OLD_SDK=1
		fi

		cat "$ANDROID_HOME\\lamw-install.log" |  grep "Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" > /dev/null
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


getAnt(){
	changeDirectory "$ANDROID_HOME" 
	if [ ! -e "$ANT_HOME" ]; then
		MAGIC_TRAP_INDEX=-1
		trap TrapControlC 2
		wget -c "$ANT_ZIP_LINK"

		if [ $? != 0 ] ; then
			wget -c "$ANT_ZIP_LINK"
			if [ $? != 0 ]; then 
				echo "possible network instability! Try later!"
				exit 1
			fi
		fi
		MAGIC_TRAP_INDEX=1
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
		MAGIC_TRAP_INDEX=-1
		trap TrapControlC 2
		wget -c "$GRADLE_ZIP_LNK"
		if [ $? != 0 ] ; then
			wget -c "$GRADLE_ZIP_LNK"
		fi
		MAGIC_TRAP_INDEX=3
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
			wget -c "$SDK_TOOLS_URL" #getting sdk 
			if [ $? != 0 ]; then 
				wget -c "$SDK_TOOLS_URL"
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
	changeDirectory "$HOMEPATH"
	if [ ! -e "$ANDROID_HOME" ]; then
		mkdir "$ANDROID_HOME"
	fi
	
	changeDirectory "$ANDROID_HOME"
	getAnt
	if [ ! -e "$GRADLE_HOME" ]; then
		MAGIC_TRAP_INDEX=-1
		trap TrapControlC 2
		wget -c "$GRADLE_ZIP_LNK"
		if [ $? != 0 ] ; then
			#rm *.zip*
			wget -c "$GRADLE_ZIP_LNK"
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1
			fi 
		fi
		#echo "$PWD"
		#sleep 3
		MAGIC_TRAP_INDEX=3
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
			MAGIC_TRAP_INDEX=-1
			trap TrapControlC 2  
			wget -c "$SDK_TOOLS_URL" #getting sdk 
			if [ $? != 0 ]; then 
				wget -c "$SDK_TOOLS_URL"
				if [ $? != 0 ]; then
					echo "possible network instability! Try later!"
					exit 1
				fi
			fi
			#./installer_r24.0.2-windows.exe
			MAGIC_TRAP_INDEX=5
			trap TrapControlC 2 
			unzip "tools_r25.2.5-windows.zip"
			rm "tools_r25.2.5-windows.zip"
		fi

	#fi

	if [ ! -e "$ANDROID_SDK\\ndk-bundle" ]; then
		MAGIC_TRAP_INDEX=-1
		changeDirectory "$ANDROID_SDK"
		trap TrapControlC 2 
		wget -c "$NDK_URL"
		if [ $? != 0 ]; then 
			wget -c "$NDK_URL"
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1
			fi
		fi
		MAGIC_TRAP_INDEX=7
		trap TrapControlC 2 
		unzip $NDK_ZIP_FILE
		mv "android-ndk-r18b" "ndk-bundle"
		
		if [ -e "$NDK_ZIP_FILE" ]; then
			rm "$NDK_ZIP_FILE"
		fi
	fi
	trap - SIGINT  #removendo a traps
	MAGIC_TRAP_INDEX=-1


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
		winCallfromPS "echo"  "y" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""  # instala sdk sem intervenção humana  

		if [ $? != 0 ]; then 
			winCallfromPS "echo" "y" "|" "$ANDROID_SDK\\tools\\bin\\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1;
			fi
		fi
	done

}

getOldAndroidSDK(){
	local sdk_manager_sdk_paths=(
		"$ANDROID_SDK\\platforms\\android-$ANDROID_SDK_TARGET"
		"$ANDROID_SDK\\platform-tools"
		"$ANDROID_SDK\\build-tools\\$ANDROID_BUILD_TOOLS_TARGET"
		"$ANDROID_SDK\\extras\\google\\google_play_services"  
		"$ANDROID_SDK\\extras\\android\\m2repository"
		"$ANDROID_SDK\\extras\\google\\m2repository" 
		"$ANDROID_SDK\\extras\\google\\market_licensing" 
		"$ANDROID_SDK\\extras\\google\\market_apk_expansion"
		"$ANDROID_SDK\\extras\\google\\usb_driver"
		"$ANDROID_SDK\\build-tools\\$GRADLE_MIN_BUILD_TOOLS"
	)
	if [ -e "$ANDROID_SDK\\tools\\android.bat"  ]; then 
		#echo "PWD=$PWD";read;
		if [ $NO_GUI_OLD_SDK = 0 ]; then
			echo "--> Running Android SDK Tools manager"
			"$ANDROID_SDK\\tools\\android.bat" "update" "sdk"
		else
			for((i=0;i<${#SDK_MANAGER_CMD_PARAMETERS2[*]};i++))
			do
				echo "Getting \"${SDK_MANAGER_CMD_PARAMETERS2[i]}\" ..."

				if [ ! -e "${sdk_manager_sdk_paths[i]}" ];then
					echo "y" |   "$ANDROID_SDK\\tools\\android.bat" update sdk --all --no-ui --filter ${SDK_MANAGER_CMD_PARAMETERS2[i]} ${SDK_MANAGER_CMD_PARAMETERS2_PROXY[*]}
					if [ $? != 0 ]; then
						echo "y" |   "$ANDROID_SDK\\tools\\android.bat" update sdk --all --no-ui --filter ${SDK_MANAGER_CMD_PARAMETERS2[i]} ${SDK_MANAGER_CMD_PARAMETERS2_PROXY[*]}
						if [ $? != 0 ]; then
							echo "possible network instability! Try later!"
							exit 1
						fi
					fi
				fi	
			done 
		fi
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
	if [ ! -e "$HOMEDRIVE${HOMEPATH}\\.android" ]; then 
		mkdir "$HOMEDRIVE${HOMEPATH}\\.android"
	fi

	echo ""  > "$HOMEDRIVE${HOMEPATH}\\.android\\repositories.cfg"
	winCallfromPS "cmd.exe /c 'attrib +h \"$HOMEDRIVE${HOMEPATH}\\.android\"'"
	unix2dos "${HOMEPATH}\\.android\\repositories.cfg" 2>/dev/null
	if [ $WINDOWS_CMD_WRAPPERS = 1 ]; then
		if [ $OLD_ANDROID_SDK = 0 ]; then
			getAndroidSDKToolsW32
		else
			getOldAndroidSDKToolsW32
		fi
	fi 
	
}


getLazarus4Android(){

	if [ -e "$OLD_LAMW4WINDOWS_HOME" ]; then
		if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then 
			mv "$OLD_LAMW4WINDOWS_HOME" "$LAMW4WINDOWS_HOME"
		else
			return 
		fi
	fi
	if [ ! -e "$LAMW4WINDOWS_HOME" ]; then
		mkdir -p "$LAMW4WINDOWS_HOME"
	fi
	changeDirectory "$LAMW4WINDOWS_HOME"
	if [ ! -e "$LAMW_IDE_HOME" ]; then
		wget -c "$LAZARUS4ANDROID_LNK"
		if [ $? != 0 ]; then
			wget -c "$LAZARUS4ANDROID_LNK"
		fi
		7z x "$LAZARUS4ANDROID_ZIP"
		if [ -e "$LAZARUS4ANDROID_ZIP" ]; then
			rm "$LAZARUS4ANDROID_ZIP"
		fi
	fi
}

BuildLaz4Android(){
	export PATH="$PATH:$FPC_STABLE_EXEC"
	changeDirectory "$LAMW_IDE_HOME"
	if [ $# = 0 ]; then 
		local aux="$LAMW_IDE_HOME\\build.bat"
		winCallfromPS "$aux"
	fi
	changeDirectory "$HOMEDRIVE"
	local build_win_cmd="$HOMEDRIVE\\generate-lazarus.bat"

	for((i=0;i<${#LAMW_PACKAGES[@]};i++))
	do
		./lazbuild --build-ide= --add-package "${LAMW_PACKAGES[i]}"
		if [ $? != 0 ]; then 
			./lazbuild  --build-ide= --add-package "${LAMW_PACKAGES[i]}"
		fi
		#prevent no exists lazarus (common bug)
		if [ ! -e "$LAMW_IDE_HOME\\lazarus.exe" ]; then
			winCallfromPS "taskkill /im make.exe /f" 2>/dev/null
			./lazbuild --build-ide= --add-package "${LAMW_PACKAGES[i]}"
		fi
	done
	
	if [ -e "$build_win_cmd" ]; then
		"$build_win_cmd"
	fi
}

InstallWinADB(){
	changeDirectory "$ANDROID_HOME"
	if [ ! -e "adbdriver" ]; then 
		mkdir "adbdriver"
		changeDirectory "adbdriver" 
		wget -c "$ADB_WIN_DRIVER_LINK"
		if [ $? != 0 ]; then
			wget -c "$ADB_WIN_DRIVER_LINK"
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
#this  fuction create a INI file to config  all paths used in lamw framework 
CreateLauncherLAMW(){
	
	if [ ! -e "$LAMW_MENU_PATH" ]; then
		mkdir "$LAMW_MENU_PATH"
	fi

	if [ -e "$LAMW_MENU_PATH\\LAMW4Windows.lnk" ]; then 
		rm "$LAMW_MENU_PATH\\LAMW4Windows.lnk"
	fi

	if [ -e "$OLD_LAMW_MENU_PATH\\LAMW4Windows.lnk" ]; then 
		rm "$OLD_LAMW_MENU_PATH\\LAMW4Windows.lnk"
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
	    "\$lamw_path_target=\"$LAMW_IDE_HOME\\start-lamw.vbs\""
		"\$lamw_path_destination=\"$LAMW_MENU_PATH\\LAMW4Windows.lnk\""
		"\$lamw_icon_path=\"$LAMW_IDE_HOME\\images\\icons\\lazarus_orange.ico\""
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



#this function remove old config of Laz4Lamw  
CleanOldConfig(){
	local old_java_root=$(dirname "$OLD_JAVA_EXEC_PATH" )
	local old_java_root=$(dirname "$old_java_root" )
	local root_java=$(dirname "$JAVA_HOME")
	local list_to_del=(
			"$ANDROID_SDK${BARRA_INVERTIDA}ndk-bundle${BARRA_INVERTIDA}toolchains${BARRA_INVERTIDA}mipsel-linux-android-4.9"
			"$ANDROID_SDK${BARRA_INVERTIDA}ndk-bundle${BARRA_INVERTIDA}toolchains${BARRA_INVERTIDA}mips64el-linux-android-4.9"
			"$OLD_LAMW4WINDOWS_HOME"
			"$ROOT_LAMW"
			"$old_java_root"
			"$root_java"
			"$OLD_LAMW_MENU_PATH"
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
					winRMDirf "${list_to_del[i]}"
				fi
			else
				rm "${list_to_del[i]}"
			fi
		fi
	done
}


#this function returns a version fpc 


#write log lamw install 
LAMW4LinuxPostConfig(){

	local instruction_set=1
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 1 ]; then 
		local instruction_set=2

		#ref:https://wiki.freepascal.org/Multiple_Lazarus#Multiple_Lazarus_instances
		echo "--pcp=${LAMW_IDE_HOME_CFG}" > "$LAMW_IDE_HOME\\lazarus.cfg"   
		
		unix2dos "$LAMW_IDE_HOME\\lazarus.cfg" 2>/dev/null
	fi

	local old_lamw_workspace="$HOMEPATH\\Dev\\lamw_workspace"
	if [ ! -e "$LAMW_IDE_HOME_CFG" ] ; then
		mkdir "$LAMW_IDE_HOME_CFG"
	fi

	if [ -e "$old_lamw_workspace" ]; then
		mv "$old_lamw_workspace" "$LAMW_WORKSPACE_HOME"
	fi
	if [ ! -e "$LAMW_WORKSPACE_HOME" ] ; then
		mkdir -p "$LAMW_WORKSPACE_HOME"
	fi

# contem o arquivo de configuração do lamw
	local lamw_init_str=(
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
		"InstructionSet=$instruction_set"
		"AntPackageName=org.lamw"
		"AndroidPlatform=0"
		"AntBuildMode=debug"
		"NDK=5"
		
	)

	local lamw_loader_bat_str=(
		"@echo off"
		"SET PATH=$JAVA_EXEC_PATH;%PATH%"
		"SET JAVA_HOME=\"$JAVA_HOME\""
		"\"$LAMW_IDE_HOME\\lazarus\" %*"
	)


	local lamw_loader_vbs_str="CreateObject(\"Wscript.Shell\").Run  \"$LAMW_IDE_HOME\\lamw-ide.bat\",0,True"
	#escreve o arquivo LAMW.ini
	for ((i=0;i<${#lamw_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${lamw_init_str[i]}" > "$LAMW_IDE_HOME_CFG\\LAMW.ini" 
		else
			echo "${lamw_init_str[i]}" >> "$LAMW_IDE_HOME_CFG\\LAMW.ini"
		fi
	done

	#escreve o arquivo lamw.bat que contém as variáveis de ambiente do lamw
	for ((i=0;i<${#lamw_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${lamw_loader_bat_str[i]}" > "$LAMW_IDE_HOME\\lamw-ide.bat"
		else
			echo "${lamw_loader_bat_str[i]}" >>  "$LAMW_IDE_HOME\\lamw-ide.bat"
		fi
	done

	echo "$lamw_loader_vbs_str" >  "$LAMW_IDE_HOME\\start-lamw.vbs"
	unix2dos "$LAMW_IDE_HOME_CFG\\LAMW.ini" 2>/dev/null
	unix2dos "$LAMW_IDE_HOME\\lamw-ide.bat" 2>/dev/null
	unix2dos "$LAMW_IDE_HOME\\start-lamw.vbs" 2>/dev/null
	winMKLink "$ANDROID_SDK\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK\\ndk-bundle\\toolchains\\mipsel-linux-android-4.9"
	winMKLink "$ANDROID_SDK\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK\\ndk-bundle\\toolchains\\mips64el-linux-android-4.9"
	CreateLauncherLAMW
}
writeLAMWLogInstall(){
	local lamw_log_str=(
		"Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" 
		"LAMW workspace : $LAMW_WORKSPACE_HOME" 
		"Android SDK:$ANDROID_SDK" 
		"Android NDK:$ANDROID_SDK\\ndk-bundle" 
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
			getJDK
		fi
		if [ ! -e "$LAMW_IDE_HOME" ]; then
			wrappergetLazAndroid
			wrapperBuildLazarusIDE
			LAMW4LinuxPostConfig
		fi
	fi

}

#--------------------------------------------------------------
#		AARCH64 FUNCTIONS


getFPCStable(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then 
		return
	fi

	if [ ! -e  "$LAMW4WINDOWS_HOME" ]; then 
		mkdir -p  "$LAMW4WINDOWS_HOME"
	fi

	changeDirectory "$LAMW4WINDOWS_HOME"
	if [ ! -e "$FPC_STABLE_EXEC" ]; then 
		if [ -e "$LAMW_MANAGER_PATH/$FPC_STABLE_ZIP" ]; then 
			tar -xvf "$LAMW_MANAGER_PATH/$FPC_STABLE_ZIP"
		else
			wget -c "$FPC_STABLE_URL"
			if [  $? != 0 ]; then 
				wget "$FPC_STABLE_URL"
				if [ $? != 0 ]; then
					echo "possible instability internet! Try later!"
					exit 1
				fi
			fi
			tar -xvf "$FPC_STABLE_ZIP"
			if [ -e "$FPC_STABLE_ZIP" ]; then 
				rm "$FPC_STABLE_ZIP"
			fi
		fi
		local fpc_stable_parent=$(dirname "$FPC_STABLE_EXEC" )
		echo "$fpc_stable_parent"
		local fpc_stable_parent=$(dirname "$fpc_stable_parent" )
		#echo "$fpc_stable_parent";read
		"${FPC_STABLE_EXEC}\\fpcmkcfg.exe" -d basepath="${fpc_stable_parent}" -o "$FPC_STABLE_EXEC\\fpc.cfg"
	fi
}
getFPCTrunkSources(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then 
		return 
	fi

	if [ ! -e "$LAMW4WINDOWS_HOME" ]; then
		mkdir "$LAMW_IDE_HOME"
	fi
	cd $LAMW4WINDOWS_HOME
	if [ ! -e "$FPC_TRUNK_SOURCE_PATH" ]; then
		mkdir -p $FPC_TRUNK_SOURCE_PATH
	fi

	cd "$FPC_TRUNK_SOURCE_PATH"
	svn checkout "$FPC_TRUNK_SOURCE_URL"
	if [ $? != 0 ]; then 
		winRMDirf "$FPC_TRUNK_SVNTAG"
		svn checkout "$FPC_TRUNK_SOURCE_URL"
		if [ $? != 0 ]; then
			echo "possible network instability! Try later!"
			winRMDirf "$FPC_TRUNK_SVNTAG"
			exit 1
		fi
	fi
}

BuildCrossAArch64(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then
		return 
	fi
	ln -s "$AARCH64_ANDROID_TOOLS\\aarch64-linux-android-as.exe" "$FPC_STABLE_EXEC\\aarch64-linux-android-as.exe"
	ln -s "$AARCH64_ANDROID_TOOLS\\aarch64-linux-android-ld.exe" "$FPC_STABLE_EXEC\\aarch64-linux-android-ld.exe"
	ln -s "$ARM_ANDROID_TOOLS\\arm-linux-androideabi-as.exe" "$FPC_STABLE_EXEC\\arm-linux-androideabi-as.exe"
	ln -s "$ARM_ANDROID_TOOLS\\arm-linux-androideabi-ld.exe" "$FPC_STABLE_EXEC\\arm-linux-androideabi-ld.exe"
	cd "$FPC_TRUNK_SOURCE_PATH/${FPC_TRUNK_SVNTAG}"
	make clean crossall crossinstall CPU_TARGET=aarch64 OS_TARGET=android OPT="-dFPC_ARMHF"  INSTALL_PREFIX="$FPC_TRUNK_PATH" #crosszipinstall
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC AARCH64/Android falls"
		exit 1;
	fi
	make clean crossall crossinstall CPU_TARGET=arm OPT="-dFPC_ARMEL" OS_TARGET=android CROSSOPT="-CpARMV7A -CfVFPV3" INSTALL_PREFIX="$FPC_TRUNK_PATH" #crosszipinstall
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC ARMv7/Android falls"
		exit 1;
	fi
}

BuildFPCTrunk(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then
		return 
	fi
	export PATH="$FPC_STABLE_EXEC:$PATH"
	cd "$FPC_TRUNK_SOURCE_PATH/${FPC_TRUNK_SVNTAG}"
	make clean all install OS_TARGET="win32" INSTALL_PREFIX="$FPC_TRUNK_PATH" #zipinstall
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC i386/Win32 falls"
		exit 1;
	fi
	BuildCrossAArch64
}

getBinults(){
	cd "$FPC_TRUNK_PATH\\bin\\i386-win32"
	binutils=(
		ar.exe as.exe cmp.exe cp.exe cpp.exe diff.exe dlltool.exe fp32.ico gcc.exe gdate.exe 
		gdb.exe gecho.exe ginstall.exe ginstall.exe.manifest gmkdir.exe grep.exe ld.exe 
		libexpat-1.dll make.exe mv.exe nm.exe objcopy.exe objdump.exe patch.exe 
		patch.exe.manifest pwd.exe rm.exe strip.exe unzip.exe windres.exe windres.h zip.exe
	)
	svn checkout $BINUTILS_URL binutils
	if [ $? != 0 ]; then 
		winRMDirf binutils
		svn checkout $BINUTILS_URL binutils
		if [ $? != 0 ]; then 
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
	cd binutils
	cp ${binutils[*]} "$FPC_TRUNK_PATH\\bin\\i386-win32"
	cd "$FPC_TRUNK_PATH\\bin\\i386-win32"
	#echo "debug getBinults";read
	winRMDirf "$FPC_TRUNK_PATH\\bin\\i386-win32\\binutils"
}

InitLazarusConfig(){
	if [ ! -e "$LAMW_IDE_HOME_CFG" ]; then
		mkdir "$LAMW_IDE_HOME_CFG"
	fi
	local lazarus_env_cfg_str=(
		'<?xml version="1.0" encoding="UTF-8"?>'
		'<CONFIG>'
		'	<EnvironmentOptions>'
		"	<LazarusDirectory Value=\"$LAMW_IDE_HOME\"/>"
		"	<CompilerFilename Value=\"$FPC_TRUNK_PATH\\bin\\i386-win32\\fpc.exe\"/>"
		"	<FPCSourceDirectory Value=\"$FPC_TRUNK_SOURCE_PATH\\$FPC_TRUNK_SVNTAG\"/>"
		"	</EnvironmentOptions>"
		"</CONFIG>"
	)

	local lazarus_env_cfg="$LAMW_IDE_HOME_CFG\\environmentoptions.xml"

	if [ ! -e  "$lazarus_env_cfg" ] ; then
		for((i=0;i<${#lazarus_env_cfg_str[*]};i++))
		do
			if [ $i = 0 ]; then 
				printf "%s\n" "${lazarus_env_cfg_str[i]}" > "$lazarus_env_cfg"
			else
				printf "%s\n" "${lazarus_env_cfg_str[i]}" >> "$lazarus_env_cfg"
			fi
		done
	fi
	unix2dos "$LAMW_IDE_HOME_CFG/environmentoptions.xml" 2>/dev/null
	winCallfromPS "cmd.exe /c 'attrib +h $LAMW_IDE_HOME_CFG'"
}

BuildLazarusIDE(){
	export PPC_CONFIG_PATH="$FPC_TRUNK_PATH\\bin\\i386-win32" 
	cd "$LAMW_IDE_HOME"
	export PATH="$FPC_TRUNK_PATH\\bin\\386-win32:$PATH"
	if [ $# = 0 ]; then 
		make clean all "PP=$FPC_TRUNK_PATH\\bin\\i386-win32\\ppc386.exe" 
	fi
	
	InitLazarusConfig
	for((i=0;i<${#LAMW_PACKAGES[*]};i++))
	do
		./lazbuild   --build-ide= --add-package ${LAMW_PACKAGES[i]} --pcp="$LAMW_IDE_HOME_CFG"
		if [ $? != 0 ]; then 
			./lazbuild --build-ide= --add-package ${LAMW_PACKAGES[i]} --pcp="$LAMW_IDE_HOME_CFG"
		fi
	done
}

#Run
ConfigureFPCTrunk(){
	local fpc_cfg_path="$FPC_TRUNK_PATH/bin/i386-win32/fpc.cfg"
	#if [ ! -e "$fpc_cfg_path" ]; then
		"$FPC_TRUNK_PATH\\bin\\i386-win32\\fpcmkcfg" -d basepath="$FPC_TRUNK_PATH" -o "$fpc_cfg_path"
	#fi
		#echo "$fpc_cfg_path";read
		#this config enable to crosscompile in fpc 
		fpc_cfg_str=(
			"#IFDEF ANDROID"
			"#IFDEF CPUARM"
			"-CpARMV7A"
			"-CfVFPV3"
			"-Xd"
			"-XParm-linux-androideabi-"
			"-Fl$ANDROID_HOME\\sdk\\ndk-bundle\\platforms\\android-${ANDROID_SDK_TARGET}\\arch-arm\\usr\\lib"
			"-FLlibdl.so"
			"-FD${ARM_ANDROID_TOOLS}"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget" #-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\*"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\rtl" #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/rtl'
			"#ENDIF"
			'#IFDEF CPUAARCH64'
			'-Xd'
			'-XPaarch64-linux-android- '
			"-Fl$ANDROID_HOME\\sdk\\ndk-bundle\\platforms\\android-${ANDROID_SDK_TARGET}\\arch-arm64\usr\lib"
			'-FLlibdl.so'
			"-FD${AARCH64_ANDROID_TOOLS}"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget" #-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\*"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\rtl" #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/rtl'
			'#ENDIF'
			"#ENDIF"
		)

		if [ -e "$fpc_cfg_path" ] ; then  # se exiir /etc/fpc.cfg
			cat $fpc_cfg_path | grep 'CPUAARCH64'
			if [ $? != 0 ]; then 
				for ((i = 0 ; i<${#fpc_cfg_str[@]};i++)) 
				do
					echo "${fpc_cfg_str[i]}" >>  "$fpc_cfg_path"
				done	
			fi
		fi

}

getLazarusSource(){
	cd "$LAMW4WINDOWS_HOME"
	svn checkout "$LAZARUS_STABLE_SRC_LNK" 
	if [ $? != 0 ]; then  #case fails last command , try svn chekout 
		winRMDirf "$LAZARUS_STABLE"
		#svn cleanup
		#changeDirectory $LAZ4LAMW_HOME
		svn checkout "$LAZARUS_STABLE_SRC_LNK"
		if [ $? != 0 ]; then 
			winRMDirf "$LAZARUS_STABLE"
			echo "possible network instability! Try later!"
			exit 1
		fi
		#svn revert -R  $LAMW_SRC_LNK
	fi
}



#----------------------------------------------------------------------------

wrappergetLazAndroid(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then
		getLazarus4Android
	else
		echo "${VERMELHO}Warning: Experimental AARCH64 Support!${NORMAL}"
		if [ -e "$OLD_LAMW4WINDOWS_HOME" ]; then
			winRMDirf "$OLD_LAMW4WINDOWS_HOME"
		fi

		if [ -e "$LAZ4ANDROID_HOME" ]; then 
			winRMDirf "$LAZ4ANDROID_HOME"
		fi

		getFPCStable
		getFPCTrunkSources
		getLazarusSource
		BuildFPCTrunk
		ConfigureFPCTrunk
		getBinults
	fi
}
wrapperBuildLazarusIDE(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then
		BuildLaz4Android $*
	else
		BuildLazarusIDE $*
	fi
}

mainInstall(){

	getTerminalDeps
	getJDK
	WrappergetAndroidSDKTools
	WrappergetAndroidSDK
	wrappergetLazAndroid
	getLAMWFramework
	wrapperBuildLazarusIDE
	changeDirectory "$ANDROID_HOME"
	LAMW4LinuxPostConfig
	InstallWinADB
	winCallfromPS "taskkill /im adb.exe /f" 2>/dev/null
	writeLAMWLogInstall
}

	echo "----------------------------------------------------------------------"
	printf "${LAMW_INSTALL_WELCOME[*]}"
	echo "----------------------------------------------------------------------"
	echo "LAMW Manager (Native Support:Linux supported Debian 9, Ubuntu 16.04 LTS, Linux Mint 18)
	Windows Compability (from MSYS2): Only Windows 8.1 and Windows 10"

	winCallfromPS "cmd.exe /c ver" | grep "6.1.760" 
	if [ $? = 0 ]; then
		echo -e  "Warning: ${VERMELHO}Windows 7 ended support!${NORMAL}\nRead more in:https://www.microsoft.com/en-US/windows/windows-7-end-of-life-support-information"
	fi
	echo "Please wait ..."

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
	# "update-lamw.ini")
	# 	export OLD_ANDROID_SDK=1
	# 	export NO_GUI_OLD_SDK=1
	# 	LAMW4LinuxPostConfig
	# ;;
	
	# "update-config")
	# 	LAMW4LinuxPostConfig
	# ;;

	"--sdkmanager")
		getStatusInstalation;
		if [ $LAMW_INSTALL_STATUS = 1 ];then
			Repair
		else
			mainInstall
		fi 	
		NO_GUI_OLD_SDK=0
		WrappergetAndroidSDK
;;
	"--update-lamw")
		getStatusInstalation
		if [ $LAMW_INSTALL_STATUS = 1 ]; then
			Repair
			echo "Updating LAMW";
			getLAMWFramework "pull";
			wrapperBuildLazarusIDE "1";
		else
			mainInstall
		fi
	;;
	"")
		getImplicitInstall
		if [ $LAMW_IMPLICIT_ACTION_MODE = 0 ]; then
			printf "${NEGRITO}Implicit installation of LAMW starting in 2 seconds ...${NORMAL}\n"
			printf "Press control+c to exit ...\n"
			sleep 2

			mainInstall
		else
			printf "${NEGRITO}Implicit LAMW Framework update starting in 2 seconds ...${NORMAL}\n"
			printf "Press control+c to exit ...\n"
			sleep 2
			Repair
			echo "Updating LAMW";
			getLAMWFramework;
			wrapperBuildLazarusIDE "1";
		fi					
	;;
	# "getlaz4android")
	# 	wrappergetLazAndroid
	# 	wrapperBuildLazarusIDE
	# ;;
	*)
		printf "%b" "${LAMW_OPTS[*]}"
	;;
	
esac
	