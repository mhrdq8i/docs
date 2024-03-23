#!/bin/bash

function diskspace() {
    clear
    df -kh
}

function whoison() {
    clear
    who
}

function memusage() {
    cat /proc/meminfo
}

function cpuinfo() {
    cat /proc/cpuinfo
}

PS3="Enter your command: "

commands=(cpuinfo meminfo diskinfo online_users exit)

select command in ${commands[@]}; do
    case $command in
    "meminfo")
        memusage
        ;;
    "cpuinfo")
        cpuinfo
        ;;
    "diskinfo")
        diskspace
        ;;
    "online_users")
        whoison
        ;;
    "exit")
        break
        ;;
    *)
        echo "wrong selection"
        ;;
    esac
done
