#!/bin/bash

. ./config.sh

cp -r ../../mobileliblelantus ./build

sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/mobileliblelantus/template_CMakeLists.txt > ./CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/secp256k1/template_CMakeLists.txt > ./CMakeLists/secp256k1/CMakeLists.txt

cp CMakeLists/mobileliblelantus/dart_interface.cpp build/mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.cpp          build/mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.h            build/mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/CMakeLists.txt     build/mobileliblelantus/
cp CMakeLists/secp256k1/CMakeLists.txt             build/mobileliblelantus/secp256k1/
cp CMakeLists/missingheader/endian.h ${WORKDIR}/include/endian.h
