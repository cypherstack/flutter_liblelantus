#!/bin/bash


. ./config.sh


TOOLCHAIN_URL="https://github.com/cristeab/ios-cmake.git"
TOOLCHAIN_DIR_PATH="${IOS_TOOLCHAIN_ROOT}"

git clone $TOOLCHAIN_URL $TOOLCHAIN_DIR_PATH

# patch for newer cmake
sed -i '' 's@exec_program(uname ARGS -r OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_VERSION)@execute_process(COMMAND uname -r OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_VERSION)@' "${TOOLCHAIN_DIR_PATH}"/toolchain/iOS.cmake
sed -i '' 's@exec_program(/usr/bin/xcode-select ARGS -print-path OUTPUT_VARIABLE CMAKE_XCODE_DEVELOPER_DIR)@execute_process(COMMAND xcode-select --print-path OUTPUT_VARIABLE CMAKE_XCODE_DEVELOPER_DIR)\nstring(STRIP ${CMAKE_XCODE_DEVELOPER_DIR} CMAKE_XCODE_DEVELOPER_DIR)@' "${TOOLCHAIN_DIR_PATH}"/toolchain/iOS.cmake
