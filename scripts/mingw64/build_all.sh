#!/bin/bash

mkdir build
./build_openssl.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
./build_sharedfile.sh
