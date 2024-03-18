#!/bin/bash

if [ $# -ne 1 ]; then
    echo "your input arguments are not equel to 1"
    echo "usage: $0 start|stop|restart|status"
    exit 1
fi

if [ $1 = "start" ];then
    echo "going to start service..."
elif [ $1 = "stop" ];then
    echo "going to stop service..."
elif [ $1 = "restart" ];then
    echo "going to restart service..."
elif [ $1 = "status" ];then
    echo "going to status service..."
else
    echo "sub-commnad is not found."
    exit 1
fi  