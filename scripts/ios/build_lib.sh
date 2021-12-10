#!/bin/bash


. ./config.sh

cd $MOBILE_LIB_ROOT
cmake . -DCMAKE_TOOLCHAIN_FILE="${IOS_TOOLCHAIN_ROOT}/toolchain/iOS.cmake" && make