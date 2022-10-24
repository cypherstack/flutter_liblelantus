# !/bin/pwsh

Copy-Item "CMakeLists\mobileliblelantus\dart_interface.cpp" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\Utils.cpp" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\Utils.h" -Destination "build\mobileliblelantus\src\"
Copy-Item "CMakeLists\mobileliblelantus\CMakeLists.txt" -Destination "build\mobileliblelantus\"
Copy-Item "CMakeLists\secp256k1\CMakeLists.txt" -Destination "build\mobileliblelantus\secp256k1\"
Write-Output "copied CMakeLists"
