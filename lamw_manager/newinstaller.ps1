#LAMW Manager for windows
$LAMW_MANAGER_VERSION="0.3.0"
$HOME_USER=$env:homepath
$ROOT_LAMW="$home_user" + "\" + "LAMW"
$ANT_URL="http://ftp.unicamp.br/pub/apache/ant/binaries/apache-ant-1.10.5-bin.zip"
$ANT_ZIP="apache-ant-1.10.5-bin.zip"
$ANT_HOME="apache-ant-1.10.5"
$ANT_VERSION="1.10.5"

$GRADLE_URL="http://services.gradle.org/distributions/gradle-4.4.1-bin.zip"
$GRADLE_ZIP="gradle-4.4.1-bin.zip"
$GRADLE_HOME="gradle-4.4.1"
$GRADLE_VERSION="4.4.1"


$SDK_TOOLS_URL="https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip"
$SDK_TOOLS_ZIP="sdk-tools-windows-4333796.zip"
$SDK_TOOLS_VERSION="26.1.1"

$NDK_URL=""
$NDK_ZIP=""
$NDK_VERSION=""

$SDK_VERSION="28"
$ARCH=""
$OS_PREBUILD=""
$NATIVE_WINDOWS_SUPPPORT=0

#Baixa um arquivo da Web , 
#ARG0 eh a url
#ARG1 eh o caminho do diretorio  com o nome do arquivo exemplo C:\Users\Daniel\apache-ant.zip
function getFile(){
    $URL=$ARGS[0];
    $client = New-Object System.Net.WebClient;
    $path=$ARGS[1];
    echo "url=$URL path=$path";
    $client.DownloadFile($URL, $path);
    if ( $? -eq $false ){
        $client.DownloadFile($URL, $path);
        if ( $? -eq $false ){
            echo "Falls, try latter!"
        }
    }
}

#this function enable package manager 
function enableChocolateyPackageManager(){
    $psh_path="$env:SystemRoot\System32"
    echo $psh_path
   # powershell.exe Set-ExecutionPolicy AllSigned
    powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    $env:PATH="$env:PATH;$env:ALLUSERSPROFILE\chocolatey\bin"

}
#[bool]
function installDependencies(){
    $packages = @("mingw","msys2", "git.install", "zulu8","7zip.install", "wget" )
    for($i=0;$i -lt $packages.Count;$i++){
        choco install  $packages[$i] -y 
        if ( $? -eq $false ){
            choco install $packages[$i] -y --force
            if ( $? -eq $false ){
                echo "Install falls, try later!"
                exit 1
            }
        }

    }
    
}
function detectArch(){
   [bool] $flag_arch=systeminfo | Select-String -pattern 'x64-based'
    if ( $flag_arch -eq $true ){
        return "amd64"
    }else {
        return "x86"
    }

}

enableChocolateyPackageManager
installDependencies
$ARCH=detectArch
#getFile $ANT_URL C:\Users\Daniel