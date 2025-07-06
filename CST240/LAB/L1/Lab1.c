//Cari Blaker
//Lab1 CST240
//4/12/23

#include <stdio.h>
#include <stdlib.h>

int is_prime(int n) {
    if (n <= 1) {
        return 0;
    }

    for (int i = 2; i <= n/2; i++) {
        if (n % i == 0) {
            return 0;
        }
    }

    return 1;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Gotta send an integer to get prime determination! %s \n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    if (argv[1] < 0){
        printf("Sorry, this program only works for integers >= 0");
    }
    else {
        printf("Input number: %d\n", n);

        if (is_prime(n)) {
            printf("%d is prime!\n", n);
        } else {
            printf("%d is NOT prime!\n", n);
        }
    }
    return 0;
}

