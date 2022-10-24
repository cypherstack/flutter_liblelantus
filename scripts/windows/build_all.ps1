#! /usr/bin/pwsh

Write-Output "Execute this script from a Visual Studio Developer PowerShell"

New-Item -ItemType Directory -Force -Path build
./build_openssl.ps1
