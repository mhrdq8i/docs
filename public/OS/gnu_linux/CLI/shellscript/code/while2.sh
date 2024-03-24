#!/bin/bash

answer=""
while [ "$answer" != "yes" ] && [ "$answer" != "no" ]; do
    echo "do you want to exit? yes|no "
    read answer
    answer=`echo $answer | tr [A-Z] [a-z]`
done
