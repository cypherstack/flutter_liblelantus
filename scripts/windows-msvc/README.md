# flutter_liblelantus
## Prerequisites
Windows:
 - [NSM](https://www.nasm.us/) for `nmake` in PATH

## Build
Clone [cypherstack/flutter_liblelantus](https://github.com/cypherstack/flutter_liblelantus) and init the mobilelelantus submodule:
```shell
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git submodule update --recursive --init
```

Open a Visual Studio x64 Native Tools Command Prompt, navigate to `scripts/windows/MSVC`, and run `build_all.ps1`
```shell
cd scripts/windows/MSVC
./build_all.sh
```
