#!/bin/bash

OS=android
TAG_COMMIT=$(git log -1 --pretty=format:"%H")

rm -rf flutter_liblelantus_bins
git clone https://git.cypherstack.com/stackwallet/flutter_liblelantus_bins
if [ -d flutter_liblelantus_bins ]; then
  cd flutter_liblelantus_bins
else
  echo "Failed to clone flutter_liblelantus_bins"
  exit 1
fi

TARGET_PATH=../../android/src/main/jniLibs
BIN=libmobileliblelantus.so

for TARGET in arm64-v8a armeabi-v7a x86_64
do
  ARCH_PATH=$TARGET

  git checkout $OS/$TARGET || git checkout -b $OS/$TARGET
  if [ ! -d $OS/$ARCH_PATH ]; then
    mkdir -p $OS/$ARCH_PATH
  fi
  cp -rf $TARGET_PATH/$ARCH_PATH/$BIN $OS/$ARCH_PATH/$BIN
  git add .
  git commit -m "$TAG_COMMIT"
  git push origin $OS/$TARGET
  git tag "${OS}_${TARGET}_${TAG_COMMIT}"
  git push --tags
done
