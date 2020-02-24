
#!/bin/bash
#Universidade federal de Mato Grosso
#Curso ciencia da computação
#AUTOR: Daniel Oliveira Souza
#Versao LAMW-INSTALL: 0.3.0-r23-02-2020
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
export USE_LOCAL_ENV=0
export GDB_INDEX=0

#Critical Functions to Translate Calls Bash to  WinCalls 
if [ -e "/c/tools/msys64/usr/bin" ]; then
	export PATH="$PATH:/c/tools/msys64/usr/bin" 
else
	if [ -e "/c/tools/msys32" ]; then
		export PATH="$PATH:/c/tools/msys32/usr/bin"
	fi
fi 

winCallfromPS(){
	if [ $USE_LOCAL_ENV = 0 ];  then
		echo "$*" > /tmp/pscommand.ps1
		powershell.exe Set-ExecutionPolicy Bypass
		powershell.exe  /tmp/pscommand.ps1
	 else
		#this array of script powershellF
		pscommand_str=(
		"\$JAVA_HOME=\"$win_java_path\""
		#"echo \$env:path"
		"\$env:PATH=\"$WIN_JAVA_PATH;\" + \$env:path"
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
		#read
		#echo "$WIN_JAVA_PATH";read
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
export WIN_CURRENT_USER=""
export WIN_USER_DIRECTORY=""
export WIN_HOME="" #this path compatible with Windows
export WIN_MSYS_TEMP_HOME=""
export WIN_MSYS_HOME=""
export WIN_LETTER_HOME_DRIVER=""
export WGET_EXE=""
export NDK_URL=""
export NDK_ZIP_FILE=""
export ZULU_JDK_URL=""
export ZULU_JDK_ZIP=""
export ZULU_TMP_PATH=""
export USE_LOCAL_ENV=0
export LOCAL_ENV=""
export WIN_LOCAL_ENV=""
export JAVA_PATH=""
export LAZ4ANDROID_STABLE_VERSION="2.0.0"
if [  $WINDOWS_CMD_WRAPPERS  = 1 ]; then
	echo "Please wait ..."
	export WIN_CURRENT_USER=$USERNAME #$(getWinEnvPaths 'username' )
	export WIN_LETTER_HOME_DRIVER=$HOMEDRIVE #$(getWinEnvPaths "HOMEDRIVE" ) # RETURN LETTER TO DRIVER WIN INSTALL , SAMPLE C:
	export LETTER_HOME_DRIVER=$(getSystemLetterDrivertoLinux $WIN_LETTER_HOME_DRIVER )
	export WIN_HOMEPATH=$(getLinuxPath $HOMEPATH)
	export WIN_USER_DIRECTORY=${HOMEDRIVE}${HOMEPATH} #$WIN_LETTER_HOME_DRIVER$(getWinEnvPaths "HOMEPATH" )   #ROOT WINU
	export USER_DIRECTORY="/$LETTER_HOME_DRIVER$WIN_HOMEPATH"
	if [ ! -e "$USER_DIRECTORY/.android" ]; then 
		mkdir "$USER_DIRECTORY/.android"
	fi
	echo ""  > "$USER_DIRECTORY/.android/repositories.cfg"
	which wget 
	if [ $? = 0 ]; then
		export WGET_EXE=$(which wget)
	else
		export WGET_EXEC="/$LETTER_HOME_DRIVER/ProgramData/chocolatey/bin/wget"
	fi
	
	export _7ZEXE="/c/Program Files/7-Zip/7z"	
	export WIN_HOME=$WIN_LETTER_HOME_DRIVER'\Users\'
	export WIN_HOME="$WIN_USER_DIRECTORY$WIN_CURRENT_USER"
	export HOME="/home/$WIN_CURRENT_USER"
	export ARCH=$(arch)
	export OS_PREBUILD=""
	case "$ARCH" in
		"x86_64")
			export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys64"
			export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys64/tmp"
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_x64"
			export JAVA_PATH="/$LETTER_HOME_DRIVER/Program Files/Zulu/zulu-8/bin"
			export WIN_JAVA_PATH="$WIN_LETTER_HOME_DRIVER\Program Files\Zulu\zulu-8\bin"
			#export USE_LOCAL_ENV=1
		;;
		"amd64")
			export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys64"
			export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys64/tmp"
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86_64.zip"
			export OS_PREBUILD="windows-x86_64"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_x64.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_x64"
			export JAVA_PATH="/$LETTER_HOME_DRIVER/Program Files/Zulu/zulu-8/bin"
			export WIN_JAVA_PATH="$WIN_LETTER_HOME_DRIVER\Program Files\Zulu\zulu-8\bin"
			#export USE_LOCAL_ENV=1
		;;
		*)
			#export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys32"
			export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys32/tmp"
			export OS_PREBUILD="windows"
			export WGET_EXE="/$LETTER_HOME_DRIVER/ProgramData/chocolatey/bin/wget.exe"
			export NDK_URL="http://dl.google.com/android/repository/android-ndk-r18b-windows-x86.zip"
			export NDK_ZIP_FILE="android-ndk-r18b-windows-x86.zip"
			export ZULU_JDK_URL="http://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jdk8.0.212-win_i686.zip"
			export ZULU_JDK_ZIP="zulu8.38.0.13-ca-jdk8.0.212-win_i686.zip"
			export ZULU_TMP_PATH="zulu8.38.0.13-ca-jdk8.0.212-win_i686"
			export JAVA_PATH="/$LETTER_HOME_DRIVER/Program Files/Zulu/zulu-8/bin"
			export WIN_JAVA_PATH="$WIN_LETTER_HOME_DRIVER\Program Files\Zulu\zulu-8\bin"
			#export USE_LOCAL_ENV=1
		;;
	esac
	 #MSYS_TEMP != %temp%
	which git
	if [ $? != 0 ]; then
		export PATH="$PATH:/$LETTER_HOME_DRIVER/Program Files/Git/bin"
	fi
fi

