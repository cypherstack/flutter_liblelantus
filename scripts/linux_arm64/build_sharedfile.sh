#!/bin/bash

cd build
cmake ../mobileliblelantus
make -j$(nproc)