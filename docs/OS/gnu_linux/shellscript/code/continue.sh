#!/bin/bash

for var1 in {1..10}
do
    if [ $var1 -gt 3 ] && [ $var1 -lt 8 ]; then
        continue
    fi
    echo $var1
done
