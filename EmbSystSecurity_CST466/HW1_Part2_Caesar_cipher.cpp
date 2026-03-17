#include <iostream>
#include <fstream>
#include <string>

using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::ifstream;
using std::ofstream;

void menu();
void encrypt();
void decrypt();
void autocrypt();
int read_key();
string read_file_name();
void countLetters(const string&, int[]);
char findMostCommonLetter(const int[]);

int main(){

    cout << "Welcome to the Caesar Cipher Program!" << endl;
    menu();

    cout << "Have a beautiful day!" << endl;
    return 0;
}

void menu(){
    int choice;
    cout << "Enter 1 to encrypt, 2 to decrypt, 3 for autocrypting, or 0 to exit the program: ";
    cin >> choice;

    switch(choice){
        case 0:
            return;
            break;
        case 1:
            encrypt();
            break;
        case 2:
            decrypt();
            break;
        case 3:
            autocrypt();
            break;
        default:
            cout << "Please enter one of the three given options." << endl;
            menu();
            break;
    }
    return;
}

void encrypt(){
    //prompt user for key
    cout << "Please enter the key you wish to use for encryption: ";
    int key = read_key();

    //prompt user for plaintext file name
    cout << "Please enter the name of the plaintext file you wish to encrypt:" << endl;
    string plaintext_file = read_file_name();

    //prompt user for encrypted file name
    cout << "Please enter the name of the file you wish to create for encrypted text: ";
    string encrypted_file = read_file_name();

    //open the input/plaintext file
    ifstream input_file(plaintext_file);
    if (!input_file.is_open()) {
        cout << "Error opening file " << plaintext_file << endl;
        cout << "Try again!" << endl;
        encrypt();
        return;
    }

    //create the output/encrypted text file
    ofstream output_file(encrypted_file);
    if (!output_file.is_open()) {
        cout << "Error creating file " << encrypted_file << endl;
        input_file.close();
        cout << "Try again!" << endl;
        encrypt();
        return;
    }

    //perform encryption by adding 'a' plus the key, and modulating by 26 to ensure alphabeticality
    //then add the encrypted character to the encrypted text file
    char ch;
    while (input_file.get(ch)) {
        if (isalpha(ch)) {
            if (islower(ch)) {
                ch = 'a' + (ch - 'a' + key) % 26;
            } else if (isupper(ch)) {
                ch = 'A' + (ch - 'A' + key) % 26;
            }
        }
        output_file << ch;
    }

    //close both files, recall the main menu
    input_file.close();
    output_file.close();
    cout << "Encryption completed. Encrypted file saved as " << encrypted_file << endl;
    menu();
    return;
}

void decrypt(){
    //prompt use for key
    cout << "Please enter the key you wish to use for decryption: ";
    int key = read_key();

    //prompt user for encrypted file name
    cout << "Please enter the name of the encrypted file you wish to decrypt:" << endl;
    string encrypted_file = read_file_name();

    //prompt user for name of file to create for plaintext decrypted
    cout << "Please enter the name of the file you wish to create for decrypted plaintext: ";
    string plaintext_file = read_file_name();

    //open encrypted input file
    ifstream inputFile(encrypted_file);
    if (!inputFile.is_open()) {
        cout << "Error opening file " << encrypted_file << endl;
        cout << "Try again!" << endl;
        decrypt();
        return;
    }

    ofstream outputFile(plaintext_file);
    if (!outputFile.is_open()) {
        cout << "Error creating file " << plaintext_file << endl;
        inputFile.close();
        cout << "Try again!" << endl;
        decrypt();
        return;
    }

    char ch;
    while (inputFile.get(ch)) {
        if (isalpha(ch)) {
            if (islower(ch)) {
                ch = 'a' + (ch - 'a' - key + 26) % 26;
            } else if (isupper(ch)) {
                ch = 'A' + (ch - 'A' - key + 26) % 26;
            }
        }
        outputFile << ch;
    }

    inputFile.close();
    outputFile.close();
    cout << "Decryption completed. Decrypted file saved as " << plaintext_file << endl;
    menu();
    return;
}

//autocrypt assumes that 'e' is the most common letter in the plaintext'
void autocrypt() {
    //prompt user for encrypted file name
    cout << "Please enter the name of the encrypted file you wish to decrypt:" << endl;
    string encrypted_file = read_file_name();

    //prompt user for name of file to create for plaintext decrypted
    cout << "Please enter the name of the file you wish to create for decrypted plaintext: ";
    string plaintext_file = read_file_name();

    // Open encrypted input file
    ifstream inputFile(encrypted_file);
    if (!inputFile.is_open()) {
        cout << "Error opening file " << encrypted_file << endl;
        cout << "Try again!" << endl;
        autocrypt();
        return;
    }

    // Open output file for writing decrypted plaintext
    ofstream outputFile(plaintext_file);
    if (!outputFile.is_open()) {
        cout << "Error creating file " << plaintext_file << endl;
        inputFile.close();
        cout << "Try again!" << endl;
        autocrypt();
        return;
    }

    // Read ciphertext from the input file
    string ciphertext;
    getline(inputFile, ciphertext);

    inputFile.close();

        // Perform automatic decryption assuming 'e' is the most common letter
    int letterCount[26] = {0};
    countLetters(ciphertext, letterCount);
    char mostCommonLetter = findMostCommonLetter(letterCount);
    // Calculate the key for decryption
    int key = mostCommonLetter - 'e';
    if (key < 0) {
        key += 26; // Ensure key is positive
    }

    // Decrypt the ciphertext
    string plaintext = ciphertext;
    for (char& c : plaintext) {
        if (isalpha(c)) {
            char base = isupper(c) ? 'A' : 'a';
            c = ((c - base - key + 26) % 26) + base;
        }
    }

    // write the plaintext to the output file
    outputFile << plaintext;

    // Close files and inform the user
    outputFile.close();
    cout << "Autocryption completed. Decrypted file saved as " << plaintext_file << endl;
    menu();
    return;
}


int read_key(){
    int key;
    cin >> key;
    return key;
}

// Function to count occurrences of each letter in a string
void countLetters(const string& text, int letterCount[]) {
    for (char c : text) {
        if (isalpha(c)) {
            char lowercase = tolower(c);
            letterCount[lowercase - 'a']++;
        }
    }
}

// Function to find the most common letter (assuming 'e')
char findMostCommonLetter(const int letterCount[]) {
    int maxCount = 0;
    char mostCommon = 'a';
    for (int i = 0; i < 26; i++) {
        if (letterCount[i] > maxCount) {
            maxCount = letterCount[i];
            mostCommon = 'a' + i;
        }
    }
    return mostCommon;
}

string read_file_name(){
    string file_name;
    cin >> file_name;
    return file_name;
}
