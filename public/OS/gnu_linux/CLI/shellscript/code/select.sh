#!/bin/bash

PS3="Enter the value: "

select item in "option1" "option2" "exit"
do
    case $item in
    "exit")
        break
    ;;
    "option1") 
        "option-1 is selected"
    ;;
    "option2")
        "option-2 is selected"
    ;;
    *) 
        clear
        echo "wrong selection"
    ;;
    esac
done