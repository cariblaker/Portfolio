//Cari Blaker
//CST240 Lab6

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int modular_exponentiation(int base, int exponent, int modulus)
{
    int result = 1;

    for (int i = 0; i < exponent; i++)
        result = (result * base) % modulus;

    return result;
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        printf("Insufficient arguments provided.\n");
        printf("Usage: ./rsa_rev_a base exponent modulus\n");
        return 1;
    }

    int base = atoi(argv[1]);
    int exponents[] = {2111222330, 2111222333, 2111222332, 2111222334, 2111222331, 2111222336,
                       2111222335, 2111222338, 2111222337, 2111222339};
    int modulus = atoi(argv[2]);

    clock_t start = clock();

    for (int i = 0; i < 10; i++) {
        int exponent = exponents[i];
        int result = modular_exponentiation(base, exponent, modulus);
        printf("Result %d: %d\n", i + 1, result);
    }

    clock_t end = clock();
    double execution_time = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Execution time: %.6f seconds\n", execution_time);

    return 0;
}

