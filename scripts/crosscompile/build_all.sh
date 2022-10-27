#!/bin/bash

mkdir build
mkdir cache
./build_openssl.sh
./prep_sharedfile.sh
./build_sharedfile.sh