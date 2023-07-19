#!/bin/bash

WORKDIR="$(pwd)"
SEDWORKDIR=$(echo $WORKDIR | sed 's/\//\\\//g')

sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/mobileliblelantus/template_CMakeLists.txt > ./CMakeLists/mobileliblelantus/CMakeLists.txt
sed "s/SET(distribution_DIR \/opt\/android)/SET(distribution_DIR $SEDWORKDIR)/g" ./CMakeLists/secp256k1/template_CMakeLists.txt > ./CMakeLists/secp256k1/CMakeLists.txt