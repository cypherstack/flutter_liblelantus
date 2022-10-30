# !/bin/pwsh

./config.ps1

$env:COMMIT = $(git log -1 --pretty=format:"%H")
New-Item "build\git_commit_version.txt" -ItemType File -Value $env:COMMIT -Force
$env:VERSIONS_FILE = "..\..\lib\git_versions.dart"
$env:EXAMPLE_VERSIONS_FILE = "..\..\lib\git_versions_example.dart"
Copy-Item $env:EXAMPLE_VERSIONS_FILE -Destination $env:VERSIONS_FILE
$env:OS = "WINDOWS"
(Get-Content $env:VERSIONS_FILE).replace('WINDOWS_VERSION = ""', "WINDOWS_VERSION = ""${env:COMMIT}""") | Set-Content $env:VERSIONS_FILE
#cmake -G "Visual Studio 15 2017" -DCMAKE_TOOLCHAIN_FILE="../CMakeLists/clang-x86_64_windows_gnu.cmake" ./mobileliblelantus -A x64 -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_CL_64=1
#cmake . --build
cd build
<#
cmake -G "Visual Studio 15 2017" ./mobileliblelantus -DCMAKE_C_COMPILER:PATH="C:\Program Files\LLVM\bin\clang.exe" -DCMAKE_CXX_COMPILER:PATH="C:\Program Files\LLVM\bin\clang.exe" -DCMAKE_C_COMPILER_ID="Clang" -DCMAKE_CXX_COMPILER_ID="Clang" -DCMAKE_SYSTEM_NAME="Generic" -T ClangCL,host=x64
msbuild mobileliblelantus.sln /property:Configuration=Release /property:Platform=x64
# Continue build process in MSYS2/MinGW with the following two commands:
cmake ./mobileliblelantus -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -lcrypto32
mingw32-make # -j$(nproc) or use `cmd //c mklink make mingw32-make.exe` in MSYS2 to use just use make
#>
