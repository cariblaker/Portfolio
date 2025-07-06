#!/usr/bin/env python3

#Cari Blaker
#CST240 Lab5  railfence encryption in Python

import sys

def encrypt(text, key):                                                 
    rail = [['\n' for i in range(len(text))] for j in range(key)]           #"key" rows, #of cols = # of characters in text. Give each element in list a new line char.
    direction = False
    row, col = 0, 0
    
    for i in range(len(text)):
        if (row == 0) or (row == key - 1):                                  #when we reach the top or bottom row, change direction for igzag
            direction = not direction
        
        rail[row][col] = text[i]                                            #assign character to its fence position
        col += 1                                                            #move to the next column
        
        if direction:
            row += 1                                                        #if we're moving down, increase the row'
        else:
            row -= 1                                                        #if we're moving up, decrease the row'
    
    encrypted_text = ''                                                     #establish string variable to hold encryption
    for i in range(key):                                                    #rows
        for j in range(len(text)):                                          #columns
            if rail[i][j] != '\n':                                          #ensures only actual characters are getting encrypted
                encrypted_text += rail[i][j]
    
    return encrypted_text

def rail_fence_encryption(key, filename):
    try:
        with open(filename, 'r') as file:                               #try opening file in read mode
            plaintext = file.read().replace('\n', '')                   #get rid of new lines, place in "plaintext' variable'"
        
        encrypted_text = encrypt(plaintext, key)                        
        
        encrypted_filename = filename.split('.')[0] + '_encrypted.txt'  #splits file name based on the period and returns the first element of the list returned. basically any filename can get sent and this will make a new name filename_encrypted.txt
         
        with open(encrypted_filename, 'w') as file:                     #open a new file in writemode with our new file name
            file.write(encrypted_text)
        
        print(f'Successfully encrypted the file. Encrypted text saved in {encrypted_filename}.')
    
    except FileNotFoundError:                                           #error message if the original read file could not be opened
        print(f'Error: File "{filename}" not found.')

if __name__ == '__main__':                  #script can be run as a submodule for another or on its own!
    if len(sys.argv) != 3:
        print('Usage: python railfence.py <key> <filename>')    #usage message if # of arguments are incrorrect
    else:
        key = int(sys.argv[1])                          #first command line arg is the key
        filename = sys.argv[2]                          #second command line arg is the file to be encrypted
        rail_fence_encryption(key, filename)            #don't even need a main function. Cool, python!'

