#!/bin/bash

if [ $# -ne 1 ]; then
    echo "your input arguments are not equel to 1"
    echo "usage: $0 start|stop|restart|status"
    exit 1
fi

case $1 in
start)
    echo "going to start service..."
    ;;
stop)
    echo "going to stop service..."
    ;;
restart)
    echo "going to restart service..."
    ;;
status)
    echo "going to status service..."
    ;;
*)
    echo "sub-commnad is not found."
    exit 1
    ;;
esac
