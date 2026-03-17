#!/bin/bash
#Cari Blaker
#Midterm CST240 #2

if [ $# -lt 2 ]; then #if the total number of parameters given is less than two
    echo "Error: must give at least 2 numbers"      #error message prints
    exit 1

else                #otherwise, the numbers are multiplied by multiplying each number to the "result" which starts at 1"
    result=1
    for nums in "$@"; do
        ((result *= nums))
    done
    echo "$result"
fi


exit 0
