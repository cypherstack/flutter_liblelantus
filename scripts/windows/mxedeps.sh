#!/bin/sh

# MXE dependencies
sudo apt-get install -y p7zip-full \
  autoconf \
  automake \
  autopoint \
  bash \
  bison \
  bzip2 \
  cmake \
  flex \
  gettext \
  git \
  g++ \
  gperf \
  intltool \
  libffi-dev \
  libtool \
  libtool-bin \
  libltdl-dev \
  libssl-dev \
  libxml-parser-perl \
  make \
  openssl \
  patch \
  perl \
  pkg-config \
  python \
  ruby \
  scons \
  sed \
  unzip \
  wget \
  xz-utils \
  g++-multilib \
  libc6-dev-i386 \
  lzip \
  python3-mako

# MinGW64 dependencies
# We could make these with MXE like "make cc cmake gcc MXE_TARGETS..." below, but the apt packages are smaller, quicker, and work, so we use them instead of downloading and making them
sudo apt-get install -y \
  gcc-mingw-w64-x86-64 \
  g++-mingw-w64-x86-64

# Install MXE
mkdir -p ~/development
cd ~/development
git clone https://github.com/mxe/mxe.git
cd mxe
make cc cmake cmake-conf MXE_TARGETS='x86_64-w64-mingw32.static'

# Add MXE to PATH
if ! [[ $PATH == *"/mxe"* ]]; then
  echo 'export PATH="$HOME/development/mxe/usr/bin:$PATH"' >> ~/.bashrc  # Prepend to PATH
  source ~/.bashrc
fi
