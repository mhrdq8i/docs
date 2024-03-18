#!/bin/bash

# file as a list
lc=1
for line in $(tail -5 /etc/passwd); do
    username=$(echo $line | cut -d":" -f1)
    echo "$lc username: $username"
    lc=$(($lc + 1))
done

echo "------------------------------------"

IFS=$'\n'
lc=1
for line in $(tail -5 /etc/services); do
    echo $lc $line | cut -d":" -f1
    lc=$(($lc + 1))
done

echo "------------------------------------"

for f in /etc/*; do
    if [ ! -r $f ]; then
        echo "file $f is not readable"
    fi
done

echo "------ show hostname ips by type ------"

IPS=$(hostname -i)

for x in $IPS; do
    case $x in
    *"."*)
        echo "IPv4S $x"
        ;;
    *":"*)
        echo "IPv6 $x"
        ;;
    esac
done
