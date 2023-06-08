#!/bin/bash

. ./config.sh

mkdir -p build
mkdir -p build/include
mkdir -p build/secp256k1
mkdir -p build/secp256k1/include
mkdir -p build/mobileliblelantus
cp -r ../../mobileliblelantus/* ./build/mobileliblelantus

sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/mobileliblelantus/template_CMakeLists.txt > ./CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/secp256k1/template_CMakeLists.txt > ./CMakeLists/secp256k1/CMakeLists.txt

echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
VERSIONS_FILE=../../lib/git_versions.dart
EXAMPLE_VERSIONS_FILE=../../lib/git_versions_example.dart
if [ ! -f "$VERSIONS_FILE" ]; then
    cp $EXAMPLE_VERSIONS_FILE $VERSIONS_FILE
fi
COMMIT=$(git log -1 --pretty=format:"%H")
OS="WINDOWS"
sed -i "/\/\*${OS}_VERSION/c\\/\*${OS}_VERSION\*\/ const ${OS}_VERSION = \"$COMMIT\";" $VERSIONS_FILE

cp ./CMakeLists/mobileliblelantus/dart_interface.cpp ./build/mobileliblelantus/src/dart_interface.cpp
cp ./CMakeLists/mobileliblelantus/Utils.cpp          ./build/mobileliblelantus/src/Utils.cpp
cp ./CMakeLists/mobileliblelantus/Utils.h            ./build/mobileliblelantus/src/Utils.h
cp ./CMakeLists/mobileliblelantus/CMakeLists.txt     ./build/mobileliblelantus/CMakeLists.txt
cp ./CMakeLists/secp256k1/CMakeLists.txt             ./build/mobileliblelantus/secp256k1/CMakeLists.txt
cp ./CMakeLists/missingheader/endian.h            	 ./build/secp256k1/include/endian.h
cp ./CMakeLists/missingheader/endian.h            	 ./build/mobileliblelantus/secp256k1/include/endian.h
cp ./CMakeLists/missingheader/endian.h               ./build/openssl/include/endian.h
cp ./CMakeLists/missingheader/features.h             ./build/openssl/include/features.h
