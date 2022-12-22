#!/bin/bash

./build_openssl.sh
./prep_sharedfile.sh

cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake ./mobileliblelantus -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
