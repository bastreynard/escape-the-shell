#!/bin/bash
# This is the openssl command to unencrypt the victory message
# It is binified using shc and placed in /usr/lib/md5 inside the container
# This is because my "too" smart friend was able to see the victory message without actually cleaning the system...
openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -salt -pass pass:XER0 -in /usr/.success.txt