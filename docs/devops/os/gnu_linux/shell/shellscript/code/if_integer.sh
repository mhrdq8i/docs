#!/bin/bash

testuser=$1

# grep generate exit-code 0 if the condition is true
# if grep $testuser /etc/passwd; then
#     echo "user $testuser has been found"
# else
#     echo "user $testuser does not exists"
# fi

##############################################################

# if [ $testuser -eq 1 ]; then
#     echo "$1 is euqel with 1"
# elif [ $testuser -lt 1 ]; then
#     echo "$1 is less then 1"
# elif [ $testuser -gt 1 ]; then
#     echo "$1 is greather then 1"
# else
#     echo "false"
# fi

##############################################################

if [ $(echo "2>1" | bc) -eq 1 ]; then
    echo "yes"
else
    echo "no"
fi
