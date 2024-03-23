#!/bin/bash

function myFunc0 {
    echo ${1:-defualt} #set default value for function parameter
}

myFunc1() {
    echo ${3:=default}
    echo $#
    echo $1
    echo $2
    echo $3

}

function myFunc2 {
    echo "Hello Func 2"
}

myFunc3() {
    return 10
}

echo "function 0"
myFunc0

echo

echo "function 1"
myFunc1 mehrdad radin leila
myFunc1

echo

echo "function 2"
func_var=$(myFunc2)
echo $func_var

echo

echo "function 3"
myFunc3
echo $?