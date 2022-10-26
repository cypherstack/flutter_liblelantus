#!/bin/bash

./mingw64deps.sh

mkdir build
mkdir cache
./build_openssl.sh
./install_missing_headers.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
./build_sharedfile.sh
