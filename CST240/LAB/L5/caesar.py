#!/usr/bin/env python3

#Cari Blaker
#CST240 Lab5 caesar encryption in Python

import sys

def caesar_encrypt(text, key):
    encrypted_text = ""
    for char in text:
        if char.islower():      #ignore uppercase characters
            encrypted_char = chr((ord(char) - ord('a') + key) % 26 + ord('a'))          #caesar encrytion & boundary fixes
            encrypted_text += encrypted_char            #add each character to the converted string
    return encrypted_text                               #return the string

def main():
    if len(sys.argv) != 3:                              #usage if imporper arguments were passed
        print("Usage: python caesar.py <key> <filename>")
        return

    key = int(sys.argv[1])                              #assign key variable as the first command line argument
    filename = sys.argv[2]                              #assig file as second command line argument

    try:                           #
        with open(filename, 'r') as file:               #open file in read mode
            text = file.read()                          #read the file into a "text" variable"
            encrypted_text = caesar_encrypt(text, key)  #call the encryption function and assign to encrypted text variable
            print("Encrypted text:")                    #print to console
            print(encrypted_text)
    except FileNotFoundError:                           #error message for unable to find file
        print(f"Error: File '{filename}' not found.")

if __name__ == "__main__":        #this allows this script to run as a submodule for another script, or on its own... neat!
    main()

