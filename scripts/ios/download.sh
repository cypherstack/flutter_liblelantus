#!/usr/bin/env bash

OS=ios

rm -rf flutter_liblelantus_bins
git clone https://git.cypherstack.com/stackwallet/flutter_liblelantus_bins
if [ -d flutter_liblelantus_bins ]; then
  cd flutter_liblelantus_bins
else
  echo "Failed to clone flutter_liblelantus_bins"
  exit 1
fi

TARGET=arm64
SOURCE_PATH="../mobileliblelantus"
FRAMEWORK="mobileliblelantus.framework"

if [ $(git tag -l "${OS}_${TARGET}_${TAG_COMMIT}") ]; then
    git checkout "${OS}_${TARGET}_${TAG_COMMIT}"
    if [ -f "$OS/$TARGET/$FRAMEWORK" ]; then
      mkdir -p $SOURCE_PATH
      # TODO verify bin checksum hashes
      cp -rf "$OS/$TARGET/$FRAMEWORK" "$SOURCE_PATH/$FRAMEWORK"
    else
      echo "$TARGET not found!"
    fi
else
    echo "No precompiled bins for $TARGET found!"
fi