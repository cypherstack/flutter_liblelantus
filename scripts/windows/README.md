# `flutter_liblelantus`
## Building for Windows
### Install MXE dependencies
Run `mxedeps.sh` to install MXE and its dependencies, or use the commands below:
```bash
sudo apt-get install p7zip-full autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libtool-bin libltdl-dev libssl-dev libxml-parser-perl make openssl patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386 lzip
```

### Install MXE dependencies
If `mxedeps.sh` wasn't ran, use the commands below: 
```bash
sudo apt-get install -y gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 python3-mako
```

### Install MXE
If `mxedeps.sh` wasn't ran, use the commands below: 
```bash
mkdir -p ~/development
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

### Build
Run `build_all.sh` (may need to alter permissions like with `chmod +x *.sh`)

Libraries will be output to `scripts/windows/build`
