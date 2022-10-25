#! /usr/bin/pwsh

if ((Test-Path -Path ".\build\openssl-1.1.1k\openssl\")) {
    Copy-Item ".\build\openssl-1.1.1k\openssl\*" -Destination ".\build\openssl" -Force -Recurse # TODO add \bin to PATH?
}

./copymobile.ps1
./linkDistros.ps1
./copyCMakeLists.ps1
./build_sharedfile.ps1
