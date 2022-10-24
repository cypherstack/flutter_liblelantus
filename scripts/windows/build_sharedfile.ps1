# !/bin/pwsh

#echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
$env:VERSIONS_FILE = "..\..\lib\git_versions.dart"
$env:EXAMPLE_VERSIONS_FILE = "..\..\lib\git_versions_example.dart"
Copy-Item $env:EXAMPLE_VERSIONS_FILE -Destination $env:VERSIONS_FILE
$env:COMMIT = $(git log -1 --pretty=format:"%H")
$env:OS = "WINDOWS"
(Get-Content $env:VERSIONS_FILE).replace('WINDOWS_VERSION = ""', "WINDOWS_VERSION = ""${env:COMMIT}""") | Set-Content $env:VERSIONS_FILE
cd build
cmake mobileliblelantus
msbuild mobileliblelantus.sln
