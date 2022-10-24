#!/bin/pwsh

$env:API=21
$env:WORKDIR="${(Get-Item .).FullName}/build"
$env:ANDROID_NDK_ZIP="${WORKDIR}/android-ndk-r17c.zip"
$env:ANDROID_NDK_ROOT="${WORKDIR}/android-ndk-r17c"
$env:ANDROID_NDK_HOME="$ANDROID_NDK_ROOT"
$env:TOOLCHAIN_DIR="${WORKDIR}/toolchain"
$env:TOOLCHAIN_BASE_DIR="$TOOLCHAIN_DIR"
$env:ORIGINAL_PATH="$PATH"
$env:THREADS=8
$env:TYPES_OF_BUILD="x86_64"

if (Test-Path 'env:IS_ARM ') {
  $env:TYPES_OF_BUILD="aarch64"
} else {
  $env:TYPES_OF_BUILD="x86_64"
}
