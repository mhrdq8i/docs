| syntax | result |
| -- | -- |
| str=$'\e[%d;%dHSalam' | printf $str 5 10 | 
| echo $'\e[10;10HSalam' | print in the row #10 column #10 |
