#!/bin/bash

. ./config.sh

mkdir $WORKDIR/mobileliblelantus
mkdir $WORKDIR/mobileliblelantus/bitcoin
mkdir $WORKDIR/mobileliblelantus/include
mkdir $WORKDIR/mobileliblelantus/secp256k1
mkdir $WORKDIR/mobileliblelantus/src
mkdir $WORKDIR/mobileliblelantus/tests
cp -r ../../mobileliblelantus ./build

echo "Copied mobileliblelantus"
