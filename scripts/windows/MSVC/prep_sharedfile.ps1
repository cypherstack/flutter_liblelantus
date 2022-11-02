#! /usr/bin/pwsh

./config.ps1

if ((Test-Path -Path "${env:CWORKDIR}/openssl/Program Files")) {
    Copy-Item "${env:CWORKDIR}/openssl/Program Files/OpenSSL/*" -Destination "${env:PREFIX}/openssl" -Force -Recurse # TODO add \bin to PATH?
}

New-Item -ItemType Directory -Force -Path build
New-Item -ItemType Directory -Force -Path build\bitcoin
New-Item -ItemType Directory -Force -Path build\include
New-Item -ItemType Directory -Force -Path build\secp256k1
New-Item -ItemType Directory -Force -Path build\src
New-Item -ItemType Directory -Force -Path build\tests
Copy-Item ..\..\mobileliblelantus -Destination .\build -Force -Recurse
Write-Output "copied ..\..\mobileliblelantus to .\build"

Copy-Item .\CMakeLists\mobileliblelantus\template_CMakeLists.txt -Destination .\CMakeLists\mobileliblelantus\CMakeLists.txt
(Get-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt).replace('/opt/android', $env:CWORKDIR) | Set-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt
Copy-Item .\CMakeLists\secp256k1\template_CMakeLists.txt -Destination .\CMakeLists\secp256k1\CMakeLists.txt
(Get-Content .\CMakeLists\secp256k1\CMakeLists.txt).replace('/opt/android', $env:CWORKDIR) | Set-Content .\CMakeLists\secp256k1\CMakeLists.txt
Write-Output "edited CMakeLists"

Copy-Item "CMakeLists\mobileliblelantus\dart_interface.cpp" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\Utils.cpp" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\Utils.h" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\CMakeLists.txt" -Destination "build\mobileliblelantus\"
Copy-Item "CMakeLists\secp256k1\CMakeLists.txt" -Destination "build\mobileliblelantus\secp256k1\"
Write-Output "copied CMakeLists"
