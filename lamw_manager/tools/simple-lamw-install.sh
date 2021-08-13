#!/bin/bash
#Universidade federal de Mato Grosso
#Curso ciencia da computação
#AUTOR: Daniel Oliveira Souza
#Versao LAMW-INSTALL: 0.3.1-beta
#Descrição: Este script configura o ambiente de desenvolvimento para o LAMW
#=========================================================================================================



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

export ANDROID_HOME="$ROOT_LAMW"
export ANDROID_SDK_ROOT="$ANDROID_HOME\\sdk"
OLD_LAMW4WINDOWS_HOME="$HOMEDRIVE\\LAMW4Windows"
LAMW4WINDOWS_HOME="$ROOT_LAMW\\LAMW4Windows"
FPC_STABLE_EXEC=$LAMW_IDE_HOME\\fpc\\3.0.4\\bin\\i386-win32

LAMW_INSTALL_VERSION="0.3.1.3-beta"
LAMW_INSTALL_WELCOME=(
	"\t\tWelcome LAMW  Manager from MSYS2  version: [$LAMW_INSTALL_VERSION]\n"
	"\t\tPowerd by DanielTimelord\n"

)
  
#----ColorTerm
VERDE=$'\e[1;32m' 
AMARELO=$'\e[01;33m'
SUBLINHADO='4'
NEGRITO=$'\e[1m'
VERMELHO=$'\e[1;31m'
VERMELHO_SUBLINHADO=$'\e[1;4;31m'
AZUL=$'\e[1;34m'
NORMAL=$'\e[0m'

BARRA_INVERTIDA='\'
PACMAN_LOCK="/var/lib/pacman/db.lck"
PROGR="unzip dos2unix subversion tar wget git p7zip"
PROXY_SERVER="internet.cua.ufmt.br"
PORT_SERVER=3128
PROXY_URL="http://$PROXY_SERVER:$PORT_SERVER"
USE_PROXY=0
FLAG_FORCE_ANDROID_AARCH64=1
POWERSHELL_EXEC_POLICY=0
USE_LOCAL_ENV=0
WINDOWS_CMD_WRAPPERS=1
ARGS=($@)
INDEX_FOUND_USE_PROXY=-1

