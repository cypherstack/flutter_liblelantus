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

TARGET_PATH=../build
BIN=libmobileliblelantus.so
TARGET=$TYPES_OF_BUILD


if [ $(git tag -l "${OS}_${TARGET}_${TAG_COMMIT}") ]; then
  echo "Tag ${OS}_${TARGET}_${TAG_COMMIT} already exists!"
else
  ARCH_PATH=$TARGET

  if [ -f "$TARGET_PATH/$BIN" ]; then
    git checkout "$OS/$TARGET" || git checkout -b "$OS/$TARGET"
    if [ ! -d "$OS/$ARCH_PATH" ]; then
      mkdir -p "$OS/$ARCH_PATH"
    fi
    cp -rf "$TARGET_PATH/$BIN" "$OS/$ARCH_PATH/$BIN"
    git add .
    git commit -m "$OS $TARGET commit for $TAG_COMMIT"
    git push origin "$OS/$TARGET"
    git tag "${OS}_${TARGET}_${TAG_COMMIT}"
    git push --tags
  else
    echo "$TARGET not found!"
  fi
fi

