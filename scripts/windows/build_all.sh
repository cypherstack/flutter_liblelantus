#!/bin/bash

: '
# Clone flutter_liblelantus
mkdir -p ~/src
cd ~/src
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git submodule update --init --recursive
#git checkout build/mxe
#git reset af6c304fd02b145d1d5e21e6341f9a71f756c09f --hard

cd scripts/windows'
cp ./CMakeLists/missingheader/windows.h              ./build/include/windows.h
./build_openssl.sh

cd ~/src/flutter_liblelantus/scripts/windows
./prep_sharedfile.sh
cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake ./mobileliblelantus -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
