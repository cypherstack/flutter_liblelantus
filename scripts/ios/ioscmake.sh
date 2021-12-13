#!/bin/bash


. ./config.sh


TOOLCHAIN_URL="https://github.com/cristeab/ios-cmake.git"
TOOLCHAIN_DIR_PATH="${IOS_TOOLCHAIN_ROOT}"

git clone $TOOLCHAIN_URL $TOOLCHAIN_DIR_PATH