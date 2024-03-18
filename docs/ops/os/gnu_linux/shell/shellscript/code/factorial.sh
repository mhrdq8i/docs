#!/bin/bash

fact=1
i=1
while [ $i -le $1 ]
do
    fact=$(($fact * $i))
    i=$(($i + 1))
done
echo "The factorial $1 is $fact"
