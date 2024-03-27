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

