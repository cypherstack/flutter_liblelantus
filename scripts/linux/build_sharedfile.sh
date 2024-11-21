#!/bin/bash

set -e -x

. ./config.sh

echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
VERSIONS_FILE=../../lib/git_versions.dart
EXAMPLE_VERSIONS_FILE=../../lib/git_versions_example.dart
if [ ! -f "$VERSIONS_FILE" ]; then
    cp $EXAMPLE_VERSIONS_FILE $VERSIONS_FILE
fi
COMMIT=$(git log -1 --pretty=format:"%H")
OS="LINUX"
sed -i "/\/\*${OS}_VERSION/c\\/\*${OS}_VERSION\*\/ const ${OS}_VERSION = \"$COMMIT\";" $VERSIONS_FILE

cd build || exit
# set arch using ANDROID_ABI var
cmake -DANDROID_ABI="${TYPES_OF_BUILD}" ../mobileliblelantus
# shellcheck disable=SC2046
make -j$(nproc)