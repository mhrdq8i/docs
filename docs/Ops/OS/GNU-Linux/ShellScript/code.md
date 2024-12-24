# Code

## Decision Making

### IF

#### Check File Type

```bash
#!/bin/bash

# check character divice files
if [ -c /dev/tty ]; then
    echo "yes '/dev/tty' is a character device"
fi

# check block divice files
if [ -b /dev/sda ]; then
    echo "yes '/dev/sda' is a block device"
fi

# check character divice files
# mkfifo /tmp/pipef
if [ -p /tmp/pipef ]; then
    echo "yes '/tmp/pipef' is a pipeline device"
fi

# check symbolic link files
if [ -h /usr/bin/java ]; then
    echo "yes '/usr/bin/java' is a symbolic link"
fi

# check symbolic link files
if [ -L /usr/bin/java ]; then
    echo "yes '/usr/bin/java' is a symbolic link"
fi

# check socket files
if [ -S /run/cups/cups.sock ]; then
    echo "yes '/run/cups/cups.sock' is a socket file"
fi

# check readable files
if [ -r /etc/passwd ]; then
    echo "yes '/etc/passwd' is a readable file"
fi

# check writable files
if [ -w /etc/passwd ]; then
    echo "yes '/etc/passwd' is a writable file"
fi

# check executable files
if [ -x /bin/bash ]; then
    echo "yes '/bin/bash' is a executable file"
fi

# check modifaction files
if [ -N /bin/bash ]; then
    echo "yes '/bin/bash' has been modified"
fi

# check SUID files
if [ -u  /usr/bin/passwd ]; then
    echo "yes '/usr/bin/passwd ' has s-user-id"
fi

# check SGID files
if [ -g /usr/bin/wall ]; then
    echo "yes '/usr/bin/wall' has s-group-id"
fi

# check sticky bite files
if [ -k /tmp ]; then
    echo "yes '/tms' has has active sticky bit"
fi

# check the file exists
if [ -e /etc/passwd ]; then
    echo "yes '/etc/passwd/' is exists"
fi

# check file exists and a directory
if [ -f /etc/passwd ];then
    echo "yes '/etc/passwd' is exists and also is a file"
fi

# check file exists and a directory
if [ -d /etc ];then
    echo "yes '/etc' is a file and also is a directory"
fi

# check file exists and readable
if [ -s /etc/passwd ];then
    echo "yes '/etc/passwd' is a file and also has content"
fi

# check file owner
if [ -O /etc ];then
    echo "yes '/etc' is for mehrdad"
else
    echo "no '/ect' for root"
fi

# check file group
if [ -G /etc ];then
    echo "yes '/etc' in mehrdad group"
else
    echo "no '/ect' in root group"
fi

if [ -f /etc/passwd ] || [ -r -x /etc/passwd ]; then
    echo "yes"
else
    echo "no"
fi

if [ ! -d /var/log ]; then
    echo "directory '/var/log' does not exist"
else
    echo "directory '/var/log' exists"
fi
```

#### Check Input Arguments

```bash
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
```

#### Is Integer?

```bash
#!/bin/bash

testuser=$1

# grep generate exit-code 0 if the condition is true
# if grep $testuser /etc/passwd; then
#     echo "user $testuser has been found"
# else
#     echo "user $testuser does not exists"
# fi

# ---

# if [ $testuser -eq 1 ]; then
#     echo "$1 is euqel with 1"
# elif [ $testuser -lt 1 ]; then
#     echo "$1 is less then 1"
# elif [ $testuser -gt 1 ]; then
#     echo "$1 is greather then 1"
# else
#     echo "false"
# fi

# ---

if [ $(echo "2>1" | bc) -eq 1 ]; then
    echo "yes"
else
    echo "no"
fi

```

#### Is String?

```bash
#!/bin/bash

testuser=mehrdad

if test $testuser = mehrdad; then
    echo "true"
else
    echo "false"
fi

# ---

str1 =  str2
str1 != str2
str1 < str1
str1 > str1
-n    check str if greater than zero
-z    check str if equal to zero
```

```bash
str1="A A"
if [ "$str1" = "A A" ]; then
    echo "true"
else
    echo "false"
fi

read -p "enter a name: " str
while [ -n $str ]   # OR while [[ $str != "" ]]
do
    echo "yes $str"
    read str
done
```

### Switch Case

```bash
#!/bin/bash

user=$1

case $user in

"mehrdad")
    echo "mehrdad"
    ;;
"leila")
    echo "leila"
    ;;
"hamid")
    echo "hamid ghasemkhani"
    ;;
*)
    echo "oh nooo"
    ;;
esac
```

