#! /usr/bin/pwsh

if ((Test-Path -Path ".\build\openssl-1.1.1k\openssl\")) {
    Copy-Item ".\build\openssl-1.1.1k\openssl\*" -Destination ".\build\openssl" -Force -Recurse # TODO add \bin to PATH?
}
if ((Test-Path -Path ".\build\openssl\OpenSSL")) {
    Copy-Item ".\build\openssl\OpenSSL\*" -Destination ".\build\openssl" -Force -Recurse # TODO add \bin to PATH?
}

./config.ps1
./copymobile.ps1
./linkDistros.ps1
./copyCMakeLists.ps1
./build_sharedfile.ps1
