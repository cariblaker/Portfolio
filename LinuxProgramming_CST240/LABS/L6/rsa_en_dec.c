#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Cari Blaker
//CST240 Lab6

int main(int argc, char *argv[])
{
    if (argc < 4) {
        printf("Insufficient arguments provided.\n");
        printf("Usage: ./rsa_en_dec.c base exponent modulus\n");
        return 1;
    }

    int base = atoi(argv[1]);
    int exponent = atoi(argv[2]);
    int modulus = atoi(argv[3]);
    int result = 1;

    clock_t start = clock();

    for (int i = 0; i < exponent; i++)
        result = (result * base) % modulus;

    clock_t end = clock();
    double execution_time = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Result is %d\n", result);
    printf("Execution time: %.6f seconds\n", execution_time);

    return 0;
}