#### By Predefined Arguments

```bash
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
```

### Select

```bash
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
```

```bash
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
```

```bash
#!/bin/bash

select lang in C Java Python Bash exit; do
    if [[ $lang = "exit" ]]; then
        exit 0
    fi
    echo "Hello $lang"
done
```

## Loop Condition

### For

```bash
#!/bin/bash

# C style
for ((c = 1; c <= 10; c++)); do
    echo "C is $c"
done

echo "---"

# python style
for p in {1..20..2}; do
    echo "P is $p"
done

echo "---"

# for in list
for color in red green blue; do
    echo "color is $color"
done
```

```bash
#!/bin/bash

# file as a list
lc=1
for line in $(tail -5 /etc/passwd); do
    username=$(echo $line | cut -d":" -f1)
    echo "$lc username: $username"
    lc=$(($lc + 1))
done

echo "---"

IFS=$'\n'
lc=1
for line in $(tail -5 /etc/services); do
    echo $lc $line | cut -d":" -f1
    lc=$(($lc + 1))
done

echo "---"

for f in /etc/*; do
    if [ ! -r $f ]; then
        echo "file $f is not readable"
    fi
done

echo "--- show hostname ips by type ---"

IPS=$(hostname -i)

for x in $IPS; do
    case $x in
    *"."*)
        echo "IPv4S $x"
        ;;
    *":"*)
        echo "IPv6 $x"
        ;;
    esac
done
```

```bash
#!/bin/bash

read -p "pleas enter a number: " no

for ((c = 0; c < no; c++)); do
    echo "Hello $c"
done

echo "---"

for count in $(seq 1 $no);do
    echo "Hi $count"
done
```

### While

```bash
#!/bin/bash

count=10
while [ $count -ge 1 ]
do
  echo $count
  count=$[ $count - 1 ]
done

echo "---"

while read -n1 -r -p "choose Yes|No or e for exit " && [[ $REPLY != q ]]; do
  case $REPLY in
    y) echo "Yes";;
    n) echo "No";;
    e) exit ;;
    *) echo "What?";;
  esac
done
```

```bash
#!/bin/bash

answer=""
while [ "$answer" != "yes" ] && [ "$answer" != "no" ]; do
    echo "do you want to exit? yes|no "
    read answer
    answer=`echo $answer | tr [A-Z] [a-z]`
done
```

```bash
#!/bin/bash
while IFS= read -r line;do
    echo "**$line**"
done < <(ping google.com)
```

### Break

```bash
#!/bin/bash

for var1 in {1..10}
do
    if [ $var1 -eq 5 ]; then
        break
    fi
    echo $var1
done
```

### Continue

```bash
#!/bin/bash

for var1 in {1..10}
do
    if [ $var1 -gt 3 ] && [ $var1 -lt 8 ]; then
        continue
    fi
    echo $var1
done
```

## $

### Input Parameters

```bash
#!/bin/bash

echo "\$0 your script name is $0"
echo "\$1 your first parameter is $1"
echo "\$2 your second parameter is $2"

echo "\$# you entered $# input parameter"

echo "\$? current status code is $?"

echo "'\$*' is $*"
echo "'\$@' is $@"
```

### Difference of `$@` & `$#`

```bash
#!/bin/bash

count=1
for params in "$*"
do
    echo "\$* parameters #$count = $params"
    count=$[ count + 1 ]
done

echo "---"

count=1
for params in "$@"
do
    echo "\$@ parameters #$count = $params"
    count=$[ count + 1 ]
done
```

## Exec

### exec-in

```bash
#!/bin/bash

exec 0< inputfile
count=1
while read line
do
    echo "Line #$count $line"
    count=$(( $count + 1 ))
done
```

### exec-out

```bash
#!/bin/bash

exec 1> output
echo "1"
echo "2"
echo "3"
echo "4"
echo "5"
echo "6"
echo "7"
```

### Check Exist Username

```bash
#!/bin/bash

if [ $# -ne 1 ];then
    echo "miss or more input argument!"
    echo "exact argument is one"
    exit 1
fi

query=`cut -d: -f1 /etc/passwd | grep -x "$1"`

if [ ${#query} -ne 0 ];then
    echo "user $1 has been found"
    exit 0
else
    echo "user $1 does not exitst"
    exit 1
fi
```

## Basic Input

```bash
#!/bin/bash

echo -n "Enter your name: "
read name
echo "Hello $name"
```

### Close File Descriptor

