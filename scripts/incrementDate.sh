#!/bin/sh

# date to break loop. [Must match -I format of GNU Date]
d=2019-07-01

while [ "$d" != $(date -I) ]; do 
    echo "$d"
    # do something
    d=$(date -I -d "$d + 1 day")
done
