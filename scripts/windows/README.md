### flutter_liblelantus
Install [LLVM for Windows](https://llvm.org/builds/) and add it to PATH
Use install script in https://github.com/zufuliu/llvm-utils to add LLVM_141

Clone [cypherstack/flutter_liblelantus](https://github.com/cypherstack/flutter_liblelantus) and init the mobilelelantus submodule:
```shell
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git submodule update --recursive --init
```

There are three approaches to building for Windows: just using Visual Studio and clang, just using MSYS2/MinGW64 (recommended) and using Visual Studio/msbuild and MSYS2/MinGW64 together:

#### Visual Studio and clang
Use a Visual Studio x64 Native Tools Command Prompt to run `scripts/windows/build_all.ps1`

<!-- https://iocafe-doc.readthedocs.io/en/latest/dev-tools/windows/200111-building-with-opensll-on-windows.html -->

#### MSYS2/MinGW64
This approach builds everything in MSYS2/MinGW64.  Open a MinGW 64-bit shell (MINGW64), navigate to `/scripts/windows/build` (use `cd /c/` to navigate to C:\), and run `scripts/mingw64/build_all.sh`

#### Visual Studio and MSYS2/MinGW64
This approach builds most files in Visual Studio and finishes the process in MSYS2/MinGW64.  Run `/scripts/windows/build_all.ps1` in a Visual Studio x64 Native Tools Command Prompt.  Open a MinGW 64-bit shell (MINGW64), navigate to `/scripts/windows/build`, configure, and build the library:
```bash
cd ..
cmake ./mobileliblelantus -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -lws2_32
cmake --build .
```