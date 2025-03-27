#!/bin/bash

mkdir -p build
. ./config.sh
ANDROID_NDK_SHA256="a186b67e8810cb949514925e4f7a2255548fb55f5e9b0824a6430d012c1b695b"

if [ ! -e "$ANDROID_NDK_ZIP" ]; then
  curl https://dl.google.com/android/repository/android-ndk-r28-linux.zip -o ${ANDROID_NDK_ZIP}
fi
echo $ANDROID_NDK_SHA256 $ANDROID_NDK_ZIP | sha256sum -c || exit 1
unzip $ANDROID_NDK_ZIP -d $WORKDIR
