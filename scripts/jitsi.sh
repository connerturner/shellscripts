#!/bin/sh

RANDOM=$(head -c32 /dev/urandom | base64 |  sed -e 's/[\/=]//g');

echo "https://meet.jit.si/"$RANDOM;
