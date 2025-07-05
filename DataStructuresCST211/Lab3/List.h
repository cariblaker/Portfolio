//Cari Blaker
//Lab 3
//02/02/23

#ifndef LISTTEMPLATE_H
#define LISTTEMPLATE_H

#include <string>
using std::string;

#include <iostream>
using std::cout;
using std::cin;
using std::endl;
using std::move;

#include "Node.h"
#include "Exception.h"
#include "Stack.h"

template<typename T>class List {
    template <typename U> friend class Stack;
private:
    Node<T>* l_head;
    Node<T>* l_tail;
    int l_count;
public:
    List();
    List(const T data);
    List(const List& copy);
    List(List&& move) noexcept;
    ~List();

    List& operator=(const List& copy);
    List& operator=(List&& move) noexcept;
    explicit operator bool() const;

    void Append(const T data);
    void Prepend(const T data);
    void RemoveLast();
    void RemoveFirst();
    void Extract(const T data);
    void InsertAfter(const T data, const T after);
    void InsertBefore(const T data, const T before);
    void Purge() noexcept;

    T& Last(); 
    T Last() const;
    T& First();
    T First() const;

    Node<T>* getHead();
    Node<T>* getTail();
    bool isEmpty() const noexcept;
    size_t Size() const noexcept;
    bool operator==(const List<T>& rhs) const noexcept;
};

template <typename T>
List<T>::List() : l_head(nullptr), l_tail(nullptr), l_count(0) { }      //default constructor

template <typename T>
List<T>::List(const T data)                         //parameterized constructor
{
    Node<T>* temp = new Node<T>;                    //make a new node and write the data to the node
    temp->n_data = data;
    l_head = temp;
    l_tail = temp;                                  //the only node in the list is both the head and the tail at this point.
    l_count = 1;                                    //one node, one count
}

template <typename T>
List<T>::List(const List& copy)                     //copy constructor
{
    Node<T>* travel = copy.l_head;
    while (travel != nullptr) 
    {
        this->Append(travel->n_data);
        travel = travel->next_ptr;
    }
 }

template <typename T>
List<T>::List(List&& move) noexcept                 //move constructor
{
    *this = move;
}

template <typename T>                                //destructor
List<T>::~List()
{
    Purge();
}

template <typename T>
List<T>& List<T>::operator=(const List& copy)                //copy assignment operator
{
    Node<T>* travel = new Node<T>;
    travel = copy.l_head;
    while (travel != nullptr)
    {
        this->Append(travel->n_data);
        travel = travel->next_ptr;
    }
    l_count = copy.l_count;
    return *this;
}

template <typename T>
List<T>& List<T>::operator=(List&& move) noexcept           //move assignment operator
{
    *this = move;
    return *this;
}

template <typename T>
List<T>::operator bool() const                              //True if list is empty, else false...
{
    bool pass;
    if (l_count == 0)
        pass = 1;
    else
        pass = 0;

    return pass;                                            
}

template <typename T>               
void List<T>::Append(const T data)                                          //add a node to the end of the list
{
    Node<T>* temp = new Node<T>;
    temp->n_data = data;                                                    //data goes into new node
    if (l_head != nullptr && l_tail != nullptr)
    {
        temp->prev_ptr = l_tail;                                            //the new node's previous pointer is the current tail
        l_tail->next_ptr = temp;                                            //the current tail's next pointer is the new node
        l_tail = temp;                                                      //the new node becomes the tail
        l_count++;
    }
    else
    {
        l_tail = temp;
        l_head = temp;
        l_count++;
    }
}

template <typename T>
void List<T>::Prepend(const T data)                                     //add a node to the beginning of the list
{
    Node<T>* temp = new Node<T>;
    temp->n_data = data;                                                //data goes into the new node
    if (l_head != nullptr && l_tail != nullptr)
    {
        temp->next_ptr = l_head;                                        //the new node's next pointer is the current head
        l_head->prev_ptr = temp;                                        //the current head's previous pointer is the new node
        l_head = temp;                                                  //new node becomes the head
        l_count++;
    }
    else
    {
        l_tail = temp;
        l_head = temp;
        l_count++;
    }
}

template <typename T>
void List<T>::RemoveLast()
{
    Node<T>* temp = l_tail;                                             //temp holds the node to be deleted
    l_tail->prev_ptr = l_tail;                                          //make the previous node the tail
    l_tail->next_ptr = nullptr;                                         //make the new tail's next null
    delete temp;                                                        //delete the old tail
    l_count--;
}

template <typename T>
void List<T>::RemoveFirst()
{
    Node<T>* temp = l_head;                                            //temp holds node to be deleted
    l_head->next_ptr = l_head;                                         //make next node the new head
    l_head->prev_ptr = nullptr;                                        //make the new head's prev null
    delete temp;                                                       //delete the old head
    l_count--;
}

