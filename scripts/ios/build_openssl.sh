#!/bin/sh

. ./config.sh

OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="${EXTERNAL_IOS_SOURCE_DIR}/OpenSSL"

echo "============================ OpenSSL ============================"

echo "Cloning Open SSL from - $OPEN_SSL_URL"
git clone "$OPEN_SSL_URL" "$OPEN_SSL_DIR_PATH"
cd "$OPEN_SSL_DIR_PATH" || exit 1
git checkout b77ace70b2594de69c88d0748326d2a1190bbac1
#sed -i '' "s/IOS_MIN_SDK_VERSION=\"12.0\"/IOS_MIN_SDK_VERSION=\"10.0\"/g" build-libssl.sh

CURL_OPTIONS="-L" ./build-libssl.sh --version=1.1.1k --archs="x86_64 arm64" --targets="ios64-cross-arm64" --deprecated

mv "${OPEN_SSL_DIR_PATH}"/include/* "$EXTERNAL_IOS_INCLUDE_DIR"
mv "${OPEN_SSL_DIR_PATH}"/lib/* "$EXTERNAL_IOS_LIB_DIR"