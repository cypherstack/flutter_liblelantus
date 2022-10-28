https://steemit.com/howto/@pxlfussel/howto-cross-compile-coins-with-mxe-or-setup-mxe
https://www.andrews-corner.org/mxe.html

sudo apt-get install p7zip-full autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libtool-bin libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386

```bash
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
# TODO git clone
cd ~/src/flutter_liblelantus
cd scripts/mxe
./prep_sharedfile.sh
cd build
x86_64-w64-mingw32.static-cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
```
