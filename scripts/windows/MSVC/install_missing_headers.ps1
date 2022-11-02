# !/bin/pwsh

Write-Output "installing missing headers"

New-Item -ItemType Directory -Force -Path build/prefix_x86_64/openssl/include
Copy-Item "CMakeLists\missingheader\endian.h" -Destination "build\prefix_x86_64\openssl\include\"
