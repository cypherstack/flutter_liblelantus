#!/bin/bash

mkdir build
. ./config.sh
ANDROID_NDK_SHA256="4d760db479de1b6e54f5da2fe894a35f120ad4d6ccf4b989254940183ca00c08"

curl https://dl.google.com/android/repository/android-ndk-r20b-darwin-x86_64.zip -o ${ANDROID_NDK_ZIP}
echo $ANDROID_NDK_SHA256 $ANDROID_NDK_ZIP | sha256sum -c || exit 1
unzip $ANDROID_NDK_ZIP -d $WORKDIR
