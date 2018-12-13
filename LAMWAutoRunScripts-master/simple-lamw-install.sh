
#!/bin/bash
#Universidade federal de Mato Grosso
#Curso ciencia da computação
#AUTOR: Daniel Oliveira Souza <oliveira.daniel@gmail.com>
#Versao LAMW-INSTALL: 0.2.0
#Descrição: Este script configura o ambiente de desenvolvimento para o LAMW
#---------------------------------
#Critical Functions to Translate Calls Bash to  WinCalls 
if [ -e "/c/tools/msys64/usr/bin" ]; then
	export PATH="$PATH:/c/tools/msys64/usr/bin" 
else
	if [ -e "/c/tools/msys32" ]; then
		export PATH="$PATH:/c/tools/msys32/usr/bin"
	fi
fi 

winCallfromPS(){
	echo "$*" > /tmp/pscommand.ps1
	powershell.exe Set-ExecutionPolicy Bypass
	powershell.exe  /tmp/pscommand.ps1
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
if [  $WINDOWS_CMD_WRAPPERS  = 1 ]; then
	echo "Please wait ..."
	export WIN_CURRENT_USER=$(getWinEnvPaths 'username' )
	export WIN_LETTER_HOME_DRIVER=$(getWinEnvPaths "HOMEDRIVE" ) # RETURN LETTER TO DRIVER WIN INSTALL , SAMPLE C:
	export LETTER_HOME_DRIVER=$(getSystemLetterDrivertoLinux $WIN_LETTER_HOME_DRIVER )
	export WIN_USER_DIRECTORY=$WIN_LETTER_HOME_DRIVER$(getWinEnvPaths "HOMEPATH" )   #ROOT WINU
	export USER_DIRECTORY="/$LETTER_HOME_DRIVER/Users/$WIN_CURRENT_USER"
	if [ ! -e $USER_DIRECTORY/.android ]; then 
		mkdir $USER_DIRECTORY/.android
	fi
	echo ""  > $USER_DIRECTORY/.android/repositories.cfg
	which wget 
	if [ $? = 0 ]; then
		export WGET_EXE=$(which wget)
	else
		export WGET_EXEC="/$LETTER_HOME_DRIVER/ProgramData/chocolatey/bin/wget"
	fi
		
	export WIN_HOME=$WIN_LETTER_HOME_DRIVER'\Users\'
	export WIN_HOME="$WIN_USER_DIRECTORY$WIN_CURRENT_USER"
	export HOME="/home/$WIN_CURRENT_USER"
	export ARCH=$(arch)
	export OS_PREBUILD=""
	case "$ARCH" in
		"x86_64")
		export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys64"
		export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys64/tmp"
		export OS_PREBUILD="windows-x86_64"
		;;
		"amd64")
			#export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys64"
			export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys64/tmp"
			export OS_PREBUILD="windows-x86_64"
		;;
		*)
			#export WIN_MSYS_HOME="/$LETTER_HOME_DRIVER/tools/msys32"
			export WIN_MSYS_TEMP_HOME="$WIN_LETTER_HOME_DRIVER/tools/msys32/tmp"
			export OS_PREBUILD="windows"
			export WGET_EXE="/$LETTER_HOME_DRIVER/ProgramData/chocolatey/bin/wget.exe"
		;;
	esac
	 #MSYS_TEMP != %temp%
	which git
	if [ $? != 0 ]; then
		export PATH="$PATH:/$LETTER_HOME_DRIVER/Program Files/Git/bin"
	fi
fi
export PATH_TO_FPC="/$LETTER_HOME_DRIVER/laz4android1.8/fpc/3.0.4/bin/i386-win32"
export PATH_TO_LAZ4ANDROID="/$LETTER_HOME_DRIVER/laz4android1.8/"
export WIN_PATH_TO_LAZ4ANDROID="$WIN_LETTER_HOME_DRIVER\laz4android1.8"
export WIN_PATH_TO_FPC="$WIN_LETTER_HOME_DRIVER\laz4android1.8\fpc\3.0.4\bin\i386-win32"
export PATH="$PATH:$PATH_TO_FPC"

MINGW_URL="http://osdn.net/projects/mingw/downloads/68260/mingw-get-setup.exe"
WIN_PROGR="git.install svn jdk8  7zip.install ant  "
MINGW_PACKAGES="msys-wget-bin  mingw32-base-bin mingw-developer-toolkit-bin msys-base-bin msys-zip-bin "
MINGW_OPT="--reinstall"


	#unzip wrappers to windows 
	


