#!/bin/sh

export API=21
export WORKDIR="$(pwd)/"build
export ANDROID_NDK_ZIP=${WORKDIR}/android-ndk-r17c.zip
export ANDROID_NDK_ROOT=${WORKDIR}/android-ndk-r17c
export ANDROID_NDK_HOME=$ANDROID_NDK_ROOT
export TOOLCHAIN_DIR="${WORKDIR}/toolchain"
export TOOLCHAIN_BASE_DIR=$TOOLCHAIN_DIR
export ORIGINAL_PATH=$PATH
export THREADS=8
export TYPES_OF_BUILD="x86_64"

if [ -z "$IS_ARM" ]; then
  export TYPES_OF_BUILD="x86_64"
else
  export TYPES_OF_BUILD="aarch64"
fi

export PREFIX=$WORKDIR/prefix_mingw64

export OPENSSL_FILENAME=openssl-1.1.1k.tar.gz
export OPENSSL_FILE_PATH="$(pwd)/"/cache/$OPENSSL_FILENAME
export OPENSSL_SRC_DIR=$WORKDIR/openssl-1.1.1k
export OPENSSL_SHA256="892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
export ZLIB_DIR=$WORKDIR/zlib
export ZLIB_TAG=v1.2.11
export ZLIB_COMMIT_HASH="cacf7f1d4e3d44d871b605da3b647f07d718623f"

export SEDWORKDIR=$(echo $WORKDIR | sed 's/\//\\\//g')
export SEDWORKDIR=${SEDWORKDIR//'\/c'/"C:"/}

export VERSIONS_FILE=../../lib/git_versions.dart
export EXAMPLE_VERSIONS_FILE=../../lib/git_versions_example.dart
export OS="MINGW64"
