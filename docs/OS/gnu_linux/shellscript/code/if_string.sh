#!/bin/bash

testuser=mehrdad

# if test $testuser = mehrdad; then
#     echo "true"
# else
#     echo "false"
# fi


# str1 =  str2 
# str1 != str2
# str1 < str1
# str1 > str1
# -n    check str if greater than zero
# -z    check str if equel to zero

# str1="A A"
# if [ "$str1" = "A A" ]; then
#     echo "true"
# else
#     echo "false"
# fi

read -p "enter a name: " str
while [ -n $str ]   # OR while [[ $str != "" ]]
do
    echo "yes $str"
    read str
done