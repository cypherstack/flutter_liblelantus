# flutter_liblelantus
## Prerequisites
Windows:
 - [MSYS2](https://www.msys2.org/)
Ubuntu:
 - [mingw-w64](https://packages.ubuntu.com/source/bionic/mingw-w64) (`sudo apt-get -y install mingw-w64`)

## Build
Clone [cypherstack/flutter_liblelantus](https://github.com/cypherstack/flutter_liblelantus) and init the mobilelelantus submodule:
```shell
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git submodule update --recursive --init
```

Open an MSYS2 MinGW 64-bit shell (MSYS2 MINGW64), navigate to `scripts/windows`, and run `build_all.sh`
```shell
cd scripts/windows
./build_all.sh
```