export PATH_TO_FPC="/$LETTER_HOME_DRIVER/laz4android${LAZ4ANDROID_STABLE_VERSION}/fpc/3.0.4/bin/i386-win32"
export PATH_TO_LAZ4ANDROID="/$LETTER_HOME_DRIVER/LAMW4Windows/laz4android${LAZ4ANDROID_STABLE_VERSION}"
export LAZ4_LAMW_PATH_CFG="${PATH_TO_LAZ4ANDROID}/config"
export WIN_PATH_TO_LAZ4ANDROID="$WIN_LETTER_HOME_DRIVER\LAMW4Windows\laz4android${LAZ4ANDROID_STABLE_VERSION}"
export WIN_PATH_TO_FPC="$WIN_LETTER_HOME_DRIVER\laz4android${LAZ4ANDROID_STABLE_VERSION}\fpc\3.0.4\bin\i386-win32"
export PATH="$PATH:$PATH_TO_FPC"

MINGW_URL="http://osdn.net/projects/mingw/downloads/68260/mingw-get-setup.exe"
WIN_PROGR="git.install svn jdk8  7zip.install ant  "
MINGW_PACKAGES="msys-wget-bin  mingw32-base-bin mingw-developer-toolkit-bin msys-base-bin msys-zip-bin "
MINGW_OPT="--reinstall"


	#unzip wrappers to windows 
	


LAMW_INSTALL_VERSION="0.3.0-r23-02-2020"
LAMW_INSTALL_WELCOME=(
	"\t\tWelcome LAMW  Manager from MSYS2  version: [$LAMW_INSTALL_VERSION]\n"
	"\t\tPowerd by DanielTimelord\n"
)


export URL_FPC=""
export FPC_VERSION=""
export FPC_CFG_PATH="$PATH_TO_FPC/fpc.cfg"


export PPC_CONFIG_PATH=$FPC_CFG_PATH
export FPC_RELEASE=""
export flag_new_ubuntu_lts=0
export FPC_LIB_PATH=""

export FPC_VERSION=""
export FPC_MKCFG_EXE=""
export FORCE_LAWM4INSTALL=0
#work_home_desktop=$(xdg-user-dir DESKTOP)
ANDROID_HOME="$USER_DIRECTORY/LAMW"
ANDROID_SDK="$ANDROID_HOME/sdk"
#ANDROID_HOME for $win 

BARRA_INVERTIDA='\'
#------------ PATHS translated for windows------------------------------
WIN_ANDROID_HOME="$WIN_USER_DIRECTORY\LAMW"
WIN_ANDROID_SDK="$WIN_ANDROID_HOME\sdk"
WIN_PATH_LAZ4ANDROID_CFG="$WIN_LETTER_HOME_DRIVER\laz4android1.8\config"
WIN_LAZ4LAMW_HOME="$WIN_USER_DIRECTORY\Laz4Lamw"
WIN_LAMW_IDE_HOME="$WIN_LAZ4LAMW_HOME\lazarus_stable" # path to link-simbolic to ide 
WIN_LAMW_IDE_HOME_REAL="$WIN_LAMW_IDE_HOME$BARRA_INVERTIDA$LAZARUS_STABLE"

WIN_LAMW_WORKSPACE_HOME="$WIN_USER_DIRECTORY\Dev\LAMWProjects"  #piath to lamw_workspacewin
WIN_LAZ4LAMW_EXE_PATH="$WIN_LAMW_IDE_HOME\Laz4Lamw"
WIN_LAMW_MENU_ITEM_PATH="\ProgramData\Microsoft\Windows\Start Menu\Programs\Laz4Lamw.lnk"
WIN_GRADLE_HOME="$WIN_ANDROID_HOME\gradle-4.4.1"
WIN_ANT_HOME="$WIN_ANDROID_HOME\apache-ant-1.10.5"
#export WIN_CFG_PATH=""
export WIN_FPC_CFG_PATH="$WIN_PATH_TO_FPC\fpc.cfg"
export WIN_FPC_LIB_PATH=""
export WIN_PPC_CONFIG_PATH=$FPC_CFG_PATH


#--------------------------------------------------------------------------
CROSS_COMPILE_URL="http://github.com/newpascal/fpcupdeluxe/releases/tag/v1.6.1e"
APT_OPT=""
export PROXY_SERVER="internet.cua.ufmt.br"
export PORT_SERVER=3128
PROXY_URL="http://$PROXY_SERVER:$PORT_SERVER"
export USE_PROXY=0
export SDK_TOOLS_URL="http://dl.google.com/android/repository/sdk-tools-windows-4333796.zip"
export SDK_TOOLS_VERSION="r26.1.1" 

SDK_VERSION="28"
SDK_MANAGER_CMD_PARAMETERS=()
SDK_MANAGER_CMD_PARAMETERS2=()
SDK_MANAGER_CMD_PARAMETERS2_PROXY=()
SDK_LICENSES_PARAMETERS=()
LAZARUS_STABLE_SRC_LNK="http://svn.freepascal.org/svn/lazarus/tags/lazarus_1_8_4"

LAZARUS4ANDROID_LNK="http://sourceforge.net/projects/laz4android/files/laz4android${LAZ4ANDROID_STABLE_VERSION}-FPC3.0.4.7z"
LAZARUS4ANDROID_ZIP="laz4android${LAZ4ANDROID_STABLE_VERSION}-FPC3.0.4.7z"

LAMW_SRC_LNK="http://github.com/jmpessoa/lazandroidmodulewizard"

LAZ4LAMW_HOME="$USER_DIRECTORY/Laz4Lamw"
LAMW_IDE_HOME="$LAZ4LAMW_HOME/lazarus_stable" # path to link-simbolic to ide 
LAMW_WORKSPACE_HOME="$USER_DIRECTORY/Dev/LAMWProjects"  #piath to lamw_workspace
LAZ4LAMW_EXE_PATH="$LAMW_IDE_HOME/Laz4Lamw"
LAMW_MENU_ITEM_PATH="$USER_DIRECTORY/.local/share/applications/Laz4Lamw.desktop"
GRADLE_HOME="$ANDROID_HOME/gradle-4.4.1"
ANT_HOME="$ANDROID_HOME/apache-ant-1.10.5"
#WIN_GRADLE_HOME=
GRADLE_CFG_HOME="$USER_DIRECTORY/.gradle"

