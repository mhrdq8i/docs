#!/bin//bash

while [ -n "$1" ]; do
    case "$1" in
    -a)
        echo "found -a option"
        ;;
    -b)
        echo "found -b option"
        ;;
    -c)
        echo "found -c option"
        ;;
    *)
        echo "$1 is not define"
        ;;
    esac
    shift
done
