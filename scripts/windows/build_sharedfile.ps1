# !/bin/pwsh

$env:COMMIT = $(git log -1 --pretty=format:"%H")
New-Item "build\git_commit_version.txt" -ItemType File -Value $env:COMMIT -Force
$env:VERSIONS_FILE = "..\..\lib\git_versions.dart"
$env:EXAMPLE_VERSIONS_FILE = "..\..\lib\git_versions_example.dart"
Copy-Item $env:EXAMPLE_VERSIONS_FILE -Destination $env:VERSIONS_FILE
$env:OS = "WINDOWS"
(Get-Content $env:VERSIONS_FILE).replace('WINDOWS_VERSION = ""', "WINDOWS_VERSION = ""${env:COMMIT}""") | Set-Content $env:VERSIONS_FILE
# Disabled because final build needs to be done by MSYS2
Write-Output "Continue build process in MSYS2 (Build mobileliblelantus)"
#cd build
#cmake mobileliblelantus
#msbuild mobileliblelantus.sln
