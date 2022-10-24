# !/bin/pwsh

$env:WORKDIR="${pwd}/build"

$pattern = '[\\/]'
$env:CWORKDIR = $env:WORKDIR -replace $pattern, '/'

Copy-Item .\CMakeLists\mobileliblelantus\template_CMakeLists.txt -Destination .\CMakeLists\mobileliblelantus\CMakeLists.txt
(Get-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt).replace('/opt/android', $env:CWORKDIR) | Set-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt
Copy-Item .\CMakeLists\secp256k1\template_CMakeLists.txt -Destination .\CMakeLists\secp256k1\CMakeLists.txt
(Get-Content .\CMakeLists\secp256k1\CMakeLists.txt).replace('/opt/android', $env:CWORKDIR) | Set-Content .\CMakeLists\secp256k1\CMakeLists.txt
Write-Output "edited CMakeLists"
