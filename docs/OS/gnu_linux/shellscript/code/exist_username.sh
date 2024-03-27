#!/bin/bash

if [ $# -ne 1 ];then
    echo "miss or more input argument!"
    echo "exact argument is one"
    exit 1
fi

query=`cut -d: -f1 /etc/passwd | grep -x "$1"`

if [ ${#query} -ne 0 ];then
    echo "user $1 has been found"
    exit 0
else
    echo "user $1 does not exitst"
    exit 1
fi