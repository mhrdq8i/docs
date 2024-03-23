# Bash Comparisons

## The test Numeric Comparisons

| Comparison | Description |
| -- | -- |
| n1 -eq n2 | Check if n1 is equal to n2 |
| n1 -ge n2 | Check if n1 is greater than or equal to n2 |
| n1 -gt n2 | Check if n1 is greater than n2 |
| n1 -le n2 | Check if n1 is less than or equal to n2 |
| n1 -lt n2 | Check if n1 is less than n2 |
| n1 -ne n2 | Check if n1 is not equal to n2 |

---

## String comparisons

| Comparison | Description |
| -- | -- |
| str1 = str2  | Check if str1 is the same as string str2 |
| str1 != str2 | Check if str1 is not the same as str2 |
| str1 < str2  | Check if str1 is less than str2 |
| str1 > str2  | Check if str1 is greater than str2 |
| -n str1      | Check if str1 has a length greater than zero |
| -z str1      | Check if str1 has a length of zero |

---

## The `test` Command File Comparisons

| Comparison | Description |
| -- | -- |
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
