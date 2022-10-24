# !/bin/pwsh

Copy-Item ..\..\mobileliblelantus -Destination .\build -Force -Recurse
Write-Output "copied ..\..\mobileliblelantus to .\build"
