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
int read_key();
string read_file_name();

int main(){

    cout << "Welcome to the Caesar Cipher Program!" << endl;
    menu();

    cout << "Have a beautiful day!" << endl;
    return 0;
}

void menu(){
    int choice;
    cout << "Enter 1 to encrypt, 2 to decrypt, or 0 to exit the program:";
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

int read_key(){
    int key;
    cin >> key;
    return key;
}

string read_file_name(){
    string file_name;
    cin >> file_name;
    return file_name;
}