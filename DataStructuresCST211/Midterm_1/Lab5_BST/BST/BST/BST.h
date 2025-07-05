#pragma once
#include <iostream>
#include <functional>
#include "Node.h"
#include "Exception.h"

using std::cout;


template <typename U>
class BST
{
private:
	Node<U>* root;
	int height;

	Node<U>* Insert(Node<U>* current, const U data)					//private insert method uses recursion to add data to tree
	{
		if (current == nullptr)
		{
			current = new Node<U>;
			current->n_data = data;
		}

		else if (data < current->n_data)
			current->left = Insert(current->left, data);

		else if (data > current->n_data)
			current->right = Insert(current->right, data);

		else if (data == current->n_data)
			throw Exception("Error: the data is already in the list!");

		return current;

	}
	Node<U>* Delete(Node<U>* current, const U data)			//private delete method uses recursion if necessary to delete proper node and reorder tree
	{
		if (current == nullptr)
			throw Exception("Error: data is not in list");

		if (data < current->n_data)
			current->left = Delete(current->left, data);
		else if (data > current->n_data)
			current->right = Delete(current->right, data);
		else if (data == current->n_data)					//current is now the node to be deleted
		{
			//No child
			if (current->right == nullptr && current->left == nullptr)		//if it has no chilren, it can just be deleted.
			{
				delete current;
				current = nullptr;
			}
			//left child 
			else if (current->right == nullptr)								//if it only has a child to the left, it is replaced by it
			{
				Node<U>* temp = current;
				current = current->left;
				if (temp == root)
					root = current;
				delete temp;
			}
			//right child
			else if (current->left == nullptr)								//if it only has a child to the right, it is replaced by it
			{
				Node<U>* temp = current;
				current = current->right;
				if (temp == root)
					root = current;
				delete temp;
			}
			//two childrenses
			else
			{
				Node<U>* temp = current->left;						//chose to bring the furthest right value of its left branch up to replace the node to be deleted
				while (temp->right != nullptr)						//in the case where the node to be deleted has two children.
				{
					temp = temp->right;
				}
				current->n_data = temp->n_data;

				current->left = Delete(current->left, temp->n_data);

			}
		}

		return current;
	}
	void Purge(Node<U>* node)						//private purge deletes whole tree
	{
		if (node != nullptr)
		{
			Purge(node->left);
			Purge(node->right);
			delete node;
			node = nullptr;
		}
	}
	int Height(Node<U>* current, int curr_H)							//recursively finds height
	{
		if (current == nullptr)
			return curr_H;
		int left_curr = curr_H;
		int right_curr = curr_H;
		int leftHeight = Height(current->left, ++left_curr);
		int rightHeight = Height(current->right, ++right_curr);

		int height = (leftHeight > rightHeight) ? leftHeight : rightHeight;
		return height;
	}

public:
	BST() : root{ nullptr }, height{ NULL } {}			//default ctor
	BST(U data) : height{ 0 }							//parameterized ctor
	{
		Node<U>* temp = new Node<U>;
		temp->n_data = data;
		root = temp;
		root->left = nullptr;
		root->right = nullptr;
	}

	~BST()
	{
		Purge(root);
		root = nullptr;
	}

	BST(const BST& copy)								//copy constructor
	{
		root = new Node<U>(*copy.root);					//this should copy the whole list over, because of the node's copy xtor...
	}
	
	BST(BST&& move) noexcept							//move constructor
	{
		*this = move;
	}

	BST<U>& operator =(const BST& copy)					//copy assignment op =
	{
		root = new Node<U>(*copy.root);
		return *this;
	}

	BST<U>& operator =(const BST&& move) noexcept		//move assignment op =
	{
		*this = move;
		return *this;
	}

	Node<U>* getRoot()									//root node getter
	{
		return root;
	}

	void Insert(const U data)							//initial/public insert method is called to insert data, passes data to recursive method
	{                                               
		if (root == nullptr)
		{
			Node<U>* temp = new Node<U>;
			temp->n_data = data;
			root = temp;                                        
			root->left = nullptr;
			root->right = nullptr;
		}

		else
		{
			Insert(root, data);
		}
	}

	void Delete(U data)														//public delete method calls private delete if tree is not empty
	{
		if (root == nullptr)
			throw(Exception("Error: Tree is empty"));

		else
			Delete(root, data);

	}
	
	void Purge()									//public purge method calls private purge if tree is not empty
	{
		Node<U>* current = root;
		if (current == nullptr)
			throw(Exception("Error: list is already empty"));
		else
		{
			Purge(current);
			root = nullptr;
		}
	}

	void inOrder(void (*func)(U))
	{
		if (root == nullptr)
			throw(Exception("Error: list is empty"));
		else
			inOrder(root, func);
	}

	void inOrder(Node<U>* node, void (*Display)(U))
	{
		if (node == nullptr)
			return;

		inOrder(node->left, Display);

		Display(node->n_data);

		inOrder(node->right, Display);

		
	}

	void preOrder(void (*func)(U))
	{
		if (root == nullptr)
			throw(Exception("Error: Tree is empty"));
		else
			preOrder(root, func);
	}

	void preOrder(Node<U>* node, void (*Display)(U))
	{
		if (node == nullptr)
			return;
		
		Display(node->n_data);
		
		preOrder(node->left, Display);

		preOrder(node->right, Display);

	}

	void postOrder(void (*func)(U))
	{
		if (root == nullptr)
			throw(Exception("Error: the tree is empty"));

		else
			postOrder(root, func);
	}

	void postOrder(Node<U>* node, void (*Display)(U))
	{
		if (node == nullptr)
			return;

		postOrder(node->left, Display);
		postOrder(node->right, Display);
		Display(node->n_data);
	}

	void breadthFirst(void (*func)(U))
	{
		if (root == nullptr)
			throw(Exception("Error: list is empty"));

		else
			breadthFirst(root, func);
	}

	void breadthFirst(Node<U>* node, void (*Display)(U))
	{
		for (int i = 1; i <= Height(); i++)
		{
			currentLevel(node, i, Display);
		}
	}

	void currentLevel(Node<U>* current, int k, void (*Display)(U))
	{
		if (current == nullptr)
			return;

		if (k == 1)
			Display(current->n_data);
		else if (k > 1)
		{
			currentLevel(current->left, k - 1, Display);
			currentLevel(current->right, k - 1, Display);
		}
	}

	int Height()													//public height method calls private height if tree is not empty
	{
		if (root == nullptr)
			throw Exception("Error: the tree does not exist");

		int height = Height(root, 0);
		return height;
	}




};