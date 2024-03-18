#!/bin/bash

select lang in C Java Python Bash exit; do
    if [[ $lang = "exit" ]]; then
        exit 0
    fi
    echo "Hello $lang"
done
