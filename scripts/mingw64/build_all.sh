#!/bin/bash

./mingw64deps.sh

mkdir build
./install_missing_headers.sh
./build_openssl.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
./build_sharedfile.sh
