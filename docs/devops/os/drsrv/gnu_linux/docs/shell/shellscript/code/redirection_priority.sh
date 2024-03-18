#!/bin/bash

exec 3>&1
exec 1> output
echo "Line 3"
echo "Line 4" >&3
exec 1>&3
echo "normal"