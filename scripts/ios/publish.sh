#!/usr/bin/env bash

OS=ios
TAG_COMMIT=$(git log -1 --pretty=format:"%H")

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

pwd

ls $SOURCE_PATH

if [ $(git tag -l "${OS}_${TARGET}_${TAG_COMMIT}") ]; then
    echo "Tag ${OS}_${TARGET}_${TAG_COMMIT} already exists!"
  else
    if [ -f "$SOURCE_PATH/$FRAMEWORK" ]; then
      git checkout $OS/$TARGET || git checkout -b $OS/$TARGET
      if [ ! -d $OS/$TARGET ]; then
        mkdir -p $OS/$TARGET
      fi
      cp -rf $SOURCE_PATH/$FRAMEWORK $OS/$TARGET/$FRAMEWORK
      git add .
      git commit -m "$TARGET commit for $TAG_COMMIT"
      git push origin $OS/$TARGET
      git tag "${OS}_${TARGET}_${TAG_COMMIT}"
      git push --tags
    else
      echo "$TARGET not found!"
    fi
  fi