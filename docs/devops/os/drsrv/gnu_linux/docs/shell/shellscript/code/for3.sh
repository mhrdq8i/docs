#!/bin/bash

read -p "pleas enter a number: " no

for ((c = 0; c < no; c++)); do
    echo "Hello $c"
done

echo "------------------------"

for count in $(seq 1 $no);do
    echo "Hi $count"
done
