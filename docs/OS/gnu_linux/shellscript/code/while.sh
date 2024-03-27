#!/bin/bash

count=10
while [ $count -ge 1 ]
do
  echo $count
  count=$[ $count - 1 ]
done

echo "---------------------------"

while read -n1 -r -p "choose Yes|No or e for exit " && [[ $REPLY != q ]]; do
  case $REPLY in
    y) echo "Yes";;
    n) echo "No";;
    e) exit ;;
    *) echo "What?";;
  esac
done