template <typename T>
void List<T>::Extract(const T data)                                    //delete a specific node
{
    if (l_head == nullptr)                                             //if the list is empty
    {
        throw Exception("Error! The list is empty");
    }
    else if (l_head->n_data == data)                                    //if the head is the node to be deleted
    {
        Node<T>* trail = l_head;
        l_head = l_head->next_ptr;
        delete trail;
        l_count--;
        if (l_head == nullptr)                                          //if that was the only node in the list, make sure the tail is adjusted properly
            l_tail = nullptr;
    }
    else
    {                                                                   //if there's more than one node in the list
        Node<T>* traverse = l_head;
        Node<T>* trail = nullptr;
        while (traverse != nullptr && traverse->n_data != data)
        {
            trail = traverse;
            traverse = traverse->next_ptr;
        }
        if (traverse == nullptr)
        {
            throw Exception("Error! The data is not in the list");
        }
        else
        {
            trail->next_ptr = traverse->next_ptr;                           //no matter what, trail's next is now traverse's next
            if (trail->next_ptr == nullptr)                                 //if deleting last node in the list, just need to label the new tail
            {
                l_tail = trail;
                l_tail->next_ptr = nullptr;
            }
                                //assign correct previous pointer
            l_tail->prev_ptr = traverse->prev_ptr;
            traverse->prev_ptr = nullptr;
            traverse->next_ptr = nullptr;
            delete traverse;                                                //delete correct node
            l_count--;                                                      //and our count decreases
        }
    }
}

template <typename T>                               
void List<T>::InsertAfter(const T data, const T after)                      //Inserts a node after the "after"
{
    if (l_head == nullptr)                                                  //if the list is empty
        throw Exception("Error--the list is empty!");
    else if (l_tail->n_data == after)                                       //if the data should be last in the list
    {
        Append(data);
    }
    else
    {
        Node<T>* temp_new = new Node<T>;
        temp_new->n_data = data;
        Node<T>* traverse = l_head;
        while (traverse != nullptr && traverse->n_data != after)
        {
            traverse = traverse->next_ptr;
        }
        if (traverse == nullptr)
            throw Exception("Error: data given does not match a node in the list");
        else
        {
            Node<T>* temp_next = traverse->next_ptr;                                //@this point, traverse is the node to insert after
            temp_new->next_ptr = temp_next;
            temp_new->prev_ptr = traverse;
            traverse->next_ptr = temp_new;
            temp_next->prev_ptr = temp_new;
            l_count++;
        }
    }
}


template <typename T>
void List<T>::InsertBefore(const T data, const T before)                    //inserts a node before the "before"
{
    if (l_head == nullptr)                                                  //if the list is empty
        throw Exception("Error--the list is empty!");
    else if (l_head->n_data == before)                                      //if the data should be second in the list
    {
        Prepend(data);
    }
    else
    {
        Node<T>* temp_new = new Node<T>;
        temp_new->n_data = data;
        Node<T>* traverse = l_head->next_ptr;
        while (traverse != nullptr && traverse->n_data != before)
        {
            traverse = traverse->next_ptr;
        }
        if (traverse == nullptr)
            throw Exception("Error: data given does not match a node in the list");

        Node<T>* temp_prev = traverse->prev_ptr;                                //@this point, traverse is the node to insert before
        temp_new->prev_ptr = temp_prev;
        temp_new->next_ptr = traverse;
        traverse->prev_ptr = temp_new;
        temp_prev->next_ptr = temp_new;
        l_count++;
    }
}

template <typename T>
void List<T>::Purge() noexcept                              //deletes the entire list
{
    Node<T>* traverse = l_head;
    Node<T>* traverse_next = l_head;

    if (traverse == nullptr)                                //if there is no list, throw exception
    {
        throw Exception("Error: List is empty!");
    }
    else if (traverse_next == nullptr)                      //if there is one node, delete it
    {
        delete traverse;
        l_count--;
    }
    else                                                    //if the list has more than one item
    {
        if (traverse_next->next_ptr != nullptr)             //if not at the end of the list...
        {
            while (traverse_next->next_ptr != nullptr)
            {
                traverse_next = traverse->next_ptr;         //set 'traverse_next' to point to the next node

                delete traverse;                            //delete the current node

                traverse = traverse_next;                   //set the 'traverse' pointer to the next node
                l_count--;
            }

            delete traverse;                                //at end of list, delete the final node
            l_count--;
        }

        else                                                //already at the end of the list...
        {
            delete traverse;                                //delete the one node
            l_count--;
        }
    }
    l_head = nullptr;
    l_tail = nullptr;

    if (l_count != 0)
        throw Exception("Error--the count is not at 0, even though the whole list should have been deleted.");
}

template <typename T>
T& List<T>::Last()                                                  //returns the data of the last node
{
    if (l_head == nullptr)
        throw Exception("Error! The list is empty.");
    return l_tail->n_data;
}

template <typename T>
T List<T>::Last() const                                             //returns the data of the last node
{
    if (l_head == nullptr)
        throw Exception("Error! The list is empty.");
    return l_tail->n_data;
}

template <typename T>
T& List<T>::First()                                                 //returns the data of the first node
{
    if (l_head == nullptr)
        throw Exception("Error! The list is empty.");
    return l_head->n_data;
}

template <typename T>
T List<T>::First() const                                            //returns the data of the first node
{
    if (l_head == nullptr)
        throw Exception("Error! The list is empty.");
    return l_head->data;
}

template <typename T>
Node<T>* List<T>::getHead()                                         //returns the head pointer
{
    return l_head;
}

template <typename T>
Node<T>* List<T>::getTail()                                         //returns the tail pointer
{
    return l_tail;
}

template <typename T>
bool List<T>::isEmpty() const noexcept                              //returns 1 if list is empty and 0 if not
{
    bool pass = (l_count == 0) ? true : false;
    return pass;
}

template <typename T>
size_t List<T>::Size() const noexcept                               //returns the size of the list
{
    return l_count;
}

template <typename T>
bool List<T>::operator==(const List<T>& rhs) const noexcept         //== operator
{
    bool isTrue;
    if (rhs == *this)
        isTrue = true;
    else
        isTrue = false;
    
    return isTrue;
}

#endif //LIST_TEMPLATE_H
