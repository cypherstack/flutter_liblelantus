#!/bin/bash

. ./config.sh

cp CMakeLists/missingheader/endian.h ${OPENSSL_IMPORT_DIR}/include/endian.h
cp CMakeLists/missingheader/endian.h $WORKDIR/mobileliblelantus/bitcoin/crypto/endian.h

echo "Installed missing headers"

mkdir -p $WORKDIR/mobileliblelantus
mkdir -p $WORKDIR/mobileliblelantus/bitcoin
mkdir -p $WORKDIR/mobileliblelantus/include
mkdir -p $WORKDIR/mobileliblelantus/secp256k1
mkdir -p $WORKDIR/mobileliblelantus/src
mkdir -p $WORKDIR/mobileliblelantus/tests
cp -r ../../mobileliblelantus ./build

echo "Copied mobileliblelantus"

SEDWORKDIR=$(echo $WORKDIR | sed 's/\//\\\//g')

sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" $PWD/CMakeLists/mobileliblelantus/template_CMakeLists.txt > $PWD/CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" $PWD/CMakeLists/secp256k1/template_CMakeLists.txt > $PWD/CMakeLists/secp256k1/CMakeLists.txt

echo "Linked distribution_DIR to $WORKDIR in CMakeLists"

cp $PWD/CMakeLists/mobileliblelantus/dart_interface.cpp $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/Utils.cpp          $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/Utils.h            $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/CMakeLists.txt     $PWD/build/mobileliblelantus/
cp $PWD/CMakeLists/secp256k1/CMakeLists.txt             $PWD/build/mobileliblelantus/secp256k1/

echo "Copied CMakeLists and includes to mobileliblelantus/"
