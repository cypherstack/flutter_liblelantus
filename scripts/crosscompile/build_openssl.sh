#!/bin/bash

set -e

. ./config.sh

if [ ! -d "$ZLIB_DIR" ] ; then
  git clone -b $ZLIB_TAG --depth 1 https://github.com/madler/zlib $ZLIB_DIR
fi
cd $ZLIB_DIR

git reset --hard $ZLIB_COMMIT_HASH
./configure --static --64 --prefix=$WORKDIR
make
make install

if [ ! -f "$OPENSSL_FILE_PATH" ] ; then
	curl https://www.openssl.org/source/$OPENSSL_FILENAME -o $OPENSSL_FILE_PATH
fi
if [ "$OPENSSL_SHA256" = "$(sha256sum $OPENSSL_FILE_PATH)" ] ; then
	rm $OPENSSL_FILE_PATH
	exit 1
fi

cd $WORKDIR
rm -rf $OPENSSL_SRC_DIR
tar -xzf $OPENSSL_FILE_PATH -C $WORKDIR
cd $OPENSSL_SRC_DIR

./Configure --cross-compile-prefix=x86_64-w64-mingw32- mingw64 no-shared --with-zlib-include=${WORKDIR}/include --with-zlib-lib=${WORKDIR}/lib --prefix=${WORKDIR} --openssldir=${WORKDIR} # no-asm?
make -j$THREADS
make install
