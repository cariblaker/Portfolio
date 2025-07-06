//Cari Blaker
//CST240 Lab6
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

#define NUM_THREADS 10                                        //global thread amount

struct ThreadData {
    int base;
    int exponent;
    int modulus;
    int result;
};

void *modular_exponentiation(void *arg)                         //yay for void pointers 
{           
    struct ThreadData *data = (struct ThreadData *)arg; //convert void pointer back to thread data pointer type

    int result = 1;                                     //start it off at 1

    for (int i = 0; i < data->exponent; i++)            //perform the math]
        result = (result * data->base) % data->modulus;

    data->result = result;                              //assign the result to the specific data we're workin with'

    pthread_exit(NULL);                                 
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        printf("Insufficient arguments provided.\n");
        printf("Usage: ./rsa_rev_a base exponent modulus\n");
        return 1;
    }

    int base = atoi(argv[1]);                           //take the command line args, hard coded exponents
    int exponents[] = {2111222330, 2111222333, 2111222332, 2111222334, 2111222331, 2111222336,
                       2111222335, 2111222338, 2111222337, 2111222339};
    int modulus = atoi(argv[2]);

    clock_t start = clock();                                //start the timer

    pthread_t threads[NUM_THREADS];                         //make the pthreads
    struct ThreadData threadData[NUM_THREADS];              //use the struct 

    for (int i = 0; i < NUM_THREADS; i++) {                 //fill each struct with its appropriate exponent and shared base&modulus
        threadData[i].base = base;
        threadData[i].exponent = exponents[i];
        threadData[i].modulus = modulus;

        pthread_create(&threads[i], NULL, modular_exponentiation, (void *)&threadData[i]);      //create each thread with this info
    }

    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
        printf("Result %d: %d\n", i + 1, threadData[i].result);         //print the results in order
    }

    clock_t end = clock();
    double execution_time = (double)(end - start) / CLOCKS_PER_SEC;     //calculate time took & print

    printf("Execution time: %.6f seconds\n", execution_time);

    return 0;
}

