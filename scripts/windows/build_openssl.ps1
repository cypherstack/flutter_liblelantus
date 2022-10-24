#! /usr/bin/pwsh

./config.ps1
$env:OPENSSL_FILENAME="openssl-1.1.1k.tar.gz"
$env:OPENSSL_FILE_PATH="${env:WORKDIR}\${env:OPENSSL_FILENAME}"
$env:OPENSSL_SRC_DIR="${env:WORKDIR}\openssl-1.1.1k"
$env:OPENSSL_SHA256="892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5"
$env:ZLIB_DIR="${env:WORKDIR}\zlib"
$env:ZLIB_TAG="v1.2.11"
$env:ZLIB_COMMIT_HASH="cacf7f1d4e3d44d871b605da3b647f07d718623f"