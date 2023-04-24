#!/bin/bash

. ./config.sh

OS=linux

TAG_COMMIT=$(git log -1 --pretty=format:"%H")

rm -rf flutter_liblelantus_bins
git clone https://git.cypherstack.com/stackwallet/flutter_liblelantus_bins
if [ -d flutter_liblelantus_bins ]; then
  cd flutter_liblelantus_bins
else
  echo "Failed to clone flutter_liblelantus_bins"
  exit 1
fi

BIN=libmobileliblelantus.so

TARGET=$TYPES_OF_BUILD

ARCH_PATH=$TARGET

if [ $(git tag -l "${OS}_${TARGET}_${TAG_COMMIT}") ]; then
    git checkout "${OS}_${TARGET}_${TAG_COMMIT}"
    if [ -f "$OS/$ARCH_PATH/$BIN" ]; then
      mkdir -p ../build
      # TODO verify bin checksum hashes
      cp -rf "$OS/$ARCH_PATH/$BIN" ../build/
    else
      echo "$TARGET not found!"
    fi
else
    echo "No precompiled bins for $TARGET found!"
fi

