#!/bin/bash

. ./config.sh

cp CMakeLists/missingheader/endian.h ${PREFIX}/include/endian.h

echo "Installed missing headers"
