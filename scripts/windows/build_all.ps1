#! /usr/bin/pwsh

New-Item -ItemType Directory -Force -Path build
./build_openssl.ps1
