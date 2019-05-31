#This scripts set as env path 
function detectArch(){
   [bool] $flag_arch=systeminfo | Select-String -pattern 'x64-based'
    if ( $flag_arch -eq $true ){
        return "amd64"
    }else {
        return "x86"
    }
}

function prepareEnv(){
    $ARCH=detectArch
    if ( $ARCH = "amd64" ){
        $MSYS_EXEC="C:\tools\msys64\usr\bin"
    }else{
        $MSYS_EXEC="C:\tools\msys32\usr\bin"
    }
    return $MSYS_EXEC

}
function getLastChar(){
    $test_str=$ARGS[0]
    $lengh_str=$test_str.Length - 1
    $ret=$test_str.Substring($lengh_str,1)
    echo $ret
    return $ret
}
function writeLAMWManagerbat(){
    $MSYS_EXEC=prepareEnv
    $BASH_PATH=$MSYS_EXEC + '\' + 'bash.exe'
    $buffer_lamw=@(
    '@echo off',
    "SET BASH_PATH=$BASH_PATH",
    "cd C:\lamw_manager",
    "",
    "if exist %BASH_PATH% (goto :RunLAMWMgr ) else (goto :RestoreMsys)",
    "",
    "",
    ":RestoreMsys",
    "C:\lamw_manager\repair-msys.bat",
    "C:\lamw_manager\preinstall.bat",
    "goto :End",
    "",
    "",
    ":RunLAMWMgr",
    "echo %BASH_PATH%",
    "%BASH_PATH% simple-lamw-install.sh %*",
    "goto :End",
    "",
    "",
    ":End",
    "pause"
    )
    $test=$env:homepath + '\' +'Desktop' + '\' + 'out.bat'
    $fp=[System.IO.StreamWriter] $test
    if ( Test-Path $test) {
        Remove-Item $test
    }
    for($i=0;$i -lt $buffer_lamw.Count;$i++){
        # if ( $i -eq  0 ){
        $str=$buffer_lamw[$i]
        $fp.WriteLine($str)
        #     $buffer_lamw[$i] > $test
        # }else{
        #     $buffer_lamw[$i] >> $test
        # }
    }
    $fp.close()
}



$ARCH=detectArch
$OLD_FPC_PATH="C:\laz4android1.8\fpc\3.0.4\bin\i386-win32"
$MSYS_EXEC=prepareEnv
$LAZ4ANDROID_STABLE_VERSION="2.0.0"
$LAZ4ANDROID_HOME="C:\LAMW4Windows\laz4android" + $LAZ4ANDROID_STABLE_VERSION 
$FPC_PATH= $LAZ4ANDROID_HOME +"\fpc\3.0.4\bin\i386-win32"
echo "LAZ4ANDROID_HOME=$LAZ4ANDROID_HOME"
echo "FPC_PATH=$FPC_PATH"

if ( $ARCH = "amd64" ){
    $MSYS_EXEC="C:\tools\msys64\usr\bin"
}else{
    $MSYS_EXEC="C:\tools\msys32\usr\bin"
}
function RepairPath(){
    $lamw_cfg_path="C:\laz4lamwpaths.txt"
    $old_env_path=$env:path
    $new_path=""
    #echo "old_env_path=$old_env_path"
    if (  (Test-Path $lamw_cfg_path ) ){
        if ( $old_env_path.Contains($MSYS_EXEC)){
            $old_env_path=$old_env_path.Replace("$MSYS_EXEC"+';',"")
        }

        if ( $old_env_path.Contains($OLD_FPC_PATH )){
            $old_env_path=$old_env_path.Replace("$OLD_FPC_PATH"+';','')
        }
        
        #verifica se o último caractere é um ; (ponto e vírgula)
        if ( ! ( ( getLastChar $old_env_path ) -eq ';') ){
            $old_env_path= $old_env_path + ';'
        }else{
            echo "always exists ';'"
        }
        $new_path=$old_env_path + $MSYS_EXEC +';'  + $FPC_PATH  + ';'
        echo "nova_path $new_path"
        SETX /M PATH "$new_path"
        rm -Force $lamw_cfg_path

    }else{
       if ( ! ( ( getLastChar $old_env_path ) -eq ';') ){
            $old_env_path= $old_env_path + ';'
        }else{
            echo "always exists ';'"
        }
        if ( ! $old_env_path.Contains($MSYS_EXEC)){
            $new_path=$new_path + $MSYS_EXEC +';'
        
            if (! $old_env_path.Contains($FPC_PATH+ ';')){
                $new_path=$new_path + $FPC_PATH + ';'
            }
            $new_path= $old_env_path + $new_path
            echo "new_path=$new_path"
            SETX /M PATH "$new_path"
        }else{
            echo "always path updated..."
        }
    }
}



$OLD_PATH=$env:PATH 
#echo "ARCH=$ARCH
#echo "OLD_FPC_PATH=$OLD_FPC_PATH"
#echo "OLD_PATH=$OLD_PATH"
#RepairPath
writeLAMWManagerbat
