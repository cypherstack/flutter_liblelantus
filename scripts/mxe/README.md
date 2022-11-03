Install dependencies
```bash
sudo apt-get install p7zip-full autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libtool-bin libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386
```

Build MXE and dependencies
```bash
mkdir ~/development
cd ~/development
git clone https://github.com/mxe/mxe.git
cd mxe
make cc cmake MXE_TARGETS='x86_64-w64-mingw32.static'
if ! [[ $PATH == *"/mxe"* ]]; then
	echo 'export PATH="$HOME/development/mxe/usr/bin:$PATH"' >> ~/.bashrc  # Prepend to PATH
	source ~/.bashrc
fi
make cmake MXE_TARGETS='x86_64-w64-mingw32.static'
```

Build mobileliblelantus
```bash
mkdir ~/src
cd ~/src
git clone https://github.com/cypherstack/flutter_liblelantus
cd flutter_liblelantus
git checkout build/mxe
#git reset af6c304fd02b145d1d5e21e6341f9a71f756c09f --hard
cd scripts/mxe
./prep_sharedfile.sh # Copies mobileliblelantus repo, some headers and includes, and CMakeLists
cd build
rm CMakeCache.txt
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
```

Partially derived from:
https://steemit.com/howto/@pxlfussel/howto-cross-compile-coins-with-mxe-or-setup-mxe
https://www.andrews-corner.org/mxe.html