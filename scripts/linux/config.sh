#!/bin/sh

export API=21
export WORKDIR="$(pwd)/"build
export ANDROID_NDK_ZIP="${WORKDIR}"/android-ndk-r17c.zip
export ANDROID_NDK_ROOT="${WORKDIR}"/android-ndk-r17c
export ANDROID_NDK_HOME="$ANDROID_NDK_ROOT"
export TOOLCHAIN_DIR="${WORKDIR}/toolchain"
export TOOLCHAIN_BASE_DIR="$TOOLCHAIN_DIR"
export ORIGINAL_PATH="$PATH"
export THREADS=16
export TYPES_OF_BUILD="x86_64"

if [ -z "$IS_ARM" ]; then
  export TYPES_OF_BUILD="x86_64"
else
  export TYPES_OF_BUILD="aarch64"
fi