#!/bin/sh

. ./config.sh
#./install_missing_headers.sh
./build_openssl_common.sh
#./ioscmake.sh
./copymobile.sh
./linkDistros.sh
./copyCMakeLists.sh
./gen_version.sh
./build_lib.sh
