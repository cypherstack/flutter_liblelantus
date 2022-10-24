#! /usr/bin/pwsh

Write-Output "Execute this script from a Visual Studio x64 Native Tools Command Prompt"

New-Item -ItemType Directory -Force -Path build
./config.ps1
./install_missing_headers.ps1
./build_openssl.ps1
./copymobile.ps1
./linkDistros.ps1
./copyCMakeLists.ps1
./build_sharedfile.ps1
