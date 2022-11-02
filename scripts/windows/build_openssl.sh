#!/bin/sh

set -e

. ./config.sh
OPENSSL_FILENAME=openssl-1.1.1k.tar.gz
OPENSSL_FILE_PATH=$WORKDIR/$OPENSSL_FILENAME
OPENSSL_SRC_DIR=$WORKDIR/openssl-1.1.1k
OPENSSL_SHA256="892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
ZLIB_DIR=$WORKDIR/zlib
ZLIB_TAG=v1.2.11
ZLIB_COMMIT_HASH="cacf7f1d4e3d44d871b605da3b647f07d718623f"

if [ ! -d "$ZLIB_DIR" ] ; then
  git clone -b $ZLIB_TAG --depth 1 https://github.com/madler/zlib $ZLIB_DIR
fi
cd $ZLIB_DIR
git reset --hard $ZLIB_COMMIT_HASH
./configure --static
make

curl https://www.openssl.org/source/$OPENSSL_FILENAME -o $OPENSSL_FILE_PATH
echo $OPENSSL_SHA256 $OPENSSL_FILE_PATH | sha256sum -c - || exit 1

cd $WORKDIR
rm -rf $OPENSSL_SRC_DIR
tar -xzf $OPENSSL_FILE_PATH -C $WORKDIR

#cp ../CMakeLists/missingheader/*.h ${OPENSSL_SRC_DIR}/include/
#mkdir ${OPENSSL_SRC_DIR}/include/sdks
#mkdir ${OPENSSL_SRC_DIR}/include/sec_api
#cp ../CMakeLists/missingheader/sdks/*.h ${OPENSSL_SRC_DIR}/include/sdks/*.h
#cp ../CMakeLists/missingheader/sec_api/*.h ${OPENSSL_SRC_DIR}/include/sec_api/*.h

cd $OPENSSL_SRC_DIR

CROSS_COMPILE="x86_64-w64-mingw32.static-"
#sed -i -e "s/mandroid/target\ ${TARGET}\-linux\-android/" Configure
./Configure --cross-compile-prefix=x86_64-w64-mingw32- mingw64 no-shared --with-zlib-include=${WORKDIR}/include --with-zlib-lib=${WORKDIR}/lib --prefix=${WORKDIR}/openssl --openssldir=${WORKDIR}/openssl OPENSSL_LIBS="-lcrypt32 -lws2_32 -lwsock32"
make -j$THREADS
make -j$THREADS install_sw