JDK_VERSION=8
FPC_TRUNK_VERSION=3.2.0-beta
_FPC_TRUNK_VERSION=3.2.0
FPC_TRUNK_SVNTAG=fixes_3_2
LAZARUS_STABLE_VERSION="2.2.0_RC1"
LAZARUS_STABLE=lazarus_${LAZARUS_STABLE_VERSION//\./_}
CMD_TOOLS_VERSION="7583922"
CMD_SDK_TOOLS_ZIP="commandlinetools-win-${CMD_TOOLS_VERSION}_latest.zip"
CMD_SDK_TOOLS_DIR="$ANDROID_SDK_ROOT\\cmdline-tools"
ANT_VERSION="1.10.5"



CMD_SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-win-${CMD_TOOLS_VERSION}_latest.zip"
LAMW_SRC_LNK="http://github.com/jmpessoa/lazandroidmodulewizard"
LAMW_PACKAGE_URL="https://raw.githubusercontent.com/jmpessoa/lazandroidmodulewizard/master/package.json"
LAZARUS_STABLE_SRC_LNK="https://gitlab.com/freepascal.org/lazarus/lazarus.git"
BINUTILS_URL="https://gitlab.com/freepascal.org/fpc/build.git"
#FPC_TRUNK_SOURCE_URL="https://svn.freepascal.org/svn/fpc/branches/fixes_3_2@43981"
FPC_TRUNK_SOURCE_URL="https://sourceforge.net/projects/freepascal/files/Source/3.2.0/fpc-3.2.0.source.tar.gz"
ZULU_API_JDK_URL="https://api.azul.com/zulu/download/community/v1.0/bundles/latest/"
ANT_ZIP_LINK="http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.zip"


LAMW_PACKAGES=(
	"$ANDROID_HOME\\lazandroidmodulewizard\\android_bridges\\tfpandroidbridge_pack.lpk"
	"$ANDROID_HOME\\lazandroidmodulewizard\\android_wizard\\lazandroidwizardpack.lpk"
	"$ANDROID_HOME\\lazandroidmodulewizard\\ide_tools\\amw_ide_tools.lpk"
)

LAMW_WORKSPACE_HOME="$HOMEDRIVE${HOMEPATH}\\Dev\\LAMWProjects"  #piath to lamw_workspace
SDK_LICENSES_PARAMETERS=(--licenses )
LAMW_USER_HOME=${HOMEDRIVE}\\${HOMEPATH}
ANT_HOME="$ANDROID_HOME\\apache-ant-${ANT_VERSION}"
GRADLE_CFG_HOME="$HOMEDRIVE${HOMEPATH}\\.gradle"
ANT_ZIP_FILE="apache-ant-${ANT_VERSION}-bin.zip"
FPC_ID_DEFAULT=0

OLD_ANDROID_SDK=1
LAMW_INSTALL_STATUS=0
LAMW_IMPLICIT_ACTION_MODE=0
FLAG_SCAPE=0

#Flag tratador de sinal 
MAGIC_TRAP_INDEX=-1
OLD_JAVA_HOME="$HOMEDRIVE\\Program Files\\Zulu\\zulu-8"
JAVA_EXEC_PATH="$ROOT_LAMW\\jdk\\zulu-$JDK_VERSION\\bin"

OLD_LAMW_MENU_PATH="$HOMEDRIVE\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\LAMW4Windows"
LAMW_MENU_PATH="$HOMEDRIVE${HOMEPATH}\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\LAMW4Windows"


#https://wiki.freepascal.org/Multiple_Lazarus#Using_lazarus.cfg_file 


FPC_TRUNK_PARENT=$LAMW4WINDOWS_HOME\\fpc

FPC_TRUNK_PATH="$FPC_TRUNK_PARENT\\${_FPC_TRUNK_VERSION}"
FPC_TRUNK_SOURCE_PATH="$FPC_TRUNK_PATH\\source"
FPPKG_LOCAL_REPOSITORY="$LAMW4WINDOWS_HOME\\.fppkg\\config"
FPPKG_LOCAL_REPOSITORY_CFG=$FPPKG_LOCAL_REPOSITORY\\default
#help of lamw
LAMW_OPTS=(
	"syntax:\n"
	"\t./lamw_manager.bat\t${NEGRITO}[actions]${NORMAL} ${VERDE}[options]${NORMAL}\n"
	"${NEGRITO}Usage${NORMAL}:\n"
	"\t${NEGRITO}lamw_manager.bat${NORMAL}                              		  Install LAMW and dependencies¹\n"
	"\tlamw_manager.bat\t${VERDE}--sdkmanager${NORMAL}	${VERDE}[ARGS]${NORMAL}            Install LAMW and Run Android SDK Manager²\n"
	"\tlamw_manager.bat\t${VERDE}--update-lamw${NORMAL}                     To just upgrade LAMW framework (with the latest version available in git)\n"
	"\tlamw_manager.bat\t${VERDE}--update-lazarus${NORMAL}                   To just upgrade Lazarus Sources (with the latest version available in git)\n"
	"\tlamw_manager.bat\t${VERDE}--reset${NORMAL}                           To clean and reinstall\n"
	"\tlamw_manager.bat\t${NEGRITO}uninstall${NORMAL}                         To uninstall LAMW :(\n"
	"\tlamw_manager.bat\t${VERDE}--help${NORMAL}                            Show help\n"                 
	"\n"
	"${NEGRITO}Proxy Options:${NORMAL}\n"
	"\tlamw_manager.bat ${NEGRITO}[action]${NORMAL}  --use_proxy --server ${VERDE}[HOST]${NORMAL} --port ${VERDE}[NUMBER]${NORMAL}\n"
	"sample:\n\tlamw_manager.bat --update-lamw --use_proxy --server 10.0.16.1 --port 3128\n"
	"\n"
	"${NEGRITO}Android SDK Manager Options:${NORMAL}\n"
	"\tlamw_manager.bat\t${VERDE}--sdkmanager${NORMAL}	${VERDE}[ARGS]${NORMAL}\n"
	"sample:\n\tlamw_manager.bat --sdkmanager ${VERDE}--list_installed${NORMAL}\n"
	"\n"
	"\n\n${NEGRITO}Note:\n${NORMAL}"
	"\t¹ By default the installation waives the use of parameters, if LAMW is installed, it will only be updated!\n"
	"\t² If it is already installed, just run the Android SDK Tools\n"
	"\n"
	
)

#============================================================================================================================

check_error_and_exit(){

	[ $? != 0 ] && echo "$1" && exit 1
}

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
	local args="$*"
		if [ $POWERSHELL_EXEC_POLICY != 1 ]; then
			POWERSHELL_EXEC_POLICY=1
			powershell.exe Set-ExecutionPolicy Bypass

		fi
		powershell.exe -Command "$args"
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
	local rm_cmd_pwsh="cmd.exe /c 'rmdir \"$1\" /Q /S'"
	winCallfromPS "$rm_cmd_pwsh"

}


setWinArch(){
	ARCH=$(arch)

	case "$ARCH" in
		"x86_64"| "amd64" )
			OS_PREBUILD="windows-x86_64"
			ZULU_API_JDK_URL+="?java_version$JDK_VERSION&jdk_version=$JDK_VERSION&zulu_version=$JDK_VERSION&os=windows&arch=x86&hw_bitness=64&ext=zip&bundle_type=jdk&javafx=false&latest=true&support_term=lts"
			MSYS_TEMP="$HOMEDRIVE\\tools\\msys64\\tmp"
			MINGW_PATH="$HOMEDRIVE\\tools\\msys64\\mingw64\\bin:$HOMEDRIVE\\tools\\msys32\\mingw64\\bin"
			PROGR+=" mingw-w64-x86_64-jq"
			OS_TARGET="win64"
			CPU_TARGET="x86_64"

		;;

		*)
			OS_PREBUILD="windows"
			ZULU_API_JDK_URL+="?java_version$JDK_VERSION&jdk_version=$JDK_VERSION&zulu_version=$JDK_VERSION&os=windows&arch=x86&hw_bitness=32&ext=zip&bundle_type=jdk&javafx=false&latest=true&support_term=lts"
			MSYS_TEMP="$HOMEDRIVE\\tools\\msys32\\tmp"
			PROGR+=" mingw-w64-i686-jq"
			OS_TARGET="win32"
			CPU_TARGET="i386"
			MINGW_PATH="$HOMEDRIVE\\tools\\msys32\\mingw32\\bin"
		;;
	esac

	FPC_TRUNK_EXEC_PATH="$FPC_TRUNK_PATH\\bin\\i386-win32"
	FPPKG_TRUNK_CFG_PATH="$FPC_TRUNK_EXEC_PATH\\fppkg.cfg"
	
	export JAVA_HOME=${JAVA_EXEC_PATH%'\bin'} #remove /bin of JAVA_HOME
	export ARM_ANDROID_TOOLS="$ROOT_LAMW\\sdk\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9\\prebuilt\\$OS_PREBUILD\\bin"
	export AARCH64_ANDROID_TOOLS="$ROOT_LAMW\\sdk\\ndk-bundle\\toolchains\\aarch64-linux-android-4.9\\prebuilt\\$OS_PREBUILD\\bin"
	export PATH="$ARM_ANDROID_TOOLS:$AARCH64_ANDROID_TOOLS:$JAVA_EXEC_PATH:$MINGW_PATH:$PATH"

}

