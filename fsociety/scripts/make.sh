#!/bin/bash
cd "$(dirname "$0")"
mkdir -p build
shc -o build/gprogress -rvf progress.sh
rm progress.sh.x.c
