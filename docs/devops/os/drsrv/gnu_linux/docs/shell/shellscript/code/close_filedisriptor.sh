#!/bin/bash

exec 3> output
echo "test line" >&3
exec 3>&-
echo "something..." >&3