#!/bin/bash

. ./config.sh

cp CMakeLists/missingheader/endian.h ${PREFIX}/include/endian.h
cp CMakeLists/missingheader/endian.h $$WORKDIR/mobileliblelantus/bitcoin/crypto/endian.h

echo "Installed missing headers"

mkdir $WORKDIR/mobileliblelantus
mkdir $WORKDIR/mobileliblelantus/bitcoin
mkdir $WORKDIR/mobileliblelantus/include
mkdir $WORKDIR/mobileliblelantus/secp256k1
mkdir $WORKDIR/mobileliblelantus/src
mkdir $WORKDIR/mobileliblelantus/tests
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
