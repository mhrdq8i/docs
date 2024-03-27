#!/bin/bash

for var1 in {1..10}
do
    if [ $var1 -eq 5 ]; then
        break
    fi
    echo $var1
done
