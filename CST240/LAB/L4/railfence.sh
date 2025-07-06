#!/bin/bash

#Cari Blaker
#CST240 Lab4

# Check if the correct number of arguments were passed
if [ $# -ne 2 ]; then
  echo "Usage: $0 <key> <filename>"
  exit 1
fi

# Set the key and filename variables
key=$1
filename=$2

# Check if the file exists
if [ ! -f $filename ]; then
  echo "Error: $filename does not exist"
  exit 1
fi

# Remove all non-lowercase characters from the file
tr -cd '[:lower:]' < $filename > ${filename}.clean

# Encrypt the file using Rail Fence cipher
tr '[:lower:]' "$(echo {a..z} | tr -d ' ' | fold -w 1 | paste -sd '' -)" < ${filename}.clean | awk -v key=$key '{ for (i=0;i<key;i++) {for (j=i; j<length; j+=key) printf("%c",substr($0,j+1,1));} printf "\n" }' > ${filename}.encrypted

echo "Encryption complete. Encrypted file: ${filename}.encrypted"

