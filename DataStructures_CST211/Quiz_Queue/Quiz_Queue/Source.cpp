#include<iostream>
using std::cout;
using std::cin;
using std::endl;
class Node {
public:
    int key;
    int data; // value
    Node* next;
    Node() {
        key = 0;
        data = 0;
        next = NULL;
    }
    Node(int k, int d) {
        key = k;
        data = d;
        next = NULL;
    }
};
class Queue
{
public:
    Node* front;
    Node* rear;

    Queue()
    {
        front = NULL;
        rear = NULL;
    }

    ~Queue()
    {
        while (front != NULL)
        {
            Node* temp = front;
            front = front->next;
            delete temp;
        }
    }

    bool isEmpty()
    {
        if (front == NULL && rear == NULL)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    bool checkIfNodeExist(int key)
    {
        Node* temp = front;
        bool exist = false;
        while (temp != NULL)
        {
            if (temp->key == key)
            {
                exist = true;
                break;
            }
            temp = temp->next;
        }
        return exist;
    }

    void enqueue(int key, int data)
    {
        if (isEmpty())
        {
            Node* temp = new Node;

            temp->key = key;
            temp->data = data;
            front = temp;
            rear = temp;
            cout << "Node ENQUEUED successfully" << endl;
        }
        else if (checkIfNodeExist(key))
        {
            cout << "Node already exist with this Key value."
                << "Enter different Key value" << endl;
        }
        else
        {
            Node* temp = new Node;
            temp->key = key;
            temp->data = data;
            rear->next = temp;
            rear = temp;
            cout << "Node  ENQUEUED successfully" << endl;
        }

    }
    Node* dequeue()
    {
        Node* temp = NULL;
        if (isEmpty())
        {
            cout << "Queue is Empty" << endl;
            return NULL;
        }
        else
        {
            if (front == rear)
            {
                temp = front;
                front = NULL;
                rear = NULL;
                return temp;
            }
            else
            {
                temp = front;
                front = front->next;
                return temp;
            }

        }
    }

    int count()
    {
        int count = 0;
        Node* temp = front;
        while (temp != NULL)
        {
            count++;
            temp = temp->next;
        }
        return count;
    }

    void display()
    {
        if (isEmpty())
        {
            cout << "Queue is Empty" << endl;
        }
        else
        {
            cout << "All values in the Queue are :" << endl;
            Node* temp = front;
            while (temp != NULL)
            {
                cout << "(" << temp->key << "," << temp->data << ")" << " -> ";
                temp = temp->next;
            }
            cout << endl;
        }

    }


};

int main() {
    Queue q;
    int option, key, data;

    do {
        cout << "What operation do you want to perform?"
            << "Select Option number. Enter 0 to exit." << endl;
        cout << "1. Enqueue()" << endl;
        cout << "2. Dequeue()" << endl;
        cout << "3. isEmpty()" << endl;
        cout << "4. count()" << endl;
        cout << "5. display()" << endl;
        cout << "6. Clear Screen" << endl << endl;
        cin >> option;

        
        Node* new_node;


        switch (option) {
        case 0:
            break;
        case 1:
            cout << "ENQUEUE Function Called -" << endl;
            cout << "Enter KEY and VALUE of NODE to ENQUEUE "
                << "in the Queue"
                << endl;
            cin >> key;
            cin >> data;
            q.enqueue(key, data);
            break;
        case 2:
            cout << "DEQUEUE Function Called - " << endl;
            new_node = q.dequeue();
            cout << "Dequeued Value is: (" << new_node->key << ","
                << new_node->data << ")";
            cout << endl;
            delete new_node;
            break;
        case 3:
            cout << "isEmpty Function Called - " << endl;
            if (q.isEmpty())
                cout << "Queue is Empty" << endl;
            else
                cout << "Queue is NOT Empty" << endl;
            break;
        case 4:
            cout << "Count Function Called - " << endl;
            cout << "No. of nodes in the Queue: " << q.count()
                << endl;
            break;
        case 5:
            cout << "Display Function Called - " << endl;
            q.display();
            cout << endl;
            break;

        case 6:
            system("cls");
            break;
        default:
            cout << "Enter Proper Option number " << endl;
        }

    } while (option != 0);

    return 0;
    } 