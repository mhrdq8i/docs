# #!/bin/bash

# # example 1
# count=1
# cat /etc/passwd | while read line; do
#     echo "Line $count: $line"
#     count=$(($count + 1))
# done

# #################################################

# example 2
#!/bin/bash

count=1
while read line; do
    echo "Line $count: $line"
    count=$(($count + 1))
done < /etc/passwd
