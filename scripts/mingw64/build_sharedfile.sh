#!/bin/bash

. ./config.sh

./linkDistros.sh
./copyCMakeLists.sh

echo ''$(git log -1 --pretty=format:"%H")' '$(date) >> build/git_commit_version.txt
if [ ! -f "$VERSIONS_FILE" ]; then
    cp $EXAMPLE_VERSIONS_FILE $VERSIONS_FILE
fi
COMMIT=$(git log -1 --pretty=format:"%H")
sed -i "/\/\*${OS}_VERSION/c\\/\*${OS}_VERSION\*\/ const ${OS}_VERSION = \"$COMMIT\";" $VERSIONS_FILE
#./winpaths.sh
cd build
# May have to rm CMakeCache.txt
cmake ./mobileliblelantus -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo # mingw-w64-x86_64-cmake?
mingw32-make -j$(nproc) # or use `cmd //c mklink make mingw32-make.exe` in MSYS2 to use just use make
