#!/bin/bash

set -e

. ./config.sh

if [ ! -d "$ZLIB_DIR" ] ; then
  git clone -b $ZLIB_TAG --depth 1 https://github.com/madler/zlib $ZLIB_DIR
fi
cd $ZLIB_DIR

git reset --hard $ZLIB_COMMIT_HASH
cmake -G "MinGW Makefiles" -DBUILD_STATIC=$STATIC -DBUILD_TESTS=ON
cmake --build . --config Release

if [ ! -f "$OPENSSL_FILE_PATH" ] ; then
	curl https://www.openssl.org/source/$OPENSSL_FILENAME -o $OPENSSL_FILE_PATH
fi
if [ "$OPENSSL_SHA256" = "$(sha256sum $OPENSSL_FILE_PATH)" ] ; then
	rm $OPENSSL_FILE_PATH
	exit 1
fi

: 'for arch in $TYPES_OF_BUILD
do
	echo "Building $TYPES_OF_BUILD"
	PREFIX=$WORKDIR/prefix_${arch}

	case $arch in
		"x86_64")  X_ARCH="linux-x86_64";;
		"aarch64")  X_ARCH="linux-aarch64";;
		*)	   X_ARCH="linux-x86_64";;
	esac

	./Configure ${X_ARCH} no-asm no-shared --with-zlib-include=${PREFIX}/include --with-zlib-lib=${PREFIX}/lib --prefix=${PREFIX} --openssldir=${PREFIX}
	make
done'

perl Configure mingw64 no-shared no-asm --with-zlib-include=${PREFIX}/include --with-zlib-lib=${PREFIX}/lib --prefix=${PREFIX} --openssldir=${PREFIX}
make -j$THREADS
make -j$THREADS install_sw