#==========================================================================================================
#									LAMW Manager Core functions
#----------------------------------------------------------------------------------------------------------
getLAMWDep(){
	if [ "$1" = "" ]; then
		echo 'Need object arg!'
		exit 1;
	fi

	if [ "$(which jq)" = "" ]; then
		return
	fi
	echo "$LAMW_DEPENDENCIES" | jq  "$1" | sed 's/"//g'
}

setAndroidSDKCMDParameters(){
	SDK_MANAGER_CMD_PARAMETERS=(
		"platforms;android-$ANDROID_SDK_TARGET" 
		"platform-tools"
		"build-tools;$ANDROID_BUILD_TOOLS_TARGET"
		"ndk-bundle" 
		"extras;android;m2repository"
	)


	if [ $USE_PROXY = 1 ]; then
		SDK_LICENSES_PARAMETERS=( --licenses --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		SDK_MANAGER_CMD_PARAMETERS+=("--no_https --proxy=http" "--proxy_host=$PROXY_SERVER" "--proxy_port=$PORT_SERVER")
	fi
}

setJDKDeps(){
	ZULU_JDK_JSON="$(wget -O- -q  "$ZULU_API_JDK_URL" | jq )"
	ZULU_JDK_URL="$(echo $ZULU_JDK_JSON | jq '.url' | sed 's/"//g')"
	ZULU_JDK_ZIP="$(echo $ZULU_JDK_JSON | jq '.name' | sed 's/"//g' )"
	ZULU_JDK_FILE="$(echo $ZULU_JDK_ZIP | sed 's/.zip//g')"
	JAVA_VERSION="1.8.0_$(echo $ZULU_JDK_JSON | jq '.java_version[2]'| sed 's/"//g')"
}

checkJDKVersionStatus(){
	setJDKDeps
	JDK_STATUS=0
	local java_release_path="$JAVA_HOME\\release"
	[ ! -e $JAVA_HOME ] || ( [ -e $java_release_path ]  && ! grep $JAVA_VERSION  $java_release_path > /dev/null ) && JDK_STATUS=1
}

setLAMWDeps(){

	[  "$LAMW_DEPENDENCIES" = "" ] && LAMW_DEPENDENCIES="$(wget -O- -q  "$LAMW_PACKAGE_URL" )"
	ANDROID_SDK_TARGET=$(getLAMWDep '.dependencies.android.platform')
	ANDROID_BUILD_TOOLS_TARGET=$(getLAMWDep '.dependencies.android.buildTools')
	GRADLE_VERSION=$(getLAMWDep '.dependencies.gradle')
	GRADLE_HOME="$ROOT_LAMW\\gradle-${GRADLE_VERSION}"
	GRADLE_ZIP_LNK="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
	GRADLE_ZIP_FILE="gradle-${GRADLE_VERSION}-bin.zip"
	setAndroidSDKCMDParameters


	#printf "%b" "$ANDROID_SDK_TARGET\n$ANDROID_BUILD_TOOLS_TARGET\n$GRADLE_VERSION\n${SDK_MANAGER_CMD_PARAMETERS[*]}\n"
}


updateLAMWDeps(){


	local need_update_lamw_deps=0
	setLAMWDeps

	if [ ! -e "$GRADLE_HOME" ] ||  [ ! -e "$ANDROID_SDK_ROOT\\platforms\\android-$ANDROID_SDK_TARGET" ] || [ ! -e "$ANDROID_SDK_ROOT\\build-tools\\$ANDROID_BUILD_TOOLS_TARGET" ] ; then
		need_update_lamw_deps=1
	fi

	echo "$need_update_lamw_deps"

}

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

		SDK_MANAGER_CMD_PARAMETERS+=("--no_https")
		SDK_MANAGER_CMD_PARAMETERS+=("--proxy=http" )
		SDK_MANAGER_CMD_PARAMETERS+=("--proxy_host=$PROXY_SERVER")
		SDK_MANAGER_CMD_PARAMETERS+=("--proxy_port=$PORT_SERVER" )

		SDK_LICENSES_PARAMETERS=( --licenses --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		export http_proxy=$PROXY_URL
		export https_proxy=$PROXY_URL
	fi


	if [ $FLAG_FORCE_ANDROID_AARCH64 = 1 ]; then
		LAMW_IDE_HOME="$LAMW4WINDOWS_HOME\\lazarus_trunk"
		LAMW_IDE_HOME_CFG="$LAMW4WINDOWS_HOME\\.lamw4windows"
		FPC_STABLE_EXEC="${LAMW4WINDOWS_HOME}\\fpc\\3.0.4\\bin\\i386-win32"
		FPC_STABLE_ZIP="fpc-3.0.4-i386-win32.tar.xz"
		FPC_STABLE_URL="https://raw.githubusercontent.com/DanielOliveiraSouza/LAMW4Windows-installer/v0.3.1/lamw_manager/tools/fpc-3.0.4-i386-win32.tar.xz"
	fi
}

#Rotina que trata control+c
TrapControlC(){

	local magic_trap=(
		"$ANT_TAR_FILE" #0 
		"$ANT_HOME"		#1
		"$GRADLE_ZIP_FILE" #2
		"$GRADLE_HOME"   #3
		"$SDK_TOOLS_ZIP" #4
		"$ANDROID_SDK_ROOT\\tools" #5
		"$CMD_SDK_TOOLS_ZIP" #6
		"$CMD_SDK_TOOLS_DIR" #7
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

DisableTrapActions(){
	trap - SIGINT  #removendo a traps
	MAGIC_TRAP_INDEX=-1
}

#Get Linux common tools
getTerminalDeps(){
	pacman -Sy $PROGR --noconfirm
	if [ $? != 0 ]; then 
		rm -f "$PACMAN_LOCK"
		pacman  $PROGR -Syy  --noconfirm
	fi
}



getImplicitInstall(){
	if [  -e  "$ROOT_LAMW\\lamw-install.log" ]; then
		export OLD_ANDROID_SDK=1

		cat "$ROOT_LAMW\\lamw-install.log" |  grep "Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" > /dev/null
	
		if [ $? = 0 ]; then  
			echo "Only Update LAMW"
			local flag_is_old_lamw=$(updateLAMWDeps)

			if [ $flag_is_old_lamw = 1 ]; then 
				echo "You need upgrade your LAMW4Linux!"
				LAMW_IMPLICIT_ACTION_MODE=0
			else 
				LAMW_IMPLICIT_ACTION_MODE=1 #apenas atualiza o lamw 
			fi
		fi
	else
		return 
	fi
}

initROOT_LAMW(){

	local init_root_lamw_dirs=(
		$ANDROID_SDK_ROOT
		"$(dirname $JAVA_HOME)"
		$LAMW_USER_HOME//.android
		$FPPKG_LOCAL_REPOSITORY
	)

	for lamw_dir in ${init_root_lamw_dirs[@]}; do
		[ ! -e "$lamw_dir" ] && mkdir -p "$lamw_dir"
	done

	[ ! -e $LAMW_USER_HOME/.android/repositories.cfg ] && touch $LAMW_USER_HOME\\.android\\repositories.cfg  
}

getJDK(){

	[ ! -e "$ROOT_LAMW\\jdk" ] && mkdir -p "$ROOT_LAMW\\jdk"
	checkJDKVersionStatus
	if [ $JDK_STATUS = 1 ]; then 
		changeDirectory "$ROOT_LAMW\\jdk"
		[ -e "$OLD_JAVA_HOME" ] && winRMDirf "$OLD_JAVA_HOME"
		[ -e "$JAVA_HOME" ] && winRMDirf "$JAVA_HOME"
		wget -c "$ZULU_JDK_URL"
		printf "%s" "Please wait, extracting \"$ZULU_JDK_ZIP\"... "
		unzip -q "$ZULU_JDK_ZIP"
		echo "Done"
		mv "$ZULU_JDK_FILE" "zulu-$JDK_VERSION"
		[ -e "$ZULU_JDK_ZIP" ] && rm -rf $ZULU_JDK_ZIP
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
		printf "%s" "Please wait, extracting \"$ANT_ZIP_FILE\" ... "
		unzip -q "$ANT_ZIP_FILE"
		echo "Done"
	fi

	if [ -e  "$ANT_ZIP_FILE" ]; then
		rm "$ANT_ZIP_FILE"
	fi
}


getGradle(){
	changeDirectory $ROOT_LAMW
	if [ ! -e "$GRADLE_HOME" ]; then
		MAGIC_TRAP_INDEX=2 #Set arquivo a ser removido
		trap TrapControlC  2 # set armadilha para o signal2 (siginterrupt)
		wget  -c $GRADLE_ZIP_LNK
		MAGIC_TRAP_INDEX=3
		printf "%s" "Please wait, extracting \"${GRADLE_ZIP_FILE}\" ... "
		unzip -o -q  $GRADLE_ZIP_FILE
		echo "Done"
	fi

	if [ -e  $GRADLE_ZIP_FILE ]; then
		rm $GRADLE_ZIP_FILE
	fi
}


#Get Gradle and SDK Tools 
getAndroidSDKTools(){
	initROOT_LAMW
	changeDirectory $ROOT_LAMW
	changeDirectory $ANDROID_SDK_ROOT
	
	if [ ! -e "$CMD_SDK_TOOLS_DIR" ];then
		mkdir -p "$CMD_SDK_TOOLS_DIR"
		changeDirectory "$CMD_SDK_TOOLS_DIR"
		trap TrapControlC  2
		MAGIC_TRAP_INDEX=4
		wget -c $CMD_SDK_TOOLS_URL
		MAGIC_TRAP_INDEX=5
		printf "%s" "Please wait, extracting \"$CMD_SDK_TOOLS_ZIP\" ... "
		unzip -o -q  $CMD_SDK_TOOLS_ZIP
		echo "Done"
		mv cmdline-tools latest
		rm $CMD_SDK_TOOLS_ZIP
	fi
}

getSDKAntSupportedTools(){
	initROOT_LAMW
	changeDirectory $ANDROID_SDK_ROOT
	SDK_TOOLS_VERSION="r25.2.5"
	SDK_TOOLS_URL="https://dl.google.com/android/repository/tools_r25.2.5-windows.zip"
	SDK_TOOLS_ZIP="tools_r25.2.5-windows.zip"
	SDK_TOOLS_DIR="$ANDROID_SDK_ROOT\\tools"
	if [ ! -e "$SDK_TOOLS_DIR" ];then
		trap TrapControlC  2
		MAGIC_TRAP_INDEX=4
		wget -c $SDK_TOOLS_URL
		MAGIC_TRAP_INDEX=5
		printf "%s" "Please wait, extracting \"$SDK_TOOLS_ZIP\" ... "
		unzip -o -q  $SDK_TOOLS_ZIP
		echo "Done"
		rm $SDK_TOOLS_ZIP
	fi
}

getAndroidCmdLineTools(){
	getSDKAntSupportedTools
	getAndroidSDKTools
}

runSDKManagerLicenses(){
	local sdk_manager_cmd="$CMD_SDK_TOOLS_DIR\\latest\\bin\\sdkmanager.bat"
	yes | $sdk_manager_cmd ${SDK_LICENSES_PARAMETERS[*]} 
	if [ $? != 0 ]; then 
		yes | $sdk_manager_cmd ${SDK_LICENSES_PARAMETERS[*]} 
		check_error_and_exit "possible network instability! Try later!"
	fi
}

runSDKManager(){
	local sdk_manager_cmd="$CMD_SDK_TOOLS_DIR\\latest\\bin\\sdkmanager.bat"
	if [ $FORCE_YES = 1 ]; then 
		yes | $sdk_manager_cmd $*

		if [ $? != 0 ]; then
			yes | $sdk_manager_cmd $*
			check_error_and_exit "possible network instability! Try later!"
		fi
	else
		$sdk_manager_cmd $*

		if [ $? != 0 ]; then 
			$sdk_manager_cmd $*
			check_error_and_exit "possible network instability! Try later!"
		fi
	fi
}

getAndroidAPIS(){
	
	FORCE_YES=1
	changeDirectory $ANDROID_HOME
	runSDKManagerLicenses
	
	if [ $#  = 0 ]; then 

		for((i=0;i<${#SDK_MANAGER_CMD_PARAMETERS[*]};i++));do
			echo "Please wait, downloading \"${SDK_MANAGER_CMD_PARAMETERS[i]}\"... "
			
			if [ $i = 0 ]; then 
				runSDKManager ${SDK_MANAGER_CMD_PARAMETERS[i]} # instala sdk sem intervenção humana 
			else
				FORCE_YES=0
				runSDKManager ${SDK_MANAGER_CMD_PARAMETERS[i]} 
			fi
		done
	else 
		runSDKManager $*
	fi

	unset FORCE_YES
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
	local root_java=$(dirname "$JAVA_HOME")
	local list_to_del=(
			"$ANDROID_SDK_ROOT${BARRA_INVERTIDA}ndk-bundle${BARRA_INVERTIDA}toolchains${BARRA_INVERTIDA}mipsel-linux-android-4.9"
			"$ANDROID_SDK_ROOT${BARRA_INVERTIDA}ndk-bundle${BARRA_INVERTIDA}toolchains${BARRA_INVERTIDA}mips64el-linux-android-4.9"
			"$OLD_LAMW4WINDOWS_HOME"
			"$ROOT_LAMW"
			"$OLD_LAMW_MENU_PATH"
			"$LAMW_MENU_PATH"
			"$LAMW4WINDOWS_HOME"
	)
	winCallfromPS "taskkill /im adb.exe /f"    2>/dev/null
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
		"PathToAndroidNDK=$ANDROID_SDK_ROOT\\ndk-bundle"
		"PathToAndroidSDK=$ANDROID_SDK_ROOT"
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
		"SET ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
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
	for ((i=0;i<${#lamw_loader_bat_str[@]};i++))
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
	winMKLink "$ANDROID_SDK_ROOT\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK_ROOT\\ndk-bundle\\toolchains\\mipsel-linux-android-4.9"
	winMKLink "$ANDROID_SDK_ROOT\\ndk-bundle\\toolchains\\arm-linux-androideabi-4.9" "$ANDROID_SDK_ROOT\\ndk-bundle\\toolchains\\mips64el-linux-android-4.9"
	CreateLauncherLAMW
}
writeLAMWLogInstall(){
	local lamw_log_str=(
		"Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" 
		"LAMW workspace : $LAMW_WORKSPACE_HOME" 
		"Android SDK:$ANDROID_SDK_ROOT" 
		"Android NDK:$ANDROID_SDK_ROOT\\ndk-bundle" 
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
			getLazarusSource
			BuildLazarusIDE
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
			printf "%s" "Please wait, extracting \"$FPC_STABLE_ZIP\" ... "
			tar -xf "$LAMW_MANAGER_PATH/$FPC_STABLE_ZIP"
			echo "Done"
		else
			wget -c "$FPC_STABLE_URL"
			if [  $? != 0 ]; then 
				wget -c "$FPC_STABLE_URL"
				check_error_and_exit "possible instability internet! Try later!"
			fi
		printf "%s" "Please wait, extracting \"$FPC_STABLE_ZIP\" ... "
			tar -xf "$FPC_STABLE_ZIP"
			echo "Done"
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

	if [ ! -e "$LAMW4WINDOWS_HOME" ]; then
		mkdir -p "$LAMW4WINDOWS_HOME"
	fi
	cd $LAMW4WINDOWS_HOME
	if [ ! -e "$FPC_TRUNK_SOURCE_PATH" ]; then
		mkdir -p $FPC_TRUNK_SOURCE_PATH
	fi

	cd "$FPC_TRUNK_SOURCE_PATH"
	if [ ! -e $FPC_TRUNK_SVNTAG ]; then
		wget -c "$FPC_TRUNK_SOURCE_URL"
		printf "%s" "Please wait, extracting \"fpc-${_FPC_TRUNK_VERSION}.source.tar.gz\"... "
		tar -zxf fpc-${_FPC_TRUNK_VERSION}.source.tar.gz
		echo "Done"
		mv fpc-${_FPC_TRUNK_VERSION} $FPC_TRUNK_SVNTAG
		rm fpc-${_FPC_TRUNK_VERSION}.source.tar.gz
	fi	
}

BuildCrossAArch64(){
	[ $FLAG_FORCE_ANDROID_AARCH64 = 0 ] && return 

	ln -s "$AARCH64_ANDROID_TOOLS\\aarch64-linux-android-as.exe" "$FPC_STABLE_EXEC\\aarch64-linux-android-as.exe"
	ln -s "$AARCH64_ANDROID_TOOLS\\aarch64-linux-android-ld.exe" "$FPC_STABLE_EXEC\\aarch64-linux-android-ld.exe"
	ln -s "$ARM_ANDROID_TOOLS\\arm-linux-androideabi-as.exe" "$FPC_STABLE_EXEC\\arm-linux-androideabi-as.exe"
	ln -s "$ARM_ANDROID_TOOLS\\arm-linux-androideabi-ld.exe" "$FPC_STABLE_EXEC\\arm-linux-androideabi-ld.exe"
	cd "$FPC_TRUNK_SOURCE_PATH/${FPC_TRUNK_SVNTAG}"
	printf "%s\n" "Please wait, starting Build FPC to AARCH64/Android ..."
	make -s  clean crossall crossinstall CPU_TARGET=aarch64 OS_TARGET=android OPT="-dFPC_ARMHF"  INSTALL_PREFIX="$FPC_TRUNK_PATH" #crosszipinstall
	
	echo "Done"
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC AARCH64/Android falls"
		exit 1;
	fi
	printf "%s\n" "Please wait, starting Build FPC ARMv7/Android ..."
	make -s  clean crossall crossinstall CPU_TARGET=arm OPT="-dFPC_ARMEL" OS_TARGET=android CROSSOPT="-CpARMV7A -CfVFPV3" INSTALL_PREFIX="$FPC_TRUNK_PATH" #crosszipinstall
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC ARMv7/Android falls"
		exit 1;
	fi
	echo "Done"
}

BuildFPCTrunk(){
	if [ $FLAG_FORCE_ANDROID_AARCH64 = 0 ]; then
		return 
	fi
	export PATH="$FPC_STABLE_EXEC:$PATH"
	cd "$FPC_TRUNK_SOURCE_PATH/${FPC_TRUNK_SVNTAG}"
	printf "%s\n" "Please wait, starting Build FPC to i386/Win32 ..."
	make -s  clean all install OS_TARGET="win32" INSTALL_PREFIX="$FPC_TRUNK_PATH" #zipinstall
	if [ $? != 0 ]; then
		echo "${VERMELHO}Build FPC $OS_TARGET falls"
		exit 1;
	fi
	echo "Done"
	
}

getBinults(){
	[ ! -e "$FPC_TRUNK_EXEC_PATH" ] && mkdir  -p "$FPC_TRUNK_EXEC_PATH"

	cd "$FPC_TRUNK_PATH"
	git clone $BINUTILS_URL  -b $FPC_TRUNK_SVNTAG binutils
	if [ $? != 0 ]; then 
		winRMDirf binutils
		git clone $BINUTILS_URL  -b $FPC_TRUNK_SVNTAG binutils
		if [ $? != 0 ]; then 
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
	
	cd binutils\\install\\binw32
	mv ./* "$FPC_TRUNK_EXEC_PATH"
	cd "$FPC_TRUNK_PATH"
	winRMDirf binutils
}

InitLazarusConfig(){
	local lazarus_version_str="$($LAMW_IDE_HOME\\tools\\install\\get_lazarus_version.sh)"
	local lazarus_env_cfg="$LAMW_IDE_HOME_CFG\\environmentoptions.xml"
	local lazarus_env_cfg_str=(
		'<?xml version="1.0" encoding="UTF-8"?>'
		'<CONFIG>'
		'	<EnvironmentOptions>'
		"		<Version Value=\"110\" Lazarus=\"${lazarus_version_str}\"/>"
		"		<LazarusDirectory Value=\"$LAMW_IDE_HOME\"/>"
		"		<CompilerFilename Value=\"$FPC_TRUNK_EXEC_PATH\\fpc.exe\"/>"
		"		<FPCSourceDirectory Value=\"$FPC_TRUNK_SOURCE_PATH\\$FPC_TRUNK_SVNTAG\"/>"
		"	<FppkgConfigFile Value=\"${FPPKG_TRUNK_CFG_PATH}\"/>"
		'    	<Debugger Class="TGDBMIDebugger">'
      	'			<Configs>'
        '				<Config ConfigName="FpDebug" ConfigClass="TFpDebugDebugger" Active="True"/>'
        "				<Config ConfigName=\"Gdb\" ConfigClass=\"TGDBMIDebugger\" DebuggerFilename=\"$FPC_TRUNK_EXEC_PATH\\gdb.exe\"/>"
        '			</Configs>'
        '		</Debugger>'
		"	</EnvironmentOptions>"
		"</CONFIG>"
	)

	[ ! -e $LAMW_IDE_HOME_CFG ] && mkdir -p $LAMW_IDE_HOME_CFG
	if [ ! -e  "$lazarus_env_cfg" ] ; then
		for((i=0;i<${#lazarus_env_cfg_str[*]};i++)); do
			if [ $i = 0 ]; then 
				printf "%s\n" "${lazarus_env_cfg_str[i]}" > "$lazarus_env_cfg"
			else
				printf "%s\n" "${lazarus_env_cfg_str[i]}" >> "$lazarus_env_cfg"
			fi
		done
	else 
		local old_lazarus_dir="`grep '<LazarusDirectory\sValue=' $LAMW_IDE_HOME_CFG | sed 's/[<>]//g' | awk -F='' '{print $2}'`"
		sed  -i "s|${old_lazarus_dir}|$LAMW_IDE_HOME_CFG|g"
	fi
	unix2dos "$LAMW_IDE_HOME_CFG/environmentoptions.xml" 2>/dev/null
	winCallfromPS "cmd.exe /c 'attrib +h $LAMW_IDE_HOME_CFG'"
}

BuildLazarusIDE(){
	export PPC_CONFIG_PATH="$FPC_TRUNK_EXEC_PATH" 
	cd "$LAMW_IDE_HOME"
	export PATH="$FPC_TRUNK_EXEC_PATH:$PATH"
	if [ $# = 0 ]; then 
		make -s  clean all "PP=$FPC_TRUNK_EXEC_PATH\\ppc386.exe" 
		if [ $? != 0 ]; then 
			echo "${VERMELHO}Error:${NORMAL} Cannot Build Lazarus"
			exit 1
		fi
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
	local fpc_cfg_path="$FPC_TRUNK_EXEC_PATH\\fpc.cfg"
	#if [ ! -e "$fpc_cfg_path" ]; then
		"$FPC_TRUNK_EXEC_PATH\\fpcmkcfg" -d basepath="$FPC_TRUNK_PATH" -o "$fpc_cfg_path"
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
			"-Fl${ANDROID_SDK_ROOT}\\ndk-bundle\\toolchains\\llvm\\prebuilt\\$OS_PREBUILD\\sysroot\\usr\\lib\\arm-linux-androideabi\\""$ANDROID_SDK_TARGET"
			"-FLlibdl.so"
			"-FD${ARM_ANDROID_TOOLS}"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget" #-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\*"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\rtl" #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/rtl'
			"#ENDIF"
			'#IFDEF CPUAARCH64'
			'-Xd'
			'-XPaarch64-linux-android- '
			"-Fl${ANDROID_SDK_ROOT}\\ndk-bundle\\toolchains\\llvm\\prebuilt\\$OS_PREBUILD\\sysroot\\usr\\lib\\aarch64-linux-android\\""$ANDROID_SDK_TARGET"
			'-FLlibdl.so'
			"-FD${AARCH64_ANDROID_TOOLS}"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget" #-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\*"
			"-Fu$FPC_TRUNK_PARENT""\\\$fpcversion\\units\\\$fpctarget\\rtl" #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/rtl'
			'#ENDIF'
			"#ENDIF"
		)
		local fpcpkg_cfg_str=(

			"[Defaults]"
			"ConfigVersion=5"
			"LocalRepository=$(dirname "$FPPKG_LOCAL_REPOSITORY")$BARRA_INVERTIDA"
			"BuildDir={LocalRepository}build"
			"ArchivesDir={LocalRepository}archives/"
			"CompilerConfigDir={LocalRepository}config/"
			"RemoteMirrors=https://www.freepascal.org/repository/mirrors.xml"
			"RemoteRepository=auto"
			"CompilerConfig=default"
			"FPMakeCompilerConfig=default"
			"Downloader=FPC"
			"InstallRepository=user"
			""
			"[Repository]"
			"Name=fpc"
			"Description=Packages which are installed along with the Free Pascal Compiler"
			"Path=${FPC_TRUNK_PATH}"
			"Prefix=${FPC_TRUNK_PATH}"
			""
			"[IncludeFiles]"
			"FileMask={LocalRepository}config/conf.d/*.conf"
			""
			"[Repository]"
			"Name=user"
			"Description=User-installed packages"
			"Path={LocalRepository}"
			"Prefix={LocalRepository}"
			""
		)

		local fppkg_local_cfg=(
		'[Defaults]'
		'ConfigVersion=5'
		"Compiler=$FPC_TRUNK_EXEC_PATH\\fpc.exe"
		'OS=Win32'
		'CPU=i386'	
	)
	
		for((i=0;i<${#fpcpkg_cfg_str[@]};i++)); do 
			line=${fpcpkg_cfg_str[$i]}
			if [ $i = 0 ]; then
				echo "$line " > "$FPPKG_TRUNK_CFG_PATH"
			else 
				echo "$line" >> "$FPPKG_TRUNK_CFG_PATH"
			fi
		done

		for ((i = 0 ; i < ${#fppkg_local_cfg[@]};i++)); do 
			if [ $i = 0 ]; then 
				echo "${fppkg_local_cfg[$i]}" > $FPPKG_LOCAL_REPOSITORY_CFG
			else
				echo "${fppkg_local_cfg[$i]}" >> $FPPKG_LOCAL_REPOSITORY_CFG
			fi
		done
		if [ -e "$fpc_cfg_path" ] ; then  # se exiir /etc/fpc.cfg
			cat $fpc_cfg_path | grep 'CPUAARCH64'
			if [ $? != 0 ]; then 
				for ((i = 0 ; i<${#fpc_cfg_str[@]};i++)) ; do
					echo "${fpc_cfg_str[i]}" >>  "$fpc_cfg_path"
				done	
			fi
		fi

		unix2dos "$fpc_cfg_path" 2> /dev/null
		unix2dos "$FPPKG_TRUNK_CFG_PATH" 2> /dev/null
		unix2dos "$FPPKG_LOCAL_REPOSITORY_CFG" 2>/dev/null


}

getLazarusSource(){
	local git_lock="$LAZARUS_STABLE\\.git\\index.lock"
	changeDirectory $LAMW4WINDOWS_HOME
	local lazarus_dir=$(basename "$LAMW_IDE_HOME")
	if [ ! -e $lazarus_dir ]; then
		git clone $LAZARUS_STABLE_SRC_LNK $lazarus_dir
		if [ $? != 0 ]; then 
			
			[ -e $git_lock ] && winRMDirf "$git_lock"
			git clone $LAZARUS_STABLE_SRC_LNK  $lazarus_dir
			check_error_and_exit "cannot get lazarus sources"
		fi
	else 
		[ -e $git_lock ] && rm -rf $git_lock
		changeDirectory $lazarus_dir
		git config pull.ff only 
		git pull
		if [ $? != 0 ]; then 
			git reset --hard
			git pull 
			if [ $? != 0 ]; then 
				echo "cannot update lazarus sources"
				changeDirectory ..
				winRMDirf "$lazarus_dir"
				exit 1
			fi
		fi
	fi
}



#----------------------------------------------------------------------------



mainInstall(){

	getTerminalDeps
	setLAMWDeps
	getJDK
	getAnt
	getGradle
	getAndroidCmdLineTools
	DisableTrapActions
	getAndroidAPIS
	getFPCStable
	getFPCTrunkSources
	getBinults
	getLazarusSource
	getLAMWFramework
	BuildFPCTrunk
	BuildCrossAArch64
	ConfigureFPCTrunk
	BuildLazarusIDE
	changeDirectory "$ANDROID_HOME"
	LAMW4LinuxPostConfig
	winCallfromPS "taskkill /im adb.exe /f" 2>/dev/null
	writeLAMWLogInstall
}

	echo "----------------------------------------------------------------------"
	printf "${LAMW_INSTALL_WELCOME[*]}"
	echo "----------------------------------------------------------------------"
	echo "LAMW Manager (Native Support:Linux supported Debian 10, Ubuntu 16.04 LTS, Linux Mint 18)
	Windows Compability (from MSYS2): Only Windows 8.1 and Windows 10"

	winCallfromPS "cmd.exe /c ver" | grep "6.1.760" 
	if [ $? = 0 ]; then
		echo -e  "Warning: ${VERMELHO}Windows 7 ended support!${NORMAL}\nRead more in:https://www.microsoft.com/en-US/windows/windows-7-end-of-life-support-information"
	fi

	if [ "$ARCH" != "amd64" ] && [ "$ARCH" != "x86_64" ]; then
		echo "${VERMELHO}Warning:${NORMAL}LAMW Manager now only supports ${NEGRITO}64-bit${NORMAL} windows."
		echo "${NEGRITO}Installation on Windows 32 bit will be disabled in Aug / 2021.${NORMAL}"
		sleep 2
	fi
	echo "Please wait ... "
	setWinArch
	#configure parameters sdk before init download and build

	#Checa se necessario habilitar remocao forcada
	#checkForceLAMW4LinuxInstall $*

for arg_index in ${!ARGS[@]}; do 
	arg=${ARGS[$arg_index]}
	if [ "$arg" = "--use_proxy" ];then
		INDEX_FOUND_USE_PROXY=$arg_index
		break
	fi
done

if [ $INDEX_FOUND_USE_PROXY -lt 0 ]; then
	initParameters
else 
	index_proxy_server=$((INDEX_FOUND_USE_PROXY+1))
	index_server_value=$((index_proxy_server+1))
	index_port_server=$((index_server_value+1))
	index_port_value=$((index_port_server+1))
	if [ "${ARGS[$index_proxy_server]}" = "--server" ]; then
		if [ "${ARGS[$index_port_server]}" = "--port" ] ;then
			initParameters "${ARGS[$INDEX_FOUND_USE_PROXY]}" "${ARGS[$index_server_value]}" "${ARGS[$index_port_value]}"
		else 
			echo "${VERMELHO}Error:${NORMAL}missing ${NEGRITO}--port${NORMAL}";exit 1
		fi
		unset ARGS[$INDEX_FOUND_USE_PROXY]
		unset ARGS[$index_proxy_server]
		unset ARGS[$index_server_value]
		unset ARGS[$index_port_server]
		unset ARGS[$index_port_value]
	else 
		echo "${VERMELHO}Error:${NORMAL}missing ${NEGRITO}--server${NORMAL}";exit 1
	fi
fi

	

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
		mainInstall
	;;
	"install")
		mainInstall
	;;

	"--sdkmanager")
		getStatusInstalation;
		if [ $LAMW_INSTALL_STATUS = 1 ];then
			Repair
		else
			mainInstall
		fi 	
		getAndroidAPIS ${ARGS[@]:1}
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
	"--update-lazarus")
		getStatusInstalation
			if [ $LAMW_INSTALL_STATUS = 0 ]; then
				mainInstall
			else 
				getLazarusSource
				BuildLazarusIDE
			fi
	;;
	"" | "--use-proxy" )
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
			BuildLazarusIDE "1";
		fi					
	;;
	# "getlaz4android")
	# 	getLazarusSource
	# 	BuildLazarusIDE
	# ;;
	*)
		printf "%b" "${LAMW_OPTS[*]}"
	;;	
esac
