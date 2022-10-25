# !/bin/pwsh

Write-Output "installing missing headers"

New-Item -ItemType Directory -Force -Path build/openssl/include
Copy-Item "CMakeLists\missingheader\endian.h" -Destination "build\openssl\include\"
