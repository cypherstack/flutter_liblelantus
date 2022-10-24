#!/bin/pwsh

$env:API=21
$dir = (Get-Item .).FullName
$env:WORKDIR="${dir}\build"
$env:ANDROID_NDK_ZIP="${env:WORKDIR}\android-ndk-r17c.zip"
$env:ANDROID_NDK_ROOT="${env:WORKDIR}\android-ndk-r17c"
$env:ANDROID_NDK_HOME="${env:ANDROID_NDK_ROOT}"
$env:TOOLCHAIN_DIR="${env:WORKDIR}\toolchain"
$env:TOOLCHAIN_BASE_DIR="${env:TOOLCHAIN_DIR}"
$env:ORIGINAL_PATH="${env:PATH}"
$env:THREADS=8
$env:TYPES_OF_BUILD="x86_64"

if (Test-Path 'env:IS_ARM ') {
  $env:TYPES_OF_BUILD="aarch64"
} else {
  $env:TYPES_OF_BUILD="x86_64"
}
