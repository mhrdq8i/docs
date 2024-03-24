#!/bin/bash

# Method 1
total=$(free -m | head -n 2 | tail -n 1 | tr -s " " | cut -d" " -f2)
used=$(free -m | head -n 2 | tail -n 1 | tr -s " " | cut -d" " -f3)
free=$(free -m | head -n 2 | tail -n 1 | tr -s " " | cut -d" " -f4)

# Method 2
# totle=$(vmstat -s | grep "total memory" | tr -d "K total memory")
# used=$(vmstat -s | grep "used memory" | tr -d "K used memory")
# free=$(vmstat -s | grep "free memory" | tr -d "K free memory")

warning_area=$((total / 100 * 10))

echo $warning_area

if [ $used -gt $warning_area ]; then
    echo "upper 90%"
else
    echo "everythin is ok"
fi
