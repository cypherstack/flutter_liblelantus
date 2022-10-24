# !/bin/pwsh

Write-Output "installing missing headers"

Copy-Item "CMakeLists\missingheader\endian.h" -Destination "build\secp256k1\include\"
