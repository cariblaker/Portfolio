
#!/bin/bash

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

# Encrypt the file using substitution cipher and save to file
cat $filename | tr 'a-z' "$key" > ${filename}.encrypted

# Output the encrypted contents to the terminal
echo "Encryption complete. Encrypted file contents:"
cat ${filename}.encrypted

# Output a message indicating the encrypted file was created
echo "Encrypted file created: ${filename}.encrypted"

