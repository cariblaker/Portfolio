//Cari Blaker
//CST240 Lab7 sockets

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>


void error(char *msg) {                             //if an error occurs, this funciton is called, calls "perror" with the message provided, and exits the program with the error code 1"
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[]) {
    int sock, length, fromlen, n;                   //declare variables for socket descriptor, length of socket structures, number of received/sent bytes, and two socket adress structures. the buffer is used for storing received messages
    struct sockaddr_in server;
    struct sockaddr_in from;
    char buf[1024];

    if (argc < 2) {                                 //checks for valid command line args (port #)
        fprintf(stderr, "ERROR, no port provided\n");
        exit(1);
    }

    sock = socket(AF_INET, SOCK_DGRAM, 0);          //create UDP socket
    if (sock < 0) {                                 //call error if socket() returned negative error value
        error("Opening socket");
    }

    length = sizeof(server);                        //length set to size of server structure. 
    memset(&server, 0, length);                     //memset used to set all bytes to 0
    server.sin_family = AF_INET;                    //server structure configured with address family, IP address and port number from command line arg
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(atoi(argv[1]));

    if (bind(sock, (struct sockaddr *)&server, length) < 0) {       //bind the socket to the address and prot number, error if fail
        error("Binding");
    }

    fromlen = sizeof(struct sockaddr_in);                            //set fromlen to size of sendng structure

    while (1) {
        n = recvfrom(sock, buf, 1024, 0, (struct sockaddr *)&from, &fromlen);               //receive messages
        if (n < 0) {
            error("recvfrom");                                                              //error if not
        }

        write(1, "Received a datagram: ", 21);                                              //output to screen this message and the messae received
        write(1, buf, n);

        n = sendto(sock, "Got your message\n", 17, 0, (struct sockaddr *)&from, fromlen);   //after message is received, confirm reception back to sender
        if (n < 0) {                                                                           //error if that doesn't work'
            error("sendto");
        }
    }

    return 0;
}

