#!/bin/sh

set -e

. ./config.sh
OPENSSL_FILENAME=openssl-1.1.1q.tar.gz
OPENSSL_FILE_PATH=$WORKDIR/$OPENSSL_FILENAME
OPENSSL_SRC_DIR=$WORKDIR/openssl-1.1.1q
OPENSSL_SHA256="d7939ce614029cdff0b6c20f0e2e5703158a489a72b2507b8bd51bf8c8fd10ca"
ZLIB_DIR=$WORKDIR/zlib
ZLIB_TAG=v1.2.11
ZLIB_COMMIT_HASH="cacf7f1d4e3d44d871b605da3b647f07d718623f"

rm -rf $ZLIB_DIR
git clone -b $ZLIB_TAG --depth 1 https://github.com/madler/zlib $ZLIB_DIR
cd $ZLIB_DIR
git reset --hard $ZLIB_COMMIT_HASH
CC=clang CXX=clang++ ./configure --static
make

if [ ! -e "$OPENSSL_FILE_PATH" ]; then
  curl -L https://www.openssl.org/source/$OPENSSL_FILENAME -o $OPENSSL_FILE_PATH
fi

echo $OPENSSL_SHA256 $OPENSSL_FILE_PATH | sha256sum -c - || exit 1

for arch in "aarch" "aarch64" "i686" "x86_64"
do
PREFIX=$WORKDIR/prefix_${arch}

case $arch in
	"aarch")   CLANG=armv7a-linux-androideabi${API}-clang
		   CXXLANG=armv7a-linux-androideabi${API}-clang++
		   X_ARCH="android-arm";;
	"aarch64") CLANG=${arch}-linux-android${API}-clang
		   CXXLANG=${arch}-linux-android${API}-clang++
		   X_ARCH="android-arm64";;
	"i686")    CLANG=${arch}-linux-android${API}-clang
		   CXXLANG=${arch}-linux-android${API}-clang++
		   X_ARCH="android-x86";;
	"x86_64")  CLANG=${arch}-linux-android${API}-clang
		   CXXLANG=${arch}-linux-android${API}-clang++
		   X_ARCH="android-x86_64";;
	*)	   CLANG=${arch}-linux-android${API}-clang
		   CXXLANG=${arch}-linux-android${API}-clang++
		   X_ARCH="android-${arch}";;
esac

cd $WORKDIR
rm -rf $OPENSSL_SRC_DIR
tar -xzf $OPENSSL_FILE_PATH -C $WORKDIR
cd $OPENSSL_SRC_DIR
./Configure CC=${CLANG} CXX=${CXXLANG} ${X_ARCH} \
	no-asm no-shared no-tests --static \
	--with-zlib-include=${PREFIX}/include \
	--with-zlib-lib=${PREFIX}/lib \
	--prefix=${PREFIX} \
	--openssldir=${PREFIX} \
	-D__ANDROID_API__=$API
sed -i 's/CNF_EX_LIBS=-ldl -pthread//g;s/BIN_CFLAGS=-pie $(CNF_CFLAGS) $(CFLAGS)//g' Makefile
make -j16
make install_sw

done