```bash
 #!/bin/bash

exec 3> output
echo "test line" >&3
exec 3>&-
echo "something..." >&3
```

```bash
#!/bin/bash

exec 1>&-
echo "something..."
```

## Add Integers

```bash
#!/bin/bash

sum=0
if [ $# -ne 2 ];then
    echo "$0 is wrong! you must enter 2 number"
else
    sum=$[ $1 + $2 ] # other format sum=$(( $1 + $2 ))
    echo $sum
fi
```

## Get Current working directory and Basename

### Directory Basename

```bash
#!/bin/bash

basename $0
dirname $0

# /dir/name/basename.file
```

### Print current directory

```bash
#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $script_dir
```

### Print basename

```bash
#!/bin/bash

pd=`pwd`
bn=`basename $0`
dirname $0

echo "${pd}/${bn}"
```

## Factorial

```bash
#!/bin/bash

fact=1
i=1
while [ $i -le $1 ]
do
    fact=$(($fact * $i))
    i=$(($i + 1))
done
echo "The factorial $1 is $fact"
```

## Function

```bash
#!/bin/bash

function myFunc0 {
    echo ${1:-defualt} #set default value for function parameter
}

myFunc1() {
    echo ${3:=default}
    echo $#
    echo $1
    echo $2
    echo $3

}

function myFunc2 {
    echo "Hello Func 2"
}

myFunc3() {
    return 10
}

echo "function 0"
myFunc0

echo

echo "function 1"
myFunc1 mehrdad radin leila
myFunc1

echo

echo "function 2"
func_var=$(myFunc2)
echo $func_var

echo

echo "function 3"
myFunc3
echo $?
```

## lsof

```bash
# testing lsof with file descriptors
touch testfile7
exec 3>testfile3
exec 6>testfile6
exec 7<testfile7
lsof -a -p $$ -d 0,1,2,3,6,7
```

## Memory Alert

```bash
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
```

## Parameters Options

```bash
#!/bin/bash

while getopts ab:c opt; do
    case "$opt" in
    a) echo "found option -a" ;;
    b) echo "found option -b with parameter $OPTARG" ;;
    c) echo "found option -c" ;;
    *) echo "$0 --help" ;;
    esac
done
```

## Read From File

```bash
# #!/bin/bash
count=1
cat /etc/passwd | while read line; do
    echo "Line $count: $line"
    count=$(($count + 1))
done
```

```bash
#!/bin/bash
count=1
while read line; do
    echo "Line $count: $line"
    count=$(($count + 1))
done < /etc/passwd
```

## Redirection Priority

```bash
#!/bin/bash

exec 3>&1
exec 1> output
echo "Line 3"
echo "Line 4" >&3
exec 1>&3
echo "normal"
```

## Shift Over Option

```bash
#!/bin//bash

while [ -n "$1" ]; do
    case "$1" in
    -a)
        echo "found -a option"
        ;;
    -b)
        echo "found -b option"
        ;;
    -c)
        echo "found -c option"
        ;;
    *)
        echo "$1 is not define"
        ;;
    esac
    shift
done
```

## Varfile

```bash
#!/bin/bash

x=10
echo :$x:
```

## Color

```bash
#!/bin/bash

WHITE='\033[0;47m'
BOLD_WHITE='\033[1;47m'
BLACK='\033[0;30m'
BOLD_BLACK='\033[1;30m'
BLUE='\033[0;34m'
BOLD_BLUE='\033[1;34m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
GREEN='\033[0;32m'
BOLD_GREEN='\33[1;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
BOLD_PURPLE='\033[1;35m'
NC='\033[0m' # No Color

### effects
#  echo -e "\033[0;33mSample text"
#  echo -e "\033[1;37mBold text"
#  echo -e "\033[2;33mLow intensity text"
#  echo -e "\033[4;33mUnderline text"
#  echo -e "\033[5;33mBlinking text"
#  echo -e "\033[8;33mInvisible text"
#  echo -e "\033[9;33mStrikethrough text${NC}"

#echo -e "${BLUE}blue ${RED}red${NC} ${YELLOW}yellow "
printf "${BLUE}blue ${RED}red ${GREEN}green ${WHITE}white ${BLACK}black ${YELLOW}yellow ${PURPLE}purple ${NC}\n"
printf "${BOLD_BLUE}bold_blue ${BOLD_RED}bold_red ${BOLD_GREEN}bold_green ${BOLD_WHITE}bold_white ${NC} ${BOLD_BLACK}bold_black ${BOLD_YELLOW}bold_yellow ${BOLD_PURPLE}bold_purple ${NC}\n"
```
