#!/bin/bash

printf $(git log -1 --pretty=format:"%h %ad") >> build/git_commit_version.txt
cd build
cmake ../mobileliblelantus
make -j$(nproc)