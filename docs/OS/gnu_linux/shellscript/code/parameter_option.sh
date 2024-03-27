#!/bin/bash

while getopts ab:c opt; do
    case "$opt" in
    a) echo "found option -a" ;;
    b) echo "found option -b with parameter $OPTARG" ;;
    c) echo "found option -c" ;;
    *) echo "$0 --help" ;;
    esac
done
