# !/bin/pwsh

$env:WORKDIR="${pwd}\build"

$TeamCityConfPath = 'C:\TeamCity\buildAgent\conf\buildAgent.properties'
Copy-Item .\CMakeLists\mobileliblelantus\template_CMakeLists.txt -Destination .\CMakeLists\mobileliblelantus\CMakeLists.txt
(Get-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt).replace('/opt/android', $env:WORKDIR) | Set-Content .\CMakeLists\mobileliblelantus\CMakeLists.txt
Copy-Item .\CMakeLists\secp256k1\template_CMakeLists.txt -Destination .\CMakeLists\secp256k1\CMakeLists.txt
(Get-Content .\CMakeLists\secp256k1\CMakeLists.txt).replace('/opt/android', $env:WORKDIR) | Set-Content .\CMakeLists\secp256k1\CMakeLists.txt
Write-Output "edited CMakeLists"
