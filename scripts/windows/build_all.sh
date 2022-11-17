#!/bin/bash

# Clone flutter_liblelantus
mkdir -p ~/src
cd ~/src
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git submodule update --init --recursive
git checkout build/mxe
git reset 89220d289e016c89a9e8c6be232a98f65f582e37 --hard

cd scripts/windows
cp ./CMakeLists/missingheader/windows.h              ./build/include/windows.h
./build_openssl.sh

cd ~/src/flutter_liblelantus/scripts/windows
./prep_sharedfile.sh
cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake ./mobileliblelantus -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
