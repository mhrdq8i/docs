#!/bin/bash

sum=0
if [ $# -ne 2 ];then
    echo "$0 is wrong! you must enter 2 number"
else
    sum=$[ $1 + $2 ] # other format sum=$(( $1 + $2 ))
    echo $sum
fi
