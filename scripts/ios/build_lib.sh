#!/bin/bash


. ./config.sh

echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
VERSIONS_FILE=../../lib/git_versions.dart
EXAMPLE_VERSIONS_FILE=../../lib/git_versions_example.dart
if [ ! -f "$VERSIONS_FILE" ]; then
    cp $EXAMPLE_VERSIONS_FILE $VERSIONS_FILE
fi
COMMIT=$(git log -1 --pretty=format:"%H")
OS="IOS"
sed -i '' "/\/\*${OS}_VERSION/c\\/\*${OS}_VERSION\*\/ const ${OS}_VERSION = \"$COMMIT\";" $VERSIONS_FILE
cd $MOBILE_LIB_ROOT

LIBRARY_PATH="" LD_LIBRARY_PATH="" cmake . \
  -DCMAKE_TOOLCHAIN_FILE="${IOS_TOOLCHAIN_ROOT}/toolchain/iOS.cmake" \
  -DCMAKE_OSX_ARCHITECTURES="arm64" \
  && LIBRARY_PATH="" LD_LIBRARY_PATH="" make -j4

plutil -replace CFBundleShortVersionString -string "0.0.3" ./mobileliblelantus.framework/Info.plist
plutil -replace CFBundleVersion -string "1" ./mobileliblelantus.framework/Info.plist

sed -i '' "s/<dict>/<dict>\n\t<key>MinimumOSVersion<\/key>\n\t<string>12.0<\/string>/g" ./mobileliblelantus.framework/Info.plist