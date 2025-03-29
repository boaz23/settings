# This script installs the Windows SysInternals suite to the "Program Files"
# folders. It separates the x64 and x32 executables to their respective folders.

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

function Mkdir-P {
    foreach ($d in $args) {
        if (!(Test-Path -PathType Container $d)) {
            New-Item -Type Directory $d | Out-Null
        }
    }
}

$name = "SysinternalsSuite"
$drive = "C"

Expand-Archive "$name.zip"
cd "$name"

try {
  Mkdir-P x32
  Mkdir-P x64
  Mkdir-P help

  Get-ChildItem -Name *64.exe | Move-Item -Destination x64
  Get-ChildItem -Name *.exe   | Move-Item -Destination x32
  Get-ChildItem -Name *.chm   | Move-Item -Destination help

  $x32_dir_path = "${drive}:\Program Files (x86)\$name"
  $x64_dir_path = "${drive}:\Program Files\$name"

  Mkdir-P "$x32_dir_path" "$x64_dir_path"
  Move-Item x32\*  "$x32_dir_path"
  Copy-Item help "$x32_dir_path" -Recurse
  Move-Item x64\*  "$x64_dir_path"
  Move-Item help "$x64_dir_path"
}
finally {
  cd ..
}
