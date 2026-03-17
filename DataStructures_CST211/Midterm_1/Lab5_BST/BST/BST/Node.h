#pragma once
//Cari Blaker
//Lab 5
//02/14/23

#ifndef NODETEMPLATE_H
#define NODETEMPLATE_H

#include <string>
using std::string;
#include <iostream>
using std::cout;
using std::cin;
using std::endl;

template<typename T>class Node {
   template <typename T> friend class List;
   template <typename U> friend class BST;

private:
    T n_data;
    Node<T>* right;
    Node<T>* left;
    Node<T>* parent;

public:
    Node();
    Node(const Node& copy);
    Node(Node&& move) noexcept;
    Node(const T data);
    Node(const T data, Node<T>* next, Node<T>* prev);
    ~Node() = default;

    Node<T>& operator=(const Node& copy);
    Node<T>& operator=(Node&& copy) noexcept;

    //T& Value() noexcept;
    T Value();
    void Value(const T data);

    Node<T>* Next() noexcept;
    Node<T>* Next() const noexcept;
    Node<T>* Previous() noexcept;
    Node<T>* Previous() const noexcept;
    void Next(Node<T>* const next) noexcept;
    void Previous(Node<T>* const previous) noexcept;
};

template <typename T>
Node<T>::Node() : right(nullptr), left(nullptr) { }        //default constructor


template <typename T>                       //parameterized constructor
Node<T>::Node(const T data) : n_data(data), right(nullptr), left(nullptr) { }

template <typename T>
Node<T>::Node(const Node& copy)             //copy constructor
{
    n_data = copy.n_data;
    if (copy.left != nullptr)
        left = new Node(*copy.left);
    if (copy.right != nullptr)
        right = new Node(*copy.right);
}

template <typename T>
Node<T>::Node(Node&& move) noexcept         //move constructor
{
    *this = move;
}

template <typename T>
Node<T>::Node(const T data, Node<T>* next, Node<T>* prev)       //second parameterized constructor
{
    n_data = data;
    right = next;
    left = prev;
}

template <typename T>
Node<T>& Node<T>::operator=(const Node& copy)           //copy assignment
{
    n_data = copy.n_data;
    right = copy.right;
    left = copy.left;
    return *this;
}

template <typename T>
Node<T>& Node<T>::operator=(Node&& move) noexcept       //move assignment
{
    *this = move;
    return *this;
}

//template <typename T>
//T& Node<T>::Value() noexcept
//{
//    return &n_data;                 //data address getter
//}

template <typename T>
T Node<T>::Value()
{
    return n_data;                  //data value getter
}

template <typename T>
void Node<T>::Value(const T data)
{
    n_data = data;                               //data setter
}

template <typename T>
Node<T>* Node<T>::Next() noexcept               //next node pointer getter
{
    return right;
}

template <typename T>
Node<T>* Node<T>::Next() const noexcept
{
    return right;                            //const next node pointer getter
}

template <typename T>
Node<T>* Node<T>::Previous() noexcept
{
    return left;                            //previous node pointer getter
}

template <typename T>
Node<T>* Node<T>::Previous() const noexcept
{
    return left;                                            //const previous node pointer getter
}

template <typename T>
void Node<T>::Next(Node<T>* const next) noexcept            //next pointer setter
{
    right = next;
}

template <typename T>
void Node<T>::Previous(Node<T>* const previous) noexcept    //previous pointer setter
{
    left = previous;
}

#endif //NODE_TEMPLATE_H
