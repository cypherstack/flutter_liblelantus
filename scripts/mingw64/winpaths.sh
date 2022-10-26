#!/bin/sh

export WORKDIR="$(pwd)/"build
export WORKDIR=${WORKDIR//"/c/"/"C:/"/}
export ANDROID_NDK_ZIP=${WORKDIR}/android-ndk-r17c.zip
export ANDROID_NDK_ROOT=${WORKDIR}/android-ndk-r17c
export ANDROID_NDK_HOME=$ANDROID_NDK_ROOT
export TOOLCHAIN_DIR="${WORKDIR}/toolchain"
export TOOLCHAIN_BASE_DIR=$TOOLCHAIN_DIR
export ORIGINAL_PATH=$PATH
export ORIGINAL_PATH=${ORIGINAL_PATH//"/c/"/"C:/"/}

export PREFIX=$WORKDIR/prefix_mingw64

export OPENSSL_SRC_DIR=$WORKDIR/openssl-1.1.1k
export ZLIB_DIR=$WORKDIR/zlib

export SEDWORKDIR=$(echo $WORKDIR | sed 's/\//\\\//g')
export SEDWORKDIR=${SEDWORKDIR//"\/c\"/"C:"/}

echo "Configured variables for build"
