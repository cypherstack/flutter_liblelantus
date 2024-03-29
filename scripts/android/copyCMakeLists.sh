#!/bin/bash

echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
VERSIONS_FILE=../../lib/git_versions.dart
EXAMPLE_VERSIONS_FILE=../../lib/git_versions_example.dart
if [ ! -f "$VERSIONS_FILE" ]; then
    cp $EXAMPLE_VERSIONS_FILE $VERSIONS_FILE
fi
COMMIT=$(git log -1 --pretty=format:"%H")
OS="ANDROID"
sed -i "/\/\*${OS}_VERSION/c\\/\*${OS}_VERSION\*\/ const ${OS}_VERSION = \"$COMMIT\";" $VERSIONS_FILE
cp CMakeLists/mobileliblelantus/dart_interface.cpp mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.cpp          mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/Utils.h            mobileliblelantus/src/
cp CMakeLists/mobileliblelantus/CMakeLists.txt     mobileliblelantus/
cp CMakeLists/secp256k1/CMakeLists.txt             mobileliblelantus/secp256k1/