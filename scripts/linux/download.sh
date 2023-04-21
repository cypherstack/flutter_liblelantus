#!/bin/bash

LIB_ROOT=../..
OS=linux
LINUX_LIBS_DIR=$LIB_ROOT/$OS/bin

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

for TARGET in aarch64-unknown-linux-gnu x86_64-unknown-linux-gnu
do
  ARCH_PATH=$TARGET/release
  if [ $(git tag -l $TARGET"_$TAG_COMMIT") ]; then
      git checkout $TARGET"_$TAG_COMMIT"
      if [ -f "$OS/$ARCH_PATH/$BIN" ]; then
        mkdir -p ../$LINUX_LIBS_DIR/$ARCH_PATH
        # TODO verify bin checksum hashes
        cp -rf "$OS/$ARCH_PATH/$BIN" "../$LINUX_LIBS_DIR/$ARCH_PATH/$BIN"
      else
        echo "$TARGET not found!"
      fi
  else
      echo "No precompiled bins for $TARGET found!"
  fi
done
