//Cari Blaker
//Lab6 CST240

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct Node {                                       //struct for nodes in the list (integer)
    int data;
    struct Node* next;
};

struct LinkedList {
    struct Node* head;
    struct Node* tail;
    pthread_mutex_t lock;
};

void makeList(struct LinkedList* list) {
    list->head = NULL;                                              //start out with null head & tail
    list->tail = NULL;
    pthread_mutex_init(&list->lock, NULL);                          //initialize the mutex object
}

void insertHead(struct LinkedList* list, int value) {               //adds a node to the front of the list
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = value;

    pthread_mutex_lock(&list->lock);                                //avoid race conditions by blocking the mutex

    if (list->head == NULL) {                                       
        list->head = newNode;                                       //if the list is empty, the new node is both the head and the tail
        list->tail = newNode;
        newNode->next = NULL;
    } else {
        newNode->next = list->head;
        list->head = newNode;
    }

    pthread_mutex_unlock(&list->lock);
}

void insertTail(struct LinkedList* list, int value) {                   //
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = value;

    pthread_mutex_lock(&list->lock);

    if (list->tail == NULL) {                                       //if it's the only node in the list, it's the head & the tail'
        list->head = newNode;
        list->tail = newNode;
        newNode->next = NULL;
    } else {
        list->tail->next = newNode;                                 //otherwise, it's the tail's next & the new tail'
        list->tail = newNode;
    }

    pthread_mutex_unlock(&list->lock);
}

void deleteNode(struct LinkedList* list, int value) {
    pthread_mutex_lock(&list->lock);                                //lock the mutex again

    if (list->head == NULL) {                                       //unlock if the list is empty
        pthread_mutex_unlock(&list->lock);
        printf("Error: the list is empty");
    }

    else {
        struct Node* current = list->head;                              //
        struct Node* previous = NULL;

        while (current != NULL && current->data != value) {         //traverse until data is found
            previous = current;
            current = current->next;
        }

        if (current == NULL) {                                      //if end of list is reached, print error message
            pthread_mutex_unlock(&list->lock);
            printf("\nError: data not in list\n");
        }
        else {
            if (previous == NULL) {                                     //if the node to delete is the head
                list->head = current->next;
                if (list->head == NULL)
                    list->tail = NULL;
            } else {
                previous->next = current->next;                         //move node pointers to keep list in tact
                if (previous->next == NULL)
                    list->tail = previous;
            }

            free(current);                                              //delete  the proper node

            pthread_mutex_unlock(&list->lock);
        }
    }
}

void printList(struct LinkedList* list) {
    pthread_mutex_lock(&list->lock);        

    struct Node* current = list->head;                  //start at the head of the list

    printf("List: ");

    while (current != NULL) {                           //print and move through list until end
        printf("%d ", current->data);
        current = current->next;
    }

    printf("\n");

    pthread_mutex_unlock(&list->lock);
}

void* threadFunction(void* arg) {
    struct LinkedList* list = (struct LinkedList*)arg;

    for (int i = 0; i < 100; i++){
        insertTail(list, i);    
    }
    for (int i = 100; i > 0; i--){
        insertTail(list, i);
    }

    printList(list);                    //should print out 0 through 100 and back down to 1 again           

    deleteNode(list, 10);               //should skip the first 10

    printList(list);                

    insertHead(list, -99);              //should add -99 before the first 0 and skip 10
        
    printList(list);

    //insertTail(list, A);                 //try invalid , except it won't actually compile this way'

    //printList(list);
    deleteNode(list, -99);
    printList(list);

    for (int i = 0; i < 100; i++){
        deleteNode(list, i);
    }
    
    printList(list);

    for (int i = 100; i > 0; i--){
        deleteNode(list, i);
    }
    
    printList(list);
    

    return NULL;
}

int main() {
    struct LinkedList list;
    makeList(&list);

    pthread_t thread;
    pthread_create(&thread, NULL, threadFunction, (void*)&list);
    pthread_join(thread, NULL);

    return 0;
}

