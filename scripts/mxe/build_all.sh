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
git clone https://github.com/cypherstack/flutter_liblelantus
git reset 849a7efe0488b1ce6bb173397fb8b13d7a7da922 --hard
cd ~/src/flutter_liblelantus
cd scripts/mxe
./prep_sharedfile.sh
cd build
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