GRADLE_ZIP_LNK="https://services.gradle.org/distributions/gradle-4.4.1-bin.zip"
GRADLE_ZIP_FILE="gradle-4.4.1-bin.zip"
ANT_ZIP_LINK="http://archive.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip"
ANT_ZIP_FILE="apache-ant-1.10.5-bin.zip"

ADB_WIN_DRIVER_LINK="http://dl.adbdriver.com/upload/adbdriver.zip"
ADB_WIN_DRIVER_ZIP="adbdriver.zip"
FPC_STABLE=""
LAZARUS_STABLE="lazarus_1_8_4"

FPC_ID_DEFAULT=0
FPC_CROSS_ARM_DEFAULT_PARAMETERS=('clean crossall crossinstall  CPU_TARGET=arm OS_TARGET=android OPT="-dFPC_ARMHF" SUBARCH="armv7a" INSTALL_PREFIX=/usr')
FPC_CROSS_ARM_MODE_FPCDELUXE=(crossall crossinstall  CPU_TARGET=arm OPT="-dFPC_ARMEL" OS_TARGET=android CROSSOPT="-CpARMV7A -CfVFPV3" INSTALL_PREFIX=/usr)
LAZBUILD_PARAMETERS=(
	"--build-ide= --add-package $ANDROID_HOME/lazandroidmodulewizard/trunk/android_bridges/tfpandroidbridge_pack.lpk --primary-config-path=$LAZ4_LAMW_PATH_CFG  --lazarusdir=$LAMW_IDE_HOME"
	"--build-ide= --add-package $ANDROID_HOME/lazandroidmodulewizard/trunk/android_wizard/lazandroidwizardpack.lpk --primary-config-path=$LAZ4_LAMW_PATH_CFG --lazarusdir=$LAMW_IDE_HOME"
	"--build-ide= --add-package $ANDROID_HOME/lazandroidmodulewizard/trunk/ide_tools/amw_ide_tools.lpk --primary-config-path=$LAZ4_LAMW_PATH_CFG --lazarusdir=$LAMW_IDE_HOME"
)

#REGEX VARIABLES

