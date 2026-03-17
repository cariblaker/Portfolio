//Cari Blaker
//Lab7 CST240

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

void error(char *msg)                       //error message function to be called if there is an error in program
{
    perror(msg);
    exit(1);
}                   

int main(int argc, char *argv[])
{
    int sock, length, n;                    //declare variables for socket descriptor, length of socket structures, number of received/sent bytes, two socket address structures, a pointer to the host structure, and a buffer for message storing
    struct sockaddr_in server, from;
    struct hostent *hp;
    char buffer[256];

    if (argc != 3)                          //either 2 command line arguments or usage message
    {
        fprintf(stderr, "Usage: %s server port\n", argv[0]);
        exit(1);
    }

    sock = socket(AF_INET, SOCK_DGRAM, 0);          //create UDP socket 
    if (sock < 0)
    {
        error("Opening socket");                    //or create error
    }

    hp = gethostbyname(argv[1]);                    //retrieve host information for specified server address or error
    if (hp == NULL)
    {
        error("Unknown host");
    }

    bzero((char *)&server, sizeof(server));         //sets all bytes of server structure to 0
    server.sin_family = AF_INET;                    //configure address family
    bcopy((char *)hp->h_addr, (char *)&server.sin_addr, hp->h_length);          //IP address configuration
    server.sin_port = htons(atoi(argv[2]));                                     //port number provided by command line

    length = sizeof(struct sockaddr_in);                                        //find length of the socket address structure

    printf("Please enter the message: ");                                       //message prompt
    bzero(buffer, 256);                                                         //clear buffer
    fgets(buffer, 255, stdin);                                                  //take message from user

    n = sendto(sock, buffer, strlen(buffer), 0, (struct sockaddr *)&server, length);        //send message to server
    if (n < 0)
    {
        error("Sendto");                                                                    //or error
    }

    n = recvfrom(sock, buffer, 256, 0, (struct sockaddr *)&from, &length);                  //wait to receive a response from te server
    if (n < 0)
    {
        error("recvfrom");                                                                  //or error
    }

    write(1, "Got an ack: ", 12);                           //print to screen
    write(1, buffer, n);                                    //print message received

    return 0;
}



