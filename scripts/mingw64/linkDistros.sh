#!/bin/bash

. ./config.sh
echo $SEDWORKDIR
sed "s/SET(distribution_DIR c:\/src\/flutter_liblelantus\/scripts\/mingw64\/build)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/mobileliblelantus/template_CMakeLists.txt > ./CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR c:\/src\/flutter_liblelantus\/scripts\/mingw64\/build)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/secp256k1/template_CMakeLists.txt > ./CMakeLists/secp256k1/CMakeLists.txt
cp ./CMakeLists/mobileliblelantus/template_CMakeLists.txt ./CMakeLists/mobileliblelantus/CMakeLists.txt
cp ./CMakeLists/secp256k1/template_CMakeLists.txt ./CMakeLists/secp256k1/CMakeLists.txt

echo "Linked distribution_DIR to $WORKDIR in CMakeLists"
