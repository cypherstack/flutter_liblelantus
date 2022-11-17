#!/bin/bash

cp ./CMakeLists/missingheader/windows.h              ./build/include/windows.h
./build_openssl.sh

cd ~/src/flutter_liblelantus/scripts/windows
./prep_sharedfile.sh
cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake ./mobileliblelantus -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
