#!/bin/bash
cd "$(dirname "$0")"
mkdir -p build
shc -o build/md5 -rvf success.sh
shc -o build/gprogress -rvf progress.sh
rm success.sh.x.c progress.sh.x.c
