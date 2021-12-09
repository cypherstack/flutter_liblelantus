#!/bin/bash

mkdir build
./install_ndk.sh
./linkDistros.sh
./copyCMakeLists.sh
./build_openssl.sh
./renamedistros.sh
