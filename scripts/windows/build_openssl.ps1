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

cd ..
cd ..
