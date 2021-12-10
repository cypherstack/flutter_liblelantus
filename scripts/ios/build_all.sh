#!/bin/sh

. ./config.sh
./install_missing_headers.sh
./build_openssl.sh
./ioscmake.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
./build_lib.sh