WR_GRADLE_HOME=""
WR_ANDROID_HOME=""
HOME_USER_SPLITTED_ARRAY=(${HOME//\// })
HOME_STR_SPLITTED=""
libs_android="libx11-dev libgtk2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev libxtst-dev libatk1.0-dev libghc-x11-dev freeglut3 freeglut3-dev "
prog_tools="menu fpc git subversion make build-essential zip unzip unrar android-tools-adb ant openjdk-8-jdk "
packs=()
#[[]
#echo "WIN_GRADLE_HOME=$WIN_GRADLE_HOME"
#sleep 3

export OLD_ANDROID_SDK=1
export NO_GUI_OLD_SDK=0
export LAMW_INSTALL_STATUS=0
export LAMW_IMPLICIT_ACTION_MODE=0
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
#remove /bin of java_path
java_path=$JAVA_PATH
java_path=${java_path%/bin*}
win_java_path=${WIN_JAVA_PATH%'\bin'}
#atalhos pro menu iniciar
WIN_LAMW_MENU_PATH="${WIN_LETTER_HOME_DRIVER}\ProgramData\Microsoft\Windows\Start Menu\Programs\LAMW4Windows"
LAMW_MENU_PATH="/$LETTER_HOME_DRIVER/ProgramData/Microsoft/Windows/Start Menu/Programs/LAMW4Windows"


export ANDROID_SDK_TARGET=28
export ANDROID_BUILD_TOOLS_TARGET="28.0.3"
export GRADLE_MIN_BUILD_TOOLS='27.0.3'
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
		"$ANDROID_SDK/tools" #5
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
		changeDirectory "/$LETTER_HOME_DRIVER/Program Files"
		if [ ! -e "/$LETTER_HOME_DRIVER/Program Files/Zulu" ]; then
			mkdir -p "/$LETTER_HOME_DRIVER/Program Files/Zulu"
		fi
		#echo "JAVA_PATH="\$JAVA_PATH\" >> debug-lamw.sh
		#echo "ls \$JAVA_PATH" >> debug-lamw.sh
		changeDirectory "/$LETTER_HOME_DRIVER/Program Files/Zulu"
		#echo "PWD=$PWD";read
		#ls $JAVA_PATH
		#ls ${JAVA_PATH}/java*;read
		if [ ! -e "zulu-8" ]; then
		#	pwd;read
		#	echo "$JAVA_PATH";read
		#	ls $JAVA_PATH
		#	$JAVA_PATH/javac.exe -version
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
			#echo $PWD | grep ${JAVA_PATH};read
			rm $ZULU_JDK_ZIP
			export PATH=$PATH:$JAVA_PATH
			#export JAVA_HOME=$JAVA_PATH
			java -version
		else
			export PATH=$PATH:$JAVA_PATH
		#	export JAVA_HOME=$JAVA_PATH
			java -version
		fi
	#fi
}
getTerminalDeps(){
	pacman -Syy  unzip --noconfirm
	if [ $? != 0 ]; then 
		pacman -Syy  unzip --noconfirm
	fi
}
getImplicitInstall(){
	if [  -e  "$ANDROID_HOME/lamw-install.log" ]; then
		printf "Checking the Android SDK version installed :"
		cat $ANDROID_HOME/lamw-install.log |  grep "OLD_ANDROID_SDK=0"
		if [ $? = 0 ]; then
			export OLD_ANDROID_SDK=0
		else 
			export OLD_ANDROID_SDK=1
			export NO_GUI_OLD_SDK=1
		fi
		printf "Checking the LAMW Manager version :"
		cat "$ANDROID_HOME/lamw-install.log" |  grep "Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION"
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
		#getWinEnvPaths "TEMP"
		#echo "LinkDir:target=$1 link=$2"
		#rm  /tmp/winMKLink.bat
		#win_temp_path=$(getWinEnvPaths "HOMEDRIVE")
		if [ ! -e "$2" ]; then
			win_temp_path="$WIN_MSYS_TEMP_HOME/winMKLink.bat"
			echo "mklink /D $2 $1" > "/tmp/winMKLink.bat" 
			winCallfromPS "$win_temp_path"
			if [ -e "/tmp/winMKLink.bat"  ]; then
				rm  "/tmp/winMKLink.bat" 
			fi
		fi
	fi
}
winMKLink(){
	if [ $# = 2 ]; then
		#echo "Link: target=$1 link=$2"
		if [ !-e "$2" ]; then
				#rm  "$2"
			#fi
			win_temp_path="$WIN_LETTER_HOME_DRIVER/tools/msys64/tmp/winMKLink.bat"
			aspas="\""
			#echo   "s2=$aspas$2$aspas s1=$aspas$1$aspas"
			echo "mklink  $aspas$2$aspas $aspas$1$aspas" > "/tmp/winMKLink.bat" 
			#read
			winCallfromPS "$win_temp_path"
			if [ -e "/tmp/winMKLink.bat"  ]; then
				rm  "/tmp/winMKLink.bat" 
			fi
		fi
	fi
}
#this function delete a windows 
winRMDir(){
	win_temp_executable="$WIN_MSYS_TEMP_HOME/winrmdir.bat"
	#echo "rmdir /Q  $*" > /tmp/winrmdir.bat
	echo "rmdir \"$*\"" > "/tmp/winrmdir.bat"
	winCallfromPS "$win_temp_executable"
	if [ -e /tmp/winrmdir.bat ]; then 
		rm /tmp/winrmdir.bat
	fi
}
winRMDirf(){
	win_temp_executable="$WIN_MSYS_TEMP_HOME/winrmdir.bat"
	echo "rmdir /Q /S  \"$*\"" > "/tmp/winrmdir.bat"
	echo "rmdir /Q /S  \"$*\"" >> "/tmp/winrmdir.bat"
	winCallfromPS "$win_temp_executable"
	if [ -e "/tmp/winrmdir.bat" ]; then 
		rm "/tmp/winrmdir.bat"
	fi
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

	if  [ -e "$ANDROID_HOME/adbdriver" ]; then
		changeDirectory "$ANDROID_HOME/adbdriver"
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
			#rm *.zip*
			ANT_ZIP_LINK="http://www-eu.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip"
			$WGET_EXE -c "$ANT_ZIP_LINK"
			if [ $? != 0 ]; then 
				echo "possible network instability! Try later!"
				exit 1
			fi
		fi
		#echo "$PWD"
		#sleep 3
		magicTrapIndex=1
		trap TrapControlC 2
		unzip "$ANT_ZIP_FILE"
	fi

	if [ -e  "$ANT_ZIP_FILE" ]; then
		rm "$ANT_ZIP_FILE"
	fi
}
getAndroidSDKToolsW32(){
	changeDirectory "$USER_DIRECTORY"
	if [ ! -e "$ANDROID_HOME" ]; then
		mkdir "$ANDROID_HOME"
	fi
	
	changeDirectory "$ANDROID_HOME"
	if [ ! -e "$GRADLE_HOME" ]; then
		magicTrapIndex=-1
		trap TrapControlC 2
		$WGET_EXE -c "$GRADLE_ZIP_LNK"
		if [ $? != 0 ] ; then
			#rm *.zip*
			$WGET_EXE -c "$GRADLE_ZIP_LNK"
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
	#ANT
	
	#mkdir
	#changeDirectory $ANDROID_SDK
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
		if [ ! -e "$ANDROID_SDK/tools" ]; then
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

	if [ ! -e "$ANDROID_SDK/ndk-bundle" ]; then
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
	#echo "WIN_JAVA_PATH=$WIN_JAVA_PATH";read;
	pscommand_str=(
		"\$JAVA_HOME=\"$win_java_path\""
		#"echo \$env:path"
		"\$env:PATH=\"$WIN_JAVA_PATH;\" + \$env:path"
		"\$SDK_MANAGER_FAILS=@(\"platform\",\"platform-tools\", \"build-tools\", \"extras\google\google-google_play_services\", \"extras\android\m2repository\", \"extras\google\market_licensing\" , \"extras\google\market_apk_expansion\")"   
    	"\$SDK_MANAGER_CMD_PARAMETERS2=@( \"android-$ANDROID_SDK_TARGET\" ,\"platform-tools\" ,\"build-tools-$ANDROID_BUILD_TOOLS_TARGET\"  ,\"extra-google-google_play_services\" ,\"extra-android-m2repository\" ,\"extra-google-m2repository\" ,\"extra-google-market_licensing\", \"extra-google-market_apk_expansion\")"
    	"\$env:PATH=\"$WIN_ANDROID_SDK\tools;\" + \$env:path"
    	#"echo \$env:path"
		"for(\$i=0; \$i -lt \$SDK_MANAGER_CMD_PARAMETERS2.Count; \$i++){"
		"	\$aux=\"${WIN_ANDROID_SDK}\tools\" + '\' + \$SDK_MANAGER_FAILS[\$i]"
    	"	echo y | android.bat \"update\" \"sdk\" \"--all\" \"--no-ui\" \"--filter\" \$SDK_MANAGER_CMD_PARAMETERS2[\$i] "
   		"	if ( \$? -eq \$false ){"
   		"		if ( Test-Path \$aux){"
       	"			rmdir -Recurse -Force \$aux"
       	"		}"
       	"		echo y | android.bat \"update\" \"sdk\" \"--all\" \"--no-ui\" \"--filter\" \$SDK_MANAGER_CMD_PARAMETERS2[\$i]  --force"
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
	#if [ -e  /tmp/pscommand.ps1 ]; then 
	#	rm /tmp/pscommand.ps1
	#fi
	#cat $installer_cmd

}
	

updateWinPATHS(){
	cmd_paths='\ProgramData\chocolatey\bin\RefreshEnv'
	WIN_SVN_PATH_WIN64="/$LETTER_HOME_DRIVER/Program Files (x86)/Subversion/bin/svn"
	WIN_SVN_PATH_WIN32="/$LETTER_HOME_DRIVER/Program Files/Subversion/bin/svn"
	winCallfromPS "$cmd_paths"
	new_cmd_path='echo $PATH' 
	echo "$new_cmd_path" > "/tmp/update-win-path.sh"
	if [ $? !=  0 ]; then
		echo "not write"
		exit 1
	fi
	new_path=$(bash "/tmp/update-win-path.sh")
	#echo "NEW_PATH=$new_path"
	#read 
	export PATH=$PATH:$new_path
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
				line="NULL"
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
		SDK_MANAGER_CMD_PARAMETERS=(
			"platforms;android-$ANDROID_SDK_TARGET"
			"platform-tools"
			"build-tools;$ANDROID_BUILD_TOOLS_TARGET" 
			#"tools" 
			"ndk-bundle" 
			"extras;android;m2repository" 
			--no_https 
			--proxy=http 
			--proxy_host=$PROXY_SERVER 
			--proxy_port=$PORT_SERVER 
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
		)
		SDK_MANAGER_CMD_PARAMETERS2_PROXY=(
			--no_https 
			#--proxy=http 
			--proxy-host=$PROXY_SERVER 
			--proxy-port=$PORT_SERVER 
		)
		SDK_LICENSES_PARAMETERS=( --licenses --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		export http_proxy=$PROXY_URL
		export https_proxy=$PROXY_URL
#	ActiveProxy 1
	else
		SDK_MANAGER_CMD_PARAMETERS=(
		"platforms;android-$ANDROID_SDK_TARGET"
		"platform-tools" 
		"build-tools;$ANDROID_BUILD_TOOLS_TARGET" 
		#"tools"
		"ndk-bundle" 
		"extras;android;m2repository"
		)			#ActiveProxy 0
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
		)
		SDK_LICENSES_PARAMETERS=(--licenses )
	fi
}
#Get FPC Sources
getFPCSources(){
	changeDirectory "$USER_DIRECTORY"
	mkdir -p "$LAZ4LAMW_HOME/fpcsrc"
	changeDirectory "$LAZ4LAMW_HOME/fpcsrc"
	svn checkout "$URL_FPC"
	if [ $? != 0 ]; then
		#rm $FPC_RELEASE/.svn -r
		rm -r "$FPC_RELEASE"
		svn checkout "$URL_FPC"
		if [ $? != 0 ]; then 
			rm -r "$FPC_RELEASE"
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
}
#get Lazarus Sources
getLazarusSources(){
	changeDirectory "$LAZ4LAMW_HOME"
	svn co "$LAZARUS_STABLE_SRC_LNK"
	if [ $? != 0 ]; then  #case fails last command , try svn chekout 
		rm -rf "$LAZARUS_STABLE"
		#svn cleanup
		#changeDirectory $LAZ4LAMW_HOME
		svn co "$LAZARUS_STABLE_SRC_LNK"
		if [ $? != 0 ]; then 
			rm -rf $LAZARUS_STABLE
			echo "possible network instability! Try later!"
			exit 1
		fi
		#svn revert -R  $LAMW_SRC_LNK
	fi
}

#GET LAMW FrameWork

getLAMWFramework(){
	changeDirectory "$ANDROID_HOME"
	export git_param=("clone" "$LAMW_SRC_LNK")
	if [ -e "lazandroidmodulewizard/.git" ]  ; then
		changeDirectory "$ANDROID_HOME/lazandroidmodulewizard"
		export git_param=("pull")
	fi
	
	git ${git_param[*]}
	if [ $? != 0 ]; then #case fails last command , try svn chekout
		
		export git_param=("clone" "$LAMW_SRC_LNK")
		cd $ANDROID_HOME
		winRMDirf "$WIN_ANDROID_HOME\lazandroidmodulewizard"
		git ${git_param[*]}
		if [ $? != 0 ]; then 
			winRMDirf "$WIN_ANDROID_HOME\lazandroidmodulewizard"
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
	
}



getSDKAndroid(){
	export USE_LOCAL_ENV=1
	#changeDirectory $ANDROID_SDK/tools/bin #change directory
	
	#   winCallfromPS1 "yes" "|" "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	# if [ $? != 0 ]; then 
	# 		winCallfromPS1 "yes" "|" "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	# 		if [ $? != 0 ]; then 
	# 			echo "possible network instability! Try later!"
	# 			exit 1
	# 		fi
	# fi

	#echo "len(SDK_MANAGER_CMD_PARAMETERS)=${#SDK_MANAGER_CMD_PARAMETERS[*]}";read;
	for((i=0;i<${#SDK_MANAGER_CMD_PARAMETERS[*]};i++))
	do
		echo "please wait... "
		 winCallfromPS1 "echo"  "y" "|" "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""  # instala sdk sem intervenção humana  

		if [ $? != 0 ]; then 
			winCallfromPS1 "echo" "y" "|" "$$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "\"${SDK_MANAGER_CMD_PARAMETERS[i]}\""
			if [ $? != 0 ]; then
				echo "possible network instability! Try later!"
				exit 1;
			fi
		fi
		#winCallfromPS1 "$WIN_LETTER_HOME_DRIVER$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "ndk-bundle"

		#if [ $? != 0 ]; then 
		#	winCallfromPS1 "$WIN_LETTER_HOME_DRIVER$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "ndk-bundle"
		#fi

	done
	export USE_LOCAL_ENV=0

}

getOldAndroidSDK(){

	if [ -e "$ANDROID_SDK/tools/android.bat"  ]; then 
		#echo "PWD=$PWD";read;
		export USE_LOCAL_ENV=1
		#changeDirectory $ANDROID_SDK/tools
		#echo  "Before install sdk 24.0"
		#winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk "
		#./android update sdk
		if [ $NO_GUI_OLD_SDK = 0 ]; then
			echo "--> Running Android SDK Tools manager"
		#schangeDirectory $ANDROID_SDK/tools
		#./android update sdk
			winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk"
		else
			winCallfromPS1 
		fi

		#echo "please wait ..."
		#read 
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
#to build
BuildCrossArm(){
	if [ "$1" != "" ]; then #
		changeDirectory "$LAZ4LAMW_HOME/fpcsrc"
		changeDirectory "$FPC_RELEASE"
		bar='/'
		case $1 in 
			0 )
				make clean
				make crossall crossinstall  CPU_TARGET=arm OPT="-dFPC_ARMEL" OS_TARGET=android CROSSOPT="-CpARMV7A -CfVFPV3" INSTALL_PREFIX=/$LETTER_HOME_DRIVER/tools/freepascal
				#echo "press enter to exit BuildCrossArm" ; read
			;;

		esac
	fi				
}

#Build lazarus ide
getLazarus4Android(){
	if [ ! -e "/$LETTER_HOME_DRIVER/LAMW4Windows" ]; then
		mkdir "/$LETTER_HOME_DRIVER/LAMW4Windows"
	fi
	changeDirectory "/$LETTER_HOME_DRIVER/LAMW4Windows"
	if [ ! -e "$PATH_TO_LAZ4ANDROID" ]; then
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
	changeDirectory "$PATH_TO_LAZ4ANDROID"
	if [ $# = 0 ]; then 
		aux="$WIN_PATH_TO_LAZ4ANDROID"$BARRA_INVERTIDA
		#echo "aux=$aux";read
		aux=$aux"build.bat"
		winCallfromPS "$aux"
	fi
	changeDirectory "$LETTER_HOME_DRIVER"
	build_win_cmd="/$LETTER_HOME_DRIVER/generate-lazarus.bat"
	bar='\'
	WIN_LAZBUILD_PARAMETERS=(
		"--build-ide= --add-package \"$WIN_ANDROID_HOME\lazandroidmodulewizard\android_bridges\tfpandroidbridge_pack.lpk\""
		"--build-ide= --add-package \"$WIN_ANDROID_HOME\lazandroidmodulewizard\android_wizard\lazandroidwizardpack.lpk\""
		"--build-ide= --add-package \"$WIN_ANDROID_HOME\lazandroidmodulewizard\ide_tools\amw_ide_tools.lpk\""
	)
	#make clean all
	
	#echo "make clean all" >> $build_win_cmd
		#build ide  with lamw framework 
	for((i=0;i< ${#WIN_LAZBUILD_PARAMETERS[@]};i++))
	do
		echo "PATH=$WIN_PATH;%PATH%"> "$build_win_cmd"
		echo "cd \"$WIN_PATH_TO_LAZ4ANDROID\"" >> "$build_win_cmd"
		echo "lazbuild ${WIN_LAZBUILD_PARAMETERS[i]}" >> "$build_win_cmd"
		winCallfromPS "$WIN_LETTER_HOME_DRIVER\generate-lazarus.bat"
		if [ $? != 0 ]; then 
			winCallfromPS "$WIN_LETTER_HOME_DRIVER\generate-lazarus.bat"
		fi
		#prevent no exists lazarus (common bug)
		if [ ! -e "$PATH_TO_LAZ4ANDROID/lazarus.exe" ]; then
			winCallfromPS "taskkill /im make.exe /f" > /dev/null
			winCallfromPS "$WIN_LETTER_HOME_DRIVER\generate-lazarus.bat"
		fi

	done
	
	if [ -e "$build_win_cmd" ]; then
		rm "$build_win_cmd"
	fi
	#echo  "lazarus --primary-config-path=$WIN_LETTER_HOME_DRIVER$WIN_PATH_LAZ4ANDROID_CFG" > start_laz4lamw.bat
}
#Esta função imprime o valor de uma váriavel de ambiente do MS Windows 
#this  fuction create a INI file to config  all paths used in lamw framework 

CreateLauncherLAMW(){
	
	if [ ! -e "$LAMW_MENU_PATH" ]; then
		mkdir "$LAMW_MENU_PATH"
	fi

	if [ -e "$WIN_LAMW_MENU_PATH\LAMW4Windows.lnk" ]; then 
		rm "$WIN_LAMW_MENU_PATH\LAMW4Windows.lnk"
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
	    "\$lamw_path_target=\"$WIN_PATH_TO_LAZ4ANDROID\start-lamw.vbs\""
		"\$lamw_path_destination=\"$WIN_LAMW_MENU_PATH\LAMW4Windows.lnk\""
		"\$lamw_icon_path=\"$WIN_PATH_TO_LAZ4ANDROID\images\icons\lazarus_orange.ico\""
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
	if [ ! -e "$LAZ4_LAMW_PATH_CFG" ] ; then
		mkdir "$LAZ4_LAMW_PATH_CFG"
	fi

	if [ -e "$old_lamw_workspace" ]; then
		mv "$old_lamw_workspace" "$LAMW_WORKSPACE_HOME"
	fi
	if [ ! -e "$LAMW_WORKSPACE_HOME" ] ; then
		mkdir -p "$LAMW_WORKSPACE_HOME"
	fi

	#java_versions=("/usr/lib/jvm/java-8-openjdk-amd64"  "/usr/lib/jvm/java-8-oracle"  "/usr/lib/jvm/java-8-openjdk-i386")
	#ant_path=$(getWinEnvPaths "ANT_HOME" )
	#java_path=$JAVA_PATH
	
	#echo $java_path


# contem o arquivo de configuração do lamw
	LAMW_init_str=(
		"[NewProject]"
		"PathToWorkspace=$WIN_LAMW_WORKSPACE_HOME"
		"PathToJavaTemplates=$WIN_USER_DIRECTORY\LAMW\lazandroidmodulewizard\android_wizard\smartdesigner\java"
		"PathToSmartDesigner=$WIN_USER_DIRECTORY\LAMW\lazandroidmodulewizard\android_wizard\smartdesigner"
		"PathToJavaJDK=$win_java_path"
		"PathToAndroidNDK=$WIN_USER_DIRECTORY\LAMW\sdk\ndk-bundle"
		"PathToAndroidSDK=$WIN_USER_DIRECTORY\LAMW\sdk"
		"PathToAntBin=$WIN_ANT_HOME\bin"
		"PathToGradle=$WIN_GRADLE_HOME"
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
		"SET PATH=$WIN_JAVA_PATH;%PATH%"
		"cd \"$WIN_PATH_TO_LAZ4ANDROID\""
		"SET JAVA_HOME=\"$win_java_path\""
		'lazarus %*'
	)
	lamw_loader_vbs_str="CreateObject(\"Wscript.Shell\").Run  \"$WIN_PATH_TO_LAZ4ANDROID\lamw-ide.bat\",0,True"
	# "${LAMW_init_str[*]}"
	#escreve o arquivo LAMW.ini
	for ((i=0;i<${#LAMW_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${LAMW_init_str[i]}" > "$LAZ4_LAMW_PATH_CFG/LAMW.ini" 
		else
			echo "${LAMW_init_str[i]}" >> "$LAZ4_LAMW_PATH_CFG/LAMW.ini"
		fi
	done

	#escreve o arquivo lamw.bat que contém as variáveis de ambiente do lamw
	for ((i=0;i<${#LAMW_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${lamw_loader_bat_str[i]}" > "$PATH_TO_LAZ4ANDROID\lamw-ide.bat"
		else
			echo "${lamw_loader_bat_str[i]}" >>  "$PATH_TO_LAZ4ANDROID\lamw-ide.bat"
		fi
	done

	echo "$lamw_loader_vbs_str" >  "$PATH_TO_LAZ4ANDROID\start-lamw.vbs"
	#AddLAMWtoStartMenu
	#if [ $OLD_ANDROID_SDK = 0 ]; then
	winMKLinkDir "$WIN_ANDROID_SDK\ndk-bundle\toolchains\arm-linux-androideabi-4.9" "$WIN_ANDROID_SDK\ndk-bundle\toolchains\mipsel-linux-android-4.9"
	winMKLinkDir "$WIN_ANDROID_SDK\ndk-bundle\toolchains\arm-linux-androideabi-4.9" "$WIN_ANDROID_SDK\ndk-bundle\toolchains\mips64el-linux-android-4.9"
	#fi
	CreateLauncherLAMW

}
#Add LAMW4Linux to menu 

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

	if [ $WINDOWS_CMD_WRAPPERS = 1 ]; then
		if [ -e "$ANDROID_HOME/sdk/uninstall.exe" ]; then
			echo "running unistaller sdktools 24..."
			echo "$WIN_ANDROID_HOME\sdk\uninstall" > "/tmp/run.bat"
			winCallfromPS "$WIN_MSYS_TEMP_HOME\run.bat"
			if [ -e "/tmp/run.bat" ]; then 
				rm "/tmp/run.bat"
			fi

		fi
		#echo "try read file ...";read
		if [ -e "$USER_DIRECTORY/mingw-get-setup.exe" ]; then
			rm "$USER_DIRECTORY/mingw-get-setup.exe"
		fi
	fi
	winCallfromPS "taskkill /im adb.exe /f" > /dev/null
	if [ $? = 0 ]; then
		echo "adb process stopped..."
	fi
	if [ -e "$USER_DIRECTORY/laz4ndroid" ]; then
		#rm  -r $USER_DIRECTORY/laz4ndroid
		winRMDirf "$WIN_USER_DIRECTORY\laz4ndroid"
	fi
	if [ -e "$USER_DIRECTORY/.laz4android" ] ; then
		rm -r "$USER_DIRECTORY/.laz4android"
		#winRMDirf "$WIN_USER_DIRECTORY\.laz4android"
	fi

	if [ -e "$ANDROID_HOME" ] ; then
		#chmod 777 -Rv $ANDROID_HOME
		#rm -rf $ANDROID_HOME
	#	echo "WIN_ANDROID_HOME=$WIN_ANDROID_HOME"
		winRMDirf "$WIN_ANDROID_HOME"
		if [ $? != 0 ]; then
			winRMDirf "$WIN_ANDROID_HOME"
			if [ $? != 0 ]; then 
				rm -rf "$ANDROID_HOME"
			fi
		fi
	fi

	#echo "$java_path";read
	if [  -e "$java_path" ]; then
		winRMDirf "$win_java_path"
	fi

	if [ -e "$USER_DIRECTORY/.android" ]; then
		chmod 777 -R  "$USER_DIRECTORY/.android"
		rm -r  "$USER_DIRECTORY/.android"
		#winRMDirf "$WIN_USER_DIRECTORY\.android"
	fi 



	if [ -e "$GRADLE_CFG_HOME" ]; then
		rm -r "$GRADLE_CFG_HOME"
	fi
	if [ -e "$PATH_TO_LAZ4ANDROID" ]; then
		winRMDirf "$WIN_PATH_TO_LAZ4ANDROID"
	fi


	if [ -e "$LAMW_MENU_PATH" ]; then
		winRMDirf "$WIN_LAMW_MENU_PATH"
	fi
	#if [ -e "$USER_DIRECTORY/android" ]; then 
	#	#echo "please wait to remove $USER_DIRECTORY/android ..."
	#chmod 777 -R $USER_DIRECTORY/android
	#	#rm -r $USER_DIRECTORY/android 
	#	winRMDirf "$WIN_USER_DIRECTORY\android"
	#

	if [  -e "/${LETTER_HOME_DRIVER}/LAMW4Windows" ]; then
		rm -rf "/${LETTER_HOME_DRIVER}/LAMW4Windows"
	fi

	local aux=$JAVA_PATH
	local aux=${JAVA_PATH%zulu-8\/bin*}
	echo ${aux}
	if [ -e "${aux}" ]; then
		rm -rf "${aux}"
	fi
	unset aux
}


#this function returns a version fpc 

#detecta a versão do fpc instalada no PC  seta as váriavies de ambiente
parseFPC(){ 
		
	export URL_FPC="http://svn.freepascal.org/svn/fpc/tags/release_3_0_4"
	export FPC_RELEASE="release_3_0_4"
	export FPC_VERSION="3.0.4"
	export FPC_LIB_PATH="/$LETTER_HOME_DRIVER/laz4android1.8/fpc/3.0.4"
	export FPC_EXE="$PATH_TO_FPC/fpc.exe"
	export WIN_FPC_LIB_PATH='$WIN_LETTER_HOME_DRIVER\laz4android1.8\fpc\3.0.4'
	export PATH=$PATH:$FPC_EXE
	export FPC_MKCFG_EXE=$(which fpcmkcfg.exe)
	echo "$FPC_MKCFG_EXE";sleep 5
	
}

enableCrossCompile(){
if [ ! -e "$FPC_CFG_PATH" ]; then
		$FPC_MKCFG_EXE -d basepath="$FPC_LIB_PATH" -o "$FPC_CFG_PATH"
fi
		
		#this config enable to crosscompile in fpc 
		fpc_cfg_str=(
			"#IFDEF ANDROID"
			"#IFDEF CPUARM"
			"-CpARMV7A"
			"-CfVFPV3"
			"-Xd"
			"-XParm-linux-androideabi-"
			"-Fl$WIN_ANDROID_HOME\sdk\ndk-bundle\platforms\android-$SDK_VERSION\arch-arm\usr\lib"
			"-FLlibdl.so"
			"-FD$WIN_ANDROID_HOME\sdk\ndk-blundle\toolchains\arm-linux-androideabi-4.9\prebuilt\linux-x86_64\bin"
			'-FuC:\laz4android1.8\fpc\3.0.4\units\$fpctarget' #-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget
			'-FuC:\laz4android1.8\fpc\3.0.4\units\$fpctarget*' #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget*'
			'-FuC:\laz4android1.8\fpc\3.0.4\units\$fpctarget\rtl' #'-Fu/usr/lib/fpc/$fpcversion/units/$fpctarget/rtl'
			"#ENDIF"
			"#ENDIF"
		)

		if [ -e "$FPC_CFG_PATH" ] ; then  # se exiir /etc/fpc.cfg
			
			searchLineinFile "$FPC_CFG_PATH"  "${fpc_cfg_str[0]}"
			flag_fpc_cfg=$?

			# if [ $flag_fpc_cfg != 1 ]; then # caso o arquvo ainda não esteja configurado
			# 	for ((i = 0 ; i<${#fpc_cfg_str[@]};i++)) 
			# 	do
			# 		#echo ${fpc_cfg_str[i]}
			# 		echo "${fpc_cfg_str[i]}" | tee -a  "$FPC_CFG_PATH"
			# 	done	
			# fi
		fi
		
		#winMKLink "$WIN_LETTER_HOME_DRIVER$WIN_FPC_LIB_PATH\ppcrossarm.exe" "C:\tools\msys64\usr\bin\ppcrossarm.exe"
		#winMKLink  "C:\tools\msys64\usr\bin\ppcrossarm.exe"   "C:\tools\msys64\usr\bin\ppcarm.exe"
}

#write log lamw install 
writeLAMWLogInstall(){
	lamw_log_str=(
		"Generate LAMW_INSTALL_VERSION=$LAMW_INSTALL_VERSION" 
		"LAMW workspace : $WIN_LAMW_WORKSPACE_HOME" 
		"Android SDK:$WIN_ANDROID_HOME\sdk" 
		"Android NDK:$WIN_ANDROID_HOME\ndk" 
		"Gradle:$WIN_GRADLE_HOME" 
		"OLD_ANDROID_SDK=$OLD_ANDROID_SDK"
		"SDK_TOOLS_VERSION=$SDK_TOOLS_VERSION"
		"Install-date:$(date)"
	)
	for((i=0; i<${#lamw_log_str[*]};i++)) 
	do
		printf "%s\n"  "${lamw_log_str[i]}"
		if [ $i = 0 ] ; then 
			printf "%s\n" "${lamw_log_str[i]}" > "$ANDROID_HOME/lamw-install.log"
		else
			printf "%s\n" "${lamw_log_str[i]}" >> "$ANDROID_HOME/lamw-install.log" 
		fi
	done		
}
getStatusInstalation(){
	if [  -e "$ANDROID_HOME/lamw-install.log" ]; then
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
		if [ ! -e "/$LETTER_HOME_DRIVER/Program Files/Zulu/zulu-8" ]; then
			installJava
		fi
		if [ ! -e "$PATH_TO_LAZ4ANDROID" ]; then
			getLazarus4Android
			BuildLazarusIDE
			LAMW4LinuxPostConfig
		fi
	fi

}
mainInstall(){

	#installDependences
	getTerminalDeps
	#checkProxyStatus
	#configureFPC
	WrappergetAndroidSDKTools
	installJava
	#unistallJavaUnsupported
	#setJava8asDefault
	#getSDKAndroid
	WrappergetAndroidSDK
	#getFPCSources
	getLazarus4Android
	getLAMWFramework
	#getLazarusSources

	changeDirectory "$USER_DIRECTORY"
	#CleanOldCrossCompileBin
	changeDirectory "$FPC_RELEASE"
	#BuildCrossArm $FPC_ID_DEFAULT
	#enableCrossCompile
	BuildLazarusIDE
	changeDirectory "$ANDROID_HOME"
	LAMW4LinuxPostConfig
	InstallWinADB
	winCallfromPS "taskkill /im adb.exe /f" > /dev/null
	writeLAMWLogInstall
	#rm /tmp/*.bat
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
		#echo ${win_java_path};read;
		export OLD_ANDROID_SDK=1
		export NO_GUI_OLD_SDK=1
		LAMW4LinuxPostConfig
	;;
	
	"update-config")
		LAMW4LinuxPostConfig
	;;
	# "update-links")
	# 	#CreateSDKSimbolicLinks
	# ;;
	"--sdkmanager")
		getStatusInstalation;
		if [ $LAMW_INSTALL_STATUS = 1 ];then
			Repair
			echo "Starting Android SDK Manager...."
			export USE_LOCAL_ENV=1
			winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk"
			#changeOwnerAllLAMW 

		else
			mainInstall
			export USE_LOCAL_ENV=1
			winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk"
			#changeOwnerAllLAMW
		fi 	
;;
	"--update-lamw")
		getStatusInstalation
		if [ $LAMW_INSTALL_STATUS = 1 ]; then
			Repair
			echo "Updating LAMW";
			getLAMWFramework "pull";
			#sleep 1;
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
			#checkProxyStatus;
			echo "Updating LAMW";
			getLAMWFramework;
		#	sleep 1;
			BuildLazarusIDE "1";
		fi					
	;;
	"getlaz4android")
		getLazarus4Android
	;;
	*)
		printf "%b" "${lamw_opts[*]}"
	;;
	
esac