LAMW_INSTALL_VERSION="0.2.0-Rv13-12-2018"
LAMW_INSTALL_WELCOME=(
	"\t\tWelcome LAMW4Linux Installer from MSYS2  version: [$LAMW_INSTALL_VERSION]\n"
	"\t\tPowerd by DanielTimelord\n"
	"\t\t<oliveira.daniel109@gmail.com>\n"
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
ANDROID_HOME="$USER_DIRECTORY/android"
ANDROID_SDK="$ANDROID_HOME/sdk"
#ANDROID_HOME for $win 

BARRA_INVERTIDA="\""
#------------ PATHS translated for windows------------------------------
WIN_ANDROID_HOME="$WIN_USER_DIRECTORY\android"
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
export JAVA_PATH=""
export SDK_TOOLS_URL="http://dl.google.com/android/repository/sdk-tools-windows-3859397.zip" 
export NDK_URL="http://dl.google.com/android/repository/android-ndk-r16b-windows-x86_64.zip"
SDK_VERSION="28"
SDK_MANAGER_CMD_PARAMETERS=()
SDK_MANAGER_CMD_PARAMETERS2=()
SDK_LICENSES_PARAMETERS=()
LAZARUS_STABLE_SRC_LNK="http://svn.freepascal.org/svn/lazarus/tags/lazarus_1_8_4"
LAMW_SRC_LNK="http://github.com/jmpessoa/lazandroidmodulewizard"
LAZ4_LAMW_PATH_CFG="/$LETTER_HOME_DRIVER/laz4android1.8/config"
LAZ4LAMW_HOME="$USER_DIRECTORY/Laz4Lamw"
LAMW_IDE_HOME="$LAZ4LAMW_HOME/lazarus_stable" # path to link-simbolic to ide 
LAMW_WORKSPACE_HOME="$USER_DIRECTORY/Dev/LAMWProjects"  #piath to lamw_workspace
LAZ4LAMW_EXE_PATH="$LAMW_IDE_HOME/Laz4Lamw"
LAMW_MENU_ITEM_PATH="$USER_DIRECTORY/.local/share/applications/Laz4Lamw.desktop"
GRADLE_HOME="$ANDROID_HOME/gradle-4.4.1"
ANT_HOME="$ANDROID_HOME/apache-ant-1.10.5"
#WIN_GRADLE_HOME=
GRADLE_CFG_HOME="$USER_DIRECTORY/.gradle"

GRADLE_ZIP_LNK="http://services.gradle.org/distributions/gradle-4.4.1-bin.zip"
GRADLE_ZIP_FILE="gradle-4.4.1-bin.zip"
ANT_ZIP_LINK="http://mirror.nbtelecom.com.br/apache/ant/binaries/apache-ant-1.10.5-bin.zip"
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
export OLD_ANDROID_SDK=0

#--------------Win32 functions-------------------------

winMKLinkDir(){
	if [ $# = 2 ]; then
		#getWinEnvPaths "TEMP"
		#echo "LinkDir:target=$1 link=$2"
		#rm  /tmp/winMKLink.bat
		#win_temp_path=$(getWinEnvPaths "HOMEDRIVE")
		if [ ! -e "$2" ]; then
			win_temp_path="$WIN_MSYS_TEMP_HOME/winMKLink.bat"
			echo "mklink /D $2 $1" > /tmp/winMKLink.bat 
			winCallfromPS $win_temp_path
			if [ -e /tmp/winMKLink.bat  ]; then
				rm  /tmp/winMKLink.bat 
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
			echo "mklink  $aspas$2$aspas $aspas$1$aspas" > /tmp/winMKLink.bat 
			#read
			winCallfromPS $win_temp_path
			if [ -e /tmp/winMKLink.bat  ]; then
				rm  /tmp/winMKLink.bat 
			fi
		fi
	fi
}
unzip(){
		#/$LETTER_HOME_DRIVER/Program\ Files/7-zip/7z.exe x $*
		7z.exe x $*
}
InstallWinADB(){
	changeDirectory $ANDROID_HOME
	if [ ! -e adbdriver ]; then 
		mkdir "adbdriver"
		changeDirectory "adbdriver" 
		$WGET_EXE -c $ADB_WIN_DRIVER_LINK
		if [ $? != 0 ]; then
			$WGET_EXE -c $ADB_WIN_DRIVER_LINK
		fi
			unzip $ADB_WIN_DRIVER_ZIP
		if [ -e $ADB_WIN_DRIVER_ZIP ]; then
			rm $ADB_WIN_DRIVER_ZIP
		fi
	fi

	if  [ -e $ANDROID_HOME/adbdriver ]; then
		changeDirectory $ANDROID_HOME/adbdriver
		printf "\n\n%s\n\n" "please conect your smartphone to PC and Install the ADBDriver ..."
		./ADBDriverInstaller.exe
	fi
}
getAnt(){
	changeDirectory $ANDROID_HOME 
	if [ ! -e $ANT_HOME ]; then
		$WGET_EXE -c $ANT_ZIP_LINK
		if [ $? != 0 ] ; then
			#rm *.zip*
			$WGET_EXE -c $ANT_ZIP_LINK
		fi
		#echo "$PWD"
		#sleep 3
		unzip "$ANT_ZIP_FILE"
	fi

	if [ -e  $ANT_ZIP_FILE ]; then
		rm $ANT_ZIP_FILE
	fi
}
getAndroidSDKToolsW32(){
	changeDirectory $USER_DIRECTORY
	if [ ! -e $ANDROID_HOME ]; then
		mkdir $ANDROID_HOME
	fi
	
	changeDirectory $ANDROID_HOME
	if [ ! -e $GRADLE_HOME ]; then
		$WGET_EXE -c $GRADLE_ZIP_LNK
		if [ $? != 0 ] ; then
			#rm *.zip*
			$WGET_EXE -c $GRADLE_ZIP_LNK
		fi
		#echo "$PWD"
		#sleep 3
		unzip "$GRADLE_ZIP_FILE"
	fi

	if [ -e  $GRADLE_ZIP_FILE ]; then
		rm $GRADLE_ZIP_FILE
	fi
	#ANT
	
	#mkdir
	#changeDirectory $ANDROID_SDK
	if [ ! -e sdk ] ; then
		mkdir sdk
	fi
		changeDirectory sdk
		if [ ! -e tools ]; then  
			$WGET_EXE -c $SDK_TOOLS_URL #getting sdk 
			if [ $? != 0 ]; then 
				$WGET_EXE -c $SDK_TOOLS_URL
			fi
			unzip "sdk-tools-windows-3859397.zip"
		fi
		
		#mv "sdk-tools-windows-3859397" "tools"

		if [ -e  "sdk-tools-windows-3859397.zip" ]; then
			rm  "sdk-tools-windows-3859397.zip"
		fi
	#fi
}
#Get Gradle and SDK Tools
getOldAndroidSDKToolsW32(){
	changeDirectory $USER_DIRECTORY
	if [ ! -e $ANDROID_HOME ]; then
		mkdir $ANDROID_HOME
	fi
	
	changeDirectory $ANDROID_HOME
	getAnt
	if [ ! -e $GRADLE_HOME ]; then
		$WGET_EXE -c $GRADLE_ZIP_LNK
		if [ $? != 0 ] ; then
			#rm *.zip*
			$WGET_EXE -c $GRADLE_ZIP_LNK
		fi
		#echo "$PWD"
		#sleep 3
		unzip "$GRADLE_ZIP_FILE"
	fi
	
	if [ -e  $GRADLE_ZIP_FILE ]; then
		rm $GRADLE_ZIP_FILE
	fi
	#mkdir
	#changeDirectory $ANDROID_SDK
	if [ ! -e sdk ] ; then
		mkdir sdk
	fi
		changeDirectory sdk
		export SDK_TOOLS_URL="http://dl.google.com/android/installer_r24.0.2-windows.exe" 
		$WGET_EXE -c $SDK_TOOLS_URL #getting sdk 
		if [ $? != 0 ]; then 
			$WGET_EXE -c $SDK_TOOLS_URL
		fi
		./installer_r24.0.2-windows.exe
	#fi

	if [ ! -e $ANDROID_SDK/ndk-bundle ]; then
		changeDirectory $ANDROID_SDK
		$WGET_EXE -c $NDK_URL
		if [ $? != 0 ]; then 
			$WGET_EXE -c $NDK_URL
		fi
		unzip android-ndk-r16b-windows-x86_64.zip
		mv android-ndk-r16b ndk-bundle
		if [ -e android-ndk-r16b-windows-x86_64.zip ]; then
			rm android-ndk-r16b-windows-x86_64.zip
		fi
	fi


}



winCallfromPS1(){
	args=($*)
	installer_cmd="$ANDROID_SDK/tools/bin/sdk-install.bat"
	win_installer_cmd="$WIN_ANDROID_SDK\tools\bin\sdk-install.bat"
	
	printf " \"%s\" \"%s\""  "${args[0]}"  "${args[1]}" > $installer_cmd
	
	winCallfromPS "$win_installer_cmd"
	if [ -e  /tmp/pscommand.ps1 ]; then 
		rm /tmp/pscommand.ps1
	fi

	if [ -e $installer_cmd ];then 
		chmod 777 $installer_cmd
		rm  $installer_cmd
	fi

}
	

updateWinPATHS(){
	cmd_paths='\ProgramData\chocolatey\bin\RefreshEnv'
	WIN_SVN_PATH_WIN64="/$LETTER_HOME_DRIVER/Program Files (x86)/Subversion/bin/svn"
	WIN_SVN_PATH_WIN32="/$LETTER_HOME_DRIVER/Program Files/Subversion/bin/svn"
	winCallfromPS "$cmd_paths"
	new_cmd_path='echo $PATH' 
	echo "$new_cmd_path" > /tmp/update-win-path.sh
	if [ $? !=  0 ]; then
		echo "not write"
		exit 1
	fi
	new_path=$(bash /tmp/update-win-path.sh)
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
			"platforms;android-26" 
			"build-tools;26.0.2" 
			#"tools" 
			"ndk-bundle" 
			"extras;android;m2repository" 
			--no_https 
			--proxy=http 
			--proxy_host=$PROXY_SERVER 
			--proxy_port=$PORT_SERVER 
		)
		SDK_MANAGER_CMD_PARAMETERS2=("ndk-bundle" "extras;android;m2repository" --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		SDK_LICENSES_PARAMETERS=( --licenses --no_https --proxy=http --proxy_host=$PROXY_SERVER --proxy_port=$PORT_SERVER )
		export http_proxy=$PROXY_URL
		export https_proxy=$PROXY_URL
#	ActiveProxy 1
	else
		SDK_MANAGER_CMD_PARAMETERS=(
		"platforms;android-26" 
		"build-tools;26.0.2" 
		#"tools"
		"ndk-bundle" 
		"extras;android;m2repository"
		)			#ActiveProxy 0
		SDK_MANAGER_CMD_PARAMETERS2=("ndk-bundle" "extras;android;m2repository")
		SDK_LICENSES_PARAMETERS=(--licenses )
	fi
}
#Get FPC Sources
getFPCSources(){
	changeDirectory $USER_DIRECTORY
	mkdir -p $LAZ4LAMW_HOME/fpcsrc
	changeDirectory $LAZ4LAMW_HOME/fpcsrc
	svn checkout "$URL_FPC"
	if [ $? != 0 ]; then
		#rm $FPC_RELEASE/.svn -r
		rm -r $FPC_RELEASE
		svn checkout $URL_FPC
		if [ $? != 0 ]; then 
			rm -r $FPC_RELEASE
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
}
#get Lazarus Sources
getLazarusSources(){
	changeDirectory $LAZ4LAMW_HOME
	svn co $LAZARUS_STABLE_SRC_LNK
	if [ $? != 0 ]; then  #case fails last command , try svn chekout 
		rm -r $LAZARUS_STABLE
		#svn cleanup
		#changeDirectory $LAZ4LAMW_HOME
		svn co $LAZARUS_STABLE_SRC_LNK
		if [ $? != 0 ]; then 
			rm -r $LAZARUS_STABLE
			echo "possible network instability! Try later!"
			exit 1
		fi
		#svn revert -R  $LAMW_SRC_LNK
	fi
}

#GET LAMW FrameWork

getLAMWFramework(){
	changeDirectory $ANDROID_HOME
	export git_param=("clone" "$LAMW_SRC_LNK")
	if [ -e lazandroidmodulewizard/.git ]  ; then
		changeDirectory "$ANDROID_HOME/lazandroidmodulewizard"
		export git_param=("pull")
	fi
	
	git ${git_param[*]}
	if [ $? != 0 ]; then #case fails last command , try svn chekout
		
		export git_param=("clone" "$LAMW_SRC_LNK")
		cd $ANDROID_HOME
		chmod 777 -Rv lazandroidmodulewizard
		rm -r lazandroidmodulewizard
		git ${git_param[*]}
		if [ $? != 0 ]; then 
			rm -r lazandroidmodulewizard
			echo "possible network instability! Try later!"
			exit 1
		fi
	fi
	
}



getSDKAndroid(){
	changeDirectory $ANDROID_SDK/tools/bin #change directory
	
	yes |  winCallfromPS1 "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	if [ $? != 0 ]; then 
			yes | winCallfromPS1 "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_LICENSES_PARAMETERS[*]}
	fi

	for((i=0;i<${#SDK_MANAGER_CMD_PARAMETERS[*]};i++))
	do
		echo "please wait... "
		winCallfromPS1 "$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_MANAGER_CMD_PARAMETERS[i]}  # instala sdk sem intervenção humana  

		if [ $? != 0 ]; then 
			winCallfromPS1 "$$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" ${SDK_MANAGER_CMD_PARAMETERS[i]}
		fi
		#winCallfromPS1 "$WIN_LETTER_HOME_DRIVER$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "ndk-bundle"

		#if [ $? != 0 ]; then 
		#	winCallfromPS1 "$WIN_LETTER_HOME_DRIVER$WIN_ANDROID_SDK\tools\bin\sdkmanager.bat" "ndk-bundle"
		#fi

	done

}

getOldAndroidSDK(){

	if [ -e $ANDROID_SDK/tools/android.bat  ]; then 
		#changeDirectory $ANDROID_SDK/tools
		winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk "
		#./android update sdk
		echo "--> After update sdk tools to 24.1.1"
		#schangeDirectory $ANDROID_SDK/tools
		#./android update sdk
		winCallfromPS "$WIN_ANDROID_SDK\tools\android.bat" "update" "sdk"

		#echo "please wait ..."
		#read 
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
		changeDirectory $LAZ4LAMW_HOME/fpcsrc 
		changeDirectory $FPC_RELEASE
		bar='/'
		case $1 in 
			0 )
				make clean
			#	str="$WIN_LAZ4LAMW_HOME\fpcsrc"
			#	bar='\'
			#	str="$str$bar$FPC_RELEASE"
			#	echo "str=$str"
				#read
			#	makeFromPS "$str" ${FPC_CROSS_ARM_MODE_FPCDELUXE[*]}
				# 777  -Rv $LAZ4LAMW_HOME/fpcsrc$bar$FPC_RELEASE
				make crossall crossinstall  CPU_TARGET=arm OPT="-dFPC_ARMEL" OS_TARGET=android CROSSOPT="-CpARMV7A -CfVFPV3" INSTALL_PREFIX=/$LETTER_HOME_DRIVER/tools/freepascal
				#echo "press enter to exit BuildCrossArm" ; read
			;;

		esac
	fi				
}

#Build lazarus ide

BuildLazarusIDE(){

	#changeDirectory $LAMW_IDE_HOME
	changeDirectory "$PATH_TO_LAZ4ANDROID"
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
		echo "cd \"$WIN_PATH_TO_LAZ4ANDROID\"" > $build_win_cmd
		echo "lazbuild ${WIN_LAZBUILD_PARAMETERS[i]}" >> $build_win_cmd
		winCallfromPS "$WIN_LETTER_HOME_DRIVER\generate-lazarus.bat"
		if [ $? != 0 ]; then 
			winCallfromPS "$WIN_LETTER_HOME_DRIVER\generate-lazarus.bat"
		fi

	done
	
	if [ -e $build_win_cmd ]; then
		rm $build_win_cmd
	fi
	#echo  "lazarus --primary-config-path=$WIN_LETTER_HOME_DRIVER$WIN_PATH_LAZ4ANDROID_CFG" > start_laz4lamw.bat
}
#Esta função imprime o valor de uma váriavel de ambiente do MS Windows 
#this  fuction create a INI file to config  all paths used in lamw framework 
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
	java_path=$(getWinEnvPaths "JAVA_HOME" )
	tam=${#java_versions[@]} #tam recebe o tamanho do vetor 
	#ant_path=$(getWinEnvPaths "ANT_HOME" )
	


# contem o arquivo de configuração do lamw
	LAMW_init_str=(
		"[NewProject]"
		"PathToWorkspace=$WIN_LAMW_WORKSPACE_HOME"
		"PathToJavaTemplates=$WIN_USER_DIRECTORY\android\lazandroidmodulewizard\java"
		"PathToJavaJDK=$java_path"
		"PathToAndroidNDK=$WIN_USER_DIRECTORY\android\sdk\ndk-bundle"
		"PathToAndroidSDK=$WIN_USER_DIRECTORY\android\sdk"
		"PathToAntBin=$WIN_ANT_HOME\bin"
		"PathToGradle=$WIN_GRADLE_HOME"
		"PrebuildOSYS=$OS_PREBUILD"
		"MainActivity=App"
		"FullProjectName="
		"InstructionSet=0"''
		"AntPackageName=org.lamw"
		"AndroidPlatform=0"
		"AntBuildMode=debug"
		"NDK=5"
	)
	# "${LAMW_init_str[*]}"
	for ((i=0;i<${#LAMW_init_str[@]};i++))
	do
		if [ $i = 0 ]; then 
			echo "${LAMW_init_str[i]}" > "$LAZ4_LAMW_PATH_CFG/JNIAndroidProject.ini" 
		else
			echo "${LAMW_init_str[i]}" >> "$LAZ4_LAMW_PATH_CFG/JNIAndroidProject.ini"
		fi
	done
	#AddLAMWtoStartMenu
	if [ $OLD_ANDROID_SDK = 0 ]; then
		winMKLinkDir "$WIN_ANDROID_SDK\ndk-bundle\toolchains\arm-linux-androideabi-4.9" "$WIN_ANDROID_SDK\ndk-bundle\toolchains\mipsel-linux-android-4.9"
		winMKLinkDir "$WIN_ANDROID_SDK\ndk-bundle\toolchains\arm-linux-androideabi-4.9" "$WIN_ANDROID_SDK\ndk-bundle\toolchains\mips64el-linux-android-4.9"
	fi


}
#Add LAMW4Linux to menu 

#cd not a native command, is a systemcall used to exec, read more in exec man 
changeDirectory(){
	#echo "args=$# args=$*";read
	if [ $# = 1 ]; then 
		if [ "$1" != "" ] ; then
			if [ -e $1  ]; then
				cd $1
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
		if [ -e $ANDROID_HOME/sdk/unistall.exe ]; then
			$ANDROID_HOME/sdk/unistall.exe
		fi
		if [ -e $USER_DIRECTORY/mingw-get-setup.exe ]; then
			rm $USER_DIRECTORY/mingw-get-setup.exe
		fi
	fi
	winCallfromPS "taskkill /im adb.exe /f"
	if [ $? = 0 ]; then
		echo "adb process stopped..."
	fi
	if [ -e $USER_DIRECTORY/laz4ndroid ]; then
		rm  -r $USER_DIRECTORY/laz4ndroid
	fi
	if [ -e $USER_DIRECTORY/.laz4android ] ; then
		rm -r $USER_DIRECTORY/.laz4android
	fi

	if [ -e $ANDROID_HOME ] ; then
		chmod 777 -Rv $ANDROID_HOME
		rm -r $ANDROID_HOME  
	fi

	if [ -e $USER_DIRECTORY/.android ]; then
		chmod 777 -R  $USER_DIRECTORY/.android
		rm -r  $USER_DIRECTORY/.android
	fi 



	if [ -e $GRADLE_CFG_HOME ]; then
		rm -r $GRADLE_CFG_HOME
	fi

	# if [ -e usr/bin/arm-embedded-as ] ; then    
	# 	rm usr/bin/arm-embedded-as
	# fi
	# if [ -e  /usr/bin/arm-linux-androideabi-ld ]; then
	# 	 rm /usr/bin/arm-linux-androideabi-ld
	# fi
	# if [ -e /usr/bin/arm-embedded-ld  ]; then
	# 	/usr/bin/arm-embedded-ld           
	# fi 
	# if [ -e /usr/bin/arm-linux-as ] ; then 
	#  	rm  /usr/bin/arm-linux-as
	# fi
	# if [ -e /usr/lib/fpc/$FPC_VERSION/fpmkinst/arm-android ]; then
	# 	rm -r /usr/lib/fpc/$FPC_VERSION/fpmkinst/arm-android
	# fi
	
	##if [ -e "$work_home_desktop/Laz4Lamw.desktop" ]; then
	##	rm "$work_home_desktop/Laz4Lamw.desktop"
	#fi
	# if [ -e /usr/bin/arm-linux-androideabi-as.exe ]; then
	# 	rm /usr/bin/arm-linux-androideabi-as.exe
	# fi
	# if [ -e /usr/bin/arm-linux-ld.exe ] ; then 
	# 	rm /usr/bin/arm-linux-ld.exe
	# fi
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
	lamw_log_str=("Generate LAMW4Linux Intaller Version $LAMW_INSTALL_VERSION" "LAMW workspace : $WIN_LAMW_WORKSPACE_HOME" "Android SDK:$WIN_ANDROID_HOME\sdk" "Android NDK:$WIN_ANDROID_HOME\ndk" "Gradle:$WIN_GRADLE_HOME" "LOG:$WIN_ANDROID_HOME\lamw-install.log")
	for((i=0; i<${#lamw_log_str[*]};i++)) 
	do
		printf "%s\n"  "${lamw_log_str[i]}"
		if [ $i = 0 ] ; then 
			printf "%s\n" "${lamw_log_str[i]}" > $ANDROID_HOME/lamw-install.log
		else
			printf "%s\n" "${lamw_log_str[i]}" >> $ANDROID_HOME/lamw-install.log 
		fi
	done		
}

mainInstall(){

	#installDependences
	#checkProxyStatus
	#configureFPC
	WrappergetAndroidSDKTools
	changeDirectory $ANDROID_SDK/tools/bin #change directory
	#unistallJavaUnsupported
	#setJava8asDefault
	#getSDKAndroid
	WrappergetAndroidSDK
	#getFPCSources
	getLAMWFramework
	#getLazarusSources

	changeDirectory $USER_DIRECTORY
	#CleanOldCrossCompileBin
	changeDirectory $FPC_RELEASE
	#BuildCrossArm $FPC_ID_DEFAULT
	#enableCrossCompile
	BuildLazarusIDE
	changeDirectory $ANDROID_HOME
	LAMW4LinuxPostConfig
	InstallWinADB
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
	echo "LAMW-Install (Native Support:Linux supported Debian 9, Ubuntu 16.04 LTS, Linux Mint 18)
	Windows Compability (from MSYS2): Windows 7 SP1, Windows 8.1, Windows 10"

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
	"clean")
		CleanOldConfig
	;;
	"install")
		
		mainInstall
	;;

	"install=sdk24")
		printf "Mode SDKTOOLS=24 with ant support "
		export OLD_ANDROID_SDK=1

		mainInstall
	;;

	"clean-install")
		#initParameters $2
		CleanOldConfig
		mainInstall
	;;

	"update-lamw")
		echo "Updating LAMW";
		getLAMWFramework "pull";
		#sleep 1;
		BuildLazarusIDE;
	;;

	"mkcrossarm")
		configureFPC 
		changeDirectory $FPC_RELEASE
		BuildCrossArm $FPC_ID_DEFAULT
	;;
	"delete_paths")
		cleanPATHS
	;;
	"update-config")
		LAMW4LinuxPostConfig
	;;
	"update-links")
		#CreateSDKSimbolicLinks
	;;
	*)
		lamw_opts=(
			"Usage:\n\tbash lamw-install.sh [Options]\n"
			"\tbash lamw-install.sh clean\n"
			"\tbash lamw-install.sh install\n"
			"\tbash lawmw-install.sh install --force\n"
			"\tbash lamw-install.sh install --use_proxy\n"
			"\tbash lawmw-install.sh install=sdk24"
			"----------------------------------------------\n"
			"\tbash lamw-install.sh install --use_proxy --server [HOST] --port [NUMBER] \n"
			"sample:\n\tbash lamw-install.sh install --use_proxy --server 10.0.16.1 --port 3128\n"
			"-----------------------------------------------\n"
			"\tbash lamw-install.sh clean-install\n"
			"\tbash lamw-install.sh clean-install --force\n"
			"\tbash lamw-install.sh clean-install --use_proxy\n"
			"\tbash lamw-install.sh update-lamw\n"
			)
		printf "%s\U\n" "${lamw_opts[*]}"
	;;
	
esac
