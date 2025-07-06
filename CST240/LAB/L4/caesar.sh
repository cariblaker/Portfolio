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

# Encrypt the file using Caesar cipher
cat $filename | tr 'a-z' "$(echo abcdefghijklmnopqrstuvwxyz | tr "a-z" "$(echo abcdefghijklmnopqrstuvwxyz | cut -c$((${key}+1))-26)$(echo abcdefghijklmnopqrstuvwxyz | cut -c1-${key})")" > ${filename}.encrypted

echo "Encryption complete. Encrypted file: ${filename}.encrypted"

