//Cari Blaker
//Lab2
//CST 240

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>


#define MAX_CHARS 100

//Caesar encryption, one character at a time
char caesar_encrypt(char ch, int key) {
    if (!isalpha(ch)) {
        return ch;
    }

    char base = isupper(ch) ? 'A' : 'a';            //converts to uppercase & encrypts using key
    return ((ch - base + key) % 26) + base;
}

// doublerail fence encryption
void railfence_encrypt(char *plaintext, char *ciphertext) {
    int len = strlen(plaintext);
    int j = 0;
    for (int i = 0; i < len - 1; i += 2) {          //kicks out the null terminator for the first half, so that the two rails become one line of text
        ciphertext[j++] = plaintext[i];
    }

    for (int i = 1; i < len; i += 2) {
        ciphertext[j++] = plaintext[i];
    }
    ciphertext[j] = '\0';
}

int main(int argc, char *argv[]) {
    FILE *input_file, *output_file;
    char plaintext[MAX_CHARS + 1], ciphertext[MAX_CHARS + 1];
    int key;

    // Check if the input file name is provided
    if (argc < 2) {
        printf("Usage: %s LAB2_sample.txt\n", argv[0]);
        return 1;
    }

    // Open the input file for reading
    input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        printf("Error: Cannot open file %s\n", argv[1]);
        return 1;
    }

    // Read the plaintext from the input file
    fgets(plaintext, MAX_CHARS + 1, input_file);

    // Close the input file
    fclose(input_file);

    // Get the Caesar key from the user
    do {
        printf("Enter Caesar key (0-25): ");
        scanf("%d", &key);
    } while (key < 0 || key > 25);

    // Apply Caesar encryption to the plaintext one character at a time
    int len = strlen(plaintext);
    for (int i = 0; i < len; i++) {
        plaintext[i] = toupper(plaintext[i]);
        plaintext[i] = caesar_encrypt(plaintext[i], key);
    }

    // Print the Caesar encrypted text
    printf("\nAfter Caesar with key of %d:\n%s\n", key, plaintext);

    // send caesar text to get double rail fenced
    railfence_encrypt(plaintext, ciphertext);

    // Print the double rail fence-d text
    printf("\nAfter Double Railfence and thus Final Answer in caps:\n%s\n", ciphertext);

    // Open the output file for writing
    output_file = fopen("cipher.txt", "w");
    if (output_file == NULL) {
        printf("Error: Cannot create file cipher.txt\n");
        return 1;
    }

    // Write the Railfence 2 encrypted text to the output file
    fprintf(output_file, "%s", ciphertext);

    // Close the output file
    fclose(output_file);

    return 0;
}

