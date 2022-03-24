#!/bin/bash


. ./config.sh

cd $MOBILE_LIB_ROOT
cmake . -DCMAKE_TOOLCHAIN_FILE="${IOS_TOOLCHAIN_ROOT}/toolchain/iOS.cmake" && make -j4

sed -i '' "s/<dict>/<dict>\n\t<key>MinimumOSVersion<\/key>\n\t<string>11.0<\/string>/g" ./mobileliblelantus.framework/Info.plist