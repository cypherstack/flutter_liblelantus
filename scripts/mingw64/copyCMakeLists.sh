#!/bin/bash

cp $PWD/CMakeLists/mobileliblelantus/dart_interface.cpp $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/Utils.cpp          $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/Utils.h            $PWD/build/mobileliblelantus/src/
cp $PWD/CMakeLists/mobileliblelantus/CMakeLists.txt     $PWD/build/mobileliblelantus/
cp $PWD/CMakeLists/secp256k1/CMakeLists.txt             $PWD/build/mobileliblelantus/secp256k1/

echo "Copied CMakeLists and includes to mobileliblelantus/"
