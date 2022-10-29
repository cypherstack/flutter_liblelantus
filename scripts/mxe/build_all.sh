#!/bin/bash

mkdir ~/development
cd ~/development
# TODO check if MXE is built; if it is, don't.
git clone https://github.com/mxe/mxe.git
cd mxe
make cc cmake MXE_TARGETS='x86_64-w64-mingw32.static'
if ! [[ $PATH == *"/mxe"* ]]; then
	echo 'export PATH="$HOME/development/mxe/usr/bin:$PATH"' >> ~/.bashrc 
	source ~/.bashrc
fi
make cmake openssl MXE_TARGETS='x86_64-w64-mingw32.static'
mkdir ~/src
cd ~/src
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git checkout build/mxe
#git reset af6c304fd02b145d1d5e21e6341f9a71f756c09f --hard
cd scripts/mxe
./prep_sharedfile.sh
cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
