# This script is an uninstaller of LAMW4Windows and its dependencies!
echo "Warning: The entire development environment installed by LAMW Manager will be uninstalled!"
$LAMW_MANAGER_ROOT="$env:homedrive" + "\lamw_manager"
#array of commands
$lamw_manager_uninstall_cmds=@(
    "$LAMW_MANAGER_ROOT\lamw_manager.bat"
    "$LAMW_MANAGER_ROOT\unins000"
)


#array directorys to delete (of LAMW env and lamw_manager)
$del_paths=@(
    "$env:homedrive\tools"
    "$env:homedrive\ProgramData\Chocolatey"
    "$env:homedrive\LAMW4Windows"
    "$env:homedrive\$env:homepath\LAMW"
    "$LAMW_MANAGER_ROOT"
)

$flag=0
for($i=0; $i -lt $del_paths.Count;$i++){
    if ( ! ( Test-Path $del_paths[$i] ) ){
        $flag++
    }
}
if ( $flag -eq  $del_paths.count ){
    echo "lamw Environment has beeen uninstalled "
    exit 1
}
#run commands 
for($i=0;$i -lt $lamw_manager_uninstall_cmds.Count;$i++){
    $args="uninstall"
    if ( Test-Path $lamw_manager_uninstall_cmds[$i]){
        if ( $i -eq 0 ){
            & $lamw_manager_uninstall_cmds[$i] "uninstall"
        }
        else{
            & $lamw_manager_uninstall_cmds[$i]
        }
    }
}

powershell.exe Set-ExecutionPolicy Bypass
#uninstall programs installed by chocolatey package manager 
choco uninstall wget -y --purge
choco uninstall unzip -y --purge
choco uninstall mingw -y --purge
choco uninstall msys2 -y --purge
choco uninstall git.install -y --purge
#uninstall chocolatey
if ($env:ChocolateyToolsLocation) { Remove-Item -Recurse -Force "$env:ChocolateyToolsLocation" -WhatIf }
[System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'User')
[System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'Machine')

for($i=0; $i -lt $del_paths.Count;$i++){
    if ( Test-Path  $del_paths[$i] ){
        Remove-Item -Force -Recurse $del_paths[$i]
    }
}