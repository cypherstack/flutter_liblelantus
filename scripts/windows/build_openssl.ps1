#! /usr/bin/pwsh

./config.ps1
$env:OPENSSL_FILENAME = "openssl-1.1.1k.tar.gz"
$env:OPENSSL_FILE_PATH = "${env:WORKDIR}\${env:OPENSSL_FILENAME}"
$env:OPENSSL_SRC_DIR = "${env:WORKDIR}\openssl-1.1.1k"
$env:OPENSSL_SHA256 = "892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
$env:ZLIB_DIR = "${env:WORKDIR}\zlib"
$env:ZLIB_TAG = "v1.2.11"
$env:ZLIB_COMMIT_HASH = "cacf7f1d4e3d44d871b605da3b647f07d718623f"

if (!(Test-Path -Path $env:ZLIB_DIR)) {
    Write-Output "${env:ZLIB_DIR} doesn't exist, cloning github.com/madler/zlib"
    git clone -b $env:ZLIB_TAG --depth 1 https://github.com/madler/zlib $env:ZLIB_DIR
}
cd $env:ZLIB_DIR
git reset --hard $env:ZLIB_COMMIT_HASH
#./configure --static # TODO translate to PowerShell
cmake # This and the next line require these scripts to be ran from a Visual Studio Developer PowerShell (or cmake and msbuild need to be in PATH)
msbuild zlib.sln

if (!(Test-Path $env:OPENSSL_FILE_PATH -PathType Leaf)) {
    Write-Output "${$env:OPENSSL_FILE_PATH} doesn't exist, downloading it"
    curl https://www.openssl.org/source/${env:OPENSSL_FILENAME} -o ${env:OPENSSL_FILE_PATH}
} else {
    Write-Output "${$env:OPENSSL_FILE_PATH} already exists, not downloading it"
}
$hash = (Get-FileHash $env:OPENSSL_FILE_PATH).Hash
if ($hash -eq $env:OPENSSL_SHA256) {
    Write-Output "${env:OPENSSL_FILE_PATH} hash ${hash} matches reference hash ${env:OPENSSL_SHA256}, continuing"
} else {
    Write-Output "${env:OPENSSL_FILE_PATH} hash ${hash} does not match reference hash ${env:OPENSSL_SHA256}, deleting it and restarting"
    Remove-Item -Path ${env:OPENSSL_FILE_PATH}
    cd ..
    cd ..
    ./build_openssl.ps1
    exit
}

foreach($arch in $env:TYPES_OF_BUILD) {
    Write-Output "Building ${arch}"
    $env:PREFIX="${env:WORKDIR}/prefix_${arch}"

    Switch ($arch) {
        "x86_64" {
            $env:X_ARCH="windows-x86_64"
            VsDevCmd.bat -host_arch=amd64 -arch=amd64
        }
        "aarch64" {
            $env:X_ARCH="windows-aarch64"
            VsDevCmd.bat -host_arch=arm64 -arch=arm64
        }
        default {
            $env:X_ARCH="windows-x86_64"
            VsDevCmd.bat -host_arch=amd64 -arch=amd64
        }
    }

    cd $env:WORKDIR
    if ((Test-Path $env:OPENSSL_SRC_DIR -PathType Leaf)) {
        Write-Output "${env:OPENSSL_SRC_DIR} exists, deleting it"
        Remove-Item $env:OPENSSL_SRC_DIR -Recurse
    }
    Write-Output "extracting ${env:OPENSSL_FILE_PATH} to ${env:WORKDIR}"
    tar -xzf $env:OPENSSL_FILE_PATH -C $env:WORKDIR
    cd $env:OPENSSL_SRC_DIR
    Write-Output "extracted"

    <#
    #sed -i -e "s/mandroid/target\ ${TARGET}\-linux\-android/" Configure
        ./Configure ${X_ARCH} \
        no-asm no-shared \
        --with-zlib-include=${PREFIX}/include \
        --with-zlib-lib=${PREFIX}/lib \
        --prefix=${PREFIX} \
        --openssldir=${PREFIX}
    #>
    Write-Output "configuring openssl"
    perl Configure VC-WIN64A no-shared no-idea # This and the next two functional lines require these scripts to be ran from a Visual Studio x64 Native Tools Command Prompt
    Write-Output "openssl configured"
    Write-Output "building openssl"
    nmake clean # -j${env:THREADS}
    Write-Output "openssl built"
    Write-Output "installing openssl"
    nmake install_sw DESTDIR=..\openssl # -j${env:THREADS} # Must install to destination directory, installing by default places files in C:\Program Files\OpenSLL, which requires administrator privileges
    Write-Output "openssl installed"
}

cd ..
cd ..
