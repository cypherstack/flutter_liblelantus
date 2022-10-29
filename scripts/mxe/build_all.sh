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
cd ~
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git reset baf1f7c4028f4697c2c3dfed6357a1367cd3999b --hard
cd scripts/mxe
./prep_sharedfile.sh
cd build
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
