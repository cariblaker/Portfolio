#include <stdio.h>

int main() {
    FILE *in_file, *out_file;
    char buffer[1024];
    size_t bytes_read;

    in_file = fopen("HELLO.out", "rb");         //open input file, otherwise error
    if (in_file == NULL){
        perror("Error opening input file");
        return 1;
    }

    out_file = fopen("AGOOD.bin", "wb");        //open output file, otherwise error
    if (out_file == NULL){
        perror("Error opening output file");
        return 1;    
    }

    while ((bytes_read = fread(buffer, 1, sizeof(buffer), in_file)) > 0) {  //read from input file until done, and write to output file
        fwrite(buffer, 1, bytes_read, out_file);    
    }

    fclose(in_file);
    fclose(out_file);

    return 0;
}
