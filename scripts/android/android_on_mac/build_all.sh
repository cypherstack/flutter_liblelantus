#!/bin/bash

mkdir build
./install_ndk.sh
./build_openssl.sh
./renamedistros.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
