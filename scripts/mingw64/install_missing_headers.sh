#!/bin/bash

. ./config.sh

echo "Installing missing headers"

cp CMakeLists/missingheader/endian.h ${PREFIX}/include/endian.h
