#!/bin/bash

count=1
for params in "$*"
do
    echo "\$* parameters #$count = $params"
    count=$[ count + 1 ]
done

echo "########################################"

count=1
for params in "$@"
do
    echo "\$@ parameters #$count = $params"
    count=$[ count + 1 ]
done
