#!/bin/bash

. ./config.sh

mkdir build
mkdir build/include
mkdir build/secp256k1
mkdir build/secp256k1/include
cp -r ../../mobileliblelantus/* ./build

sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/mobileliblelantus/template_CMakeLists.txt > ./CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/secp256k1/template_CMakeLists.txt > ./CMakeLists/secp256k1/CMakeLists.txt

cp ./CMakeLists/mobileliblelantus/dart_interface.cpp ./build/src/dart_interface.cpp
cp ./CMakeLists/mobileliblelantus/Utils.cpp          ./build/src/Utils.cpp
cp ./CMakeLists/mobileliblelantus/Utils.h            ./build/src/Utils.h
cp ./CMakeLists/mobileliblelantus/CMakeLists.txt     ./build/CMakeLists.txt
cp ./CMakeLists/secp256k1/CMakeLists.txt             ./build/secp256k1/CMakeLists.txt
cp ./CMakeLists/missingheader/endian.h               ./build/include/endian.h
cp ./CMakeLists/missingheader/endian.h            	 ./build/secp256k1/include/endian.h
cp ./CMakeLists/missingheader/features.h             ./build/include/features.h
