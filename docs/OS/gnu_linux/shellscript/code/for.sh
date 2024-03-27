#!/bin/bash

# C style
for ((c = 1; c <= 10; c++)); do
    echo "C is $c"
done

echo "-------------"

# python style
for p in {1..20..2}; do
    echo "P is $p"
done

echo "-------------"

# for in list
for color in red green blue; do
    echo "color is $color"
done