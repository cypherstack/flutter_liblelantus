Install dependencies
```bash
sudo apt-get install p7zip-full autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libtool-bin libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386
```

Build MXE and dependencies
```bash
mkdir ~/development
cd ~/development
# TODO check if MXE is built; if it is, don't.
git clone https://github.com/mxe/mxe.git
cd mxe
make cc cmake MXE_TARGETS='x86_64-w64-mingw32.static'
# Prepend to PATH
if ! [[ $PATH == *"/mxe"* ]]; then
	echo 'export PATH="$HOME/development/mxe/usr/bin:$PATH"' >> ~/.bashrc 
	source ~/.bashrc
fi
make cmake MXE_TARGETS='x86_64-w64-mingw32.static'
```

Build mobileliblelantus
```bash
cd ~
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git reset baf1f7c4028f4697c2c3dfed6357a1367cd3999b --hard
cd scripts/mxe
./prep_sharedfile.sh # Copies mobileliblelantus repo, some headers and includes, and CMakeLists
cd build
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
```

Partially derived from:
https://steemit.com/howto/@pxlfussel/howto-cross-compile-coins-with-mxe-or-setup-mxe
https://www.andrews-corner.org/mxe.html
