#!/bin/bash

printf $(git log -1 --pretty=format:"%h %ad") >> build/git_commit_version.txt
cp CMakeLists/mobileliblelantus/dart_interface.cpp mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.cpp          mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.h            mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/CMakeLists.txt     mobileliblelantus/
cp CMakeLists/secp256k1/CMakeLists.txt             mobileliblelantus/secp256k1/