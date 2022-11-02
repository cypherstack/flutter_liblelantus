#! /usr/bin/pwsh

Write-Output "Execute this script from a Visual Studio x64 Native Tools Command Prompt"

New-Item -ItemType Directory -Force -Path build
New-Item -ItemType Directory -Force -Path cache
./install_missing_headers.ps1
./build_openssl.ps1
./prep_sharedfile.ps1
./build_sharedfile.ps1