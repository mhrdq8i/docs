# Shellscript manual

## Array

| syntax | result |
| - | - |
| arr=() | Create an empty array |
| arr=(1 2 3) | Initialize array|
| ${arr[2]} | Retrieve third element |
| ${arr[@]} | Retrieve all elements |
| ${!arr[@]} | Retrieve array indices |
| ${#arr[@]} | Calculate array size |
| arr[0]=3 | Overwrite 1st element |
| arr+=(4) | Append value(s) |
| str=$(ls) | Save ls output as a string |
| arr=( $(ls) ) | Save ls output as an array of files |
| ${arr[@]:s:n} | Retrieve n elements starting at index s |
| {a,b}{+,-} | Cartesian multiply |

## bc

### calculate numbers with `bc` command with 5 number flot

```bash
echo  "scale=5; 100/3" | bc
```

### compare to number with `bc`

```bash
- echo "10>30" | bc
```

## Dollar-sign with Their Example

|sign | means |
| - | - |
| [$#] | number of input parameters |
| [$0] | return the current code name |
| [$1] | refer to the first input argument |
| [$2] | refer to the second input argument |
| [$N] | refer to the nth input argument |
| [$?] | return shell status code/exit code |
| $$   | return shell process id |
| $!   | return the PID of the last background process |
| $-   | return current shell status |
| $\_  | return last argument from last command |
| !$   | execute last argument from last command |
| [$\*]| return the input arguments in one line |
| [$@] | return the input arguments line by line |

## Function

| definition | call |
| - | - |
| function myFunc0{ ... } | myFunc0 |
| myFunc1() { ... } | myFunc1 mehrdad radin leila |

## Bash Comparisons

### Test the Numeric Comparisons

| Comparison | Description |
| - | - |
| n1 -eq n2 | Check if n1 is equal to n2 |
| n1 -ge n2 | Check if n1 is greater than or equal to n2 |
| n1 -gt n2 | Check if n1 is greater than n2 |
| n1 -le n2 | Check if n1 is less than or equal to n2 |
| n1 -lt n2 | Check if n1 is less than n2 |
| n1 -ne n2 | Check if n1 is not equal to n2 |

### String Comparisons

| Comparison | Description |
| - | - |
| str1 = str2  | Check if str1 is the same as string str2 |
| str1 != str2 | Check if str1 is not the same as str2 |
| str1 < str2  | Check if str1 is less than str2 |
| str1 > str2  | Check if str1 is greater than str2 |
| -n str1      | Check if str1 has a length greater than zero |
| -z str1      | Check if str1 has a length of zero |

### The `test` Command File Comparisons

| Comparison | Description |
| - | - |
| [-d] file | Check if file exists and is a directory |
| [-e] file | Checks if file exists |
| [-f] file | Checks if file exists and is a file |
| [-s] file | Checks if file exists and is not empty |
| [-r] file | Checks if file exists and is readable |
| [-w] file | Checks if file exists and is writable |
| [-x] file | Checks if file exists and is executable |
| [-O] file | Checks if file exists and is owned by the current user |
| [-G] file | Checks if file exists and the default group is the same as the current user |
| file1 -nt file2 | Checks if file1 is newer than file2 |
| file1 -ot file2 | Checks if file1 is older than file2 |

## File Descriptor Options

| Option | Description |
| -- | -- |
| -a | Show all objects |
| -f | Specify a file to read data from |
| -h | Display a help message for the command |
| -n | Do nothing, just display what will happen |
| -o | Specify an output file to redirect all output to |
| -q | Run in quiet mode |
| -r | Process directories and files recursively |
| -s | Run in silent mode |
| -v | Produce verbose output |
| -y | Answer yes to all questions |

## lsof

| Column |  Description |
| - | - |
| COMMAND | The first nine characters of the name of the command in the process |
| PID | The process ID of the process |
| USER | The login name of the user who owns the process |
| FD | The file descriptor number and access type (r - read, w - write, u - read/write) |
| TYPE | The type of file (CHR - character, BLK - block, DIR - directory, REG - regular file) |
| DEVICE | The device numbers (major and minor) of the device |
| SIZE | If available, the size of the file |
| NODE | The inode number of the local file |
| NAME | The name of the file |

### Example

```bash
lsof -a -p $$ -d 0,1,2

-a: means and conditions together
-p: lsof condition over the specific process
-d: select some file descriptor
```

## Print Screen

| syntax | result |
| - | - |
| str=$'\e[%d;%dHSalam' | printf $str 5 10 |
| echo $'\e[10;10HSalam' | print in the row #10 column #10 |

## Read

| argument | result |
| - | - |
| read -s | does not echo input |
| read -nN | accepts only N characters of input |
| read -p | prompt message |
| read -tT | accepts input for T second |

## Redirection

### Docs

- [gun doc][gundoc]

- [visualize doc][visualizedoc]

### Note

- **&0** is equel to `/proc/slef/fd/0`
- **&1** is equel to `/proc/slef/fd/1`
- **&2** is equel to `/proc/slef/fd/2`

## Shell Status Code Descriptor

| Code | Description |
|-|-|
| 0 | Successful completion of the command Create an empty array |
| 1 | General unknown error |
| 2 | 2 Misuse of shell command |
| 126 | The command can’t execute |
| 127 | Command not found |
| 128 | Invalid exit argument |
| 128+x | Fatal error with Linux signal x |
| 130 | Command terminated with Ctl-C |
| 255 | Exit status out of range |

## String

| sign | mean |
| -- | -- |
| ${str}ABC | add `ABC` to the end of the string |
| ${str/subSTR/} |  remove sub string from main string |
| ${str/old/new} | substitute `new` string with `old` string |
| {str:=sara} | print the value of `str` if exists otherwise print sara |
| {str:-sara} | print the value of `str` if exists otherwise print sara |
| {str:?sara} | print the value of `str` if exists otherwise print sara |
| {#str} | return the str length |
| ${str%?} | remove the last character |
| ${str%#} | remove the first character |
| ${str%A*} | remove the characters after `A` |
| ${str%A*C} | remove `A-C` from the end of the string |
| ${str%%A*C} | remove `A-C` from the beginning of the string |
| {m:0:3} | slice string |

<!-- links -->
[$#]: ../code/dollars.sh
[$0]: ../code/dollars.sh
[$1]: ../code/dollars.sh
[$2]: ../code/dollars.sh
[$N]: ../code/dollars.sh
[$?]: ../code/dollars.sh
[$\*]: ../code/dollar-at-astrisk.sh
[$@]: ../code/dollar-at-astrisk.sh|
[gundoc]: https://www.gnu.org/software/bash/manual/html_node/Redirections.html
[visualizedoc]: https://catonmat.net/bash-one-liners-explained-part-three
