#! /usr/bin/pwsh

./config.ps1

# zlib
if (!(Test-Path -Path $env:ZLIB_DIR)) {
    Write-Output "${env:ZLIB_DIR} doesn't exist, cloning github.com/madler/zlib"
    git clone -b $env:ZLIB_TAG --depth 1 https://github.com/madler/zlib $env:ZLIB_DIR
}
cd $env:ZLIB_DIR
git reset --hard $env:ZLIB_COMMIT_HASH
#./configure --static # TODO translate to PowerShell
cmake . -G "Visual Studio 15 2017 Win64" -A x64 -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_CL_64=1 -lcrypt32 -lws2_32  # -DCMAKE_C_COMPILER:PATH="C:\Program Files\LLVM\bin\clang.exe" -DCMAKE_CXX_COMPILER:PATH="C:\Program Files\LLVM\bin\clang.exe" -DCMAKE_C_COMPILER_ID="Clang" -DCMAKE_CXX_COMPILER_ID="Clang" -DCMAKE_SYSTEM_NAME="Generic" -T ClangCL,host=x64 # This and the next line require these scripts to be ran from a Visual Studio Developer PowerShell (or cmake and msbuild need to be in PATH)
msbuild zlib.sln /property:Configuration=Release /property:Platform=x64

# openssl
cd ${env:dir}
New-Item -ItemType Directory -Force -Path ${env:OPENSSL_FILE_DIR}
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
    ./build_openssl.ps1 # Restart; redownload
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
    if ((Test-Path $env:OPENSSL_SRC_DIR -PathType Leaf)) { # TODO detect if built and installed, if so skip
        Write-Output "${env:OPENSSL_SRC_DIR} exists, deleting it"
        Remove-Item $env:OPENSSL_SRC_DIR -Recurse
    }
    Write-Output "extracting ${env:OPENSSL_FILE_PATH} to ${env:WORKDIR}"
    tar -xzf $env:OPENSSL_FILE_PATH -C $env:WORKDIR
    cd $env:OPENSSL_SRC_DIR
    Write-Output "extracted"

    Write-Output "configuring openssl"
    #perl Configure VC-WIN64A no-shared no-idea
    perl Configure no-idea no-shared VC-WIN64A OPENSSL_LIBS="-llibssl -llibcrypto -lcrypt32 -lws2_32" # -MT -Z7 threads no-deprecated This and the next two functional lines require these scripts to be ran from a Visual Studio x64 Native Tools Command Prompt
    Write-Output "openssl configured"
    Write-Output "building openssl"
    nmake # -j${env:THREADS}
    Write-Output "openssl built"
    Write-Output "installing openssl"
    nmake install DESTDIR=${env:WORKDIR}\openssl # -j${env:THREADS} # Must install to destination directory, installing by default places files in C:\Program Files\OpenSLL, which requires administrator privileges
    Write-Output "openssl installed"
    if ((Test-Path -Path "${env:CWORKDIR}/openssl/Program Files")) {
        Copy-Item "${env:CWORKDIR}/openssl/Program Files/OpenSSL/*" -Destination "${env:CWORKDIR}/openssl" -Force -Recurse # TODO add \bin to PATH?
        Write-Output "openssl moved"
    }
}

cd ..
cd ..
