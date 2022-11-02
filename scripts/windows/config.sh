#!/bin/sh

export WORKDIR="$(pwd)/"build
export SEDWORKDIR=$(echo $WORKDIR | sed 's/\//\\\//g')
