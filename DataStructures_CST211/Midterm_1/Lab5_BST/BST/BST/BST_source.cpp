//Cari Blaker
//Lab 5
//02/12/23
#include <iostream>
#include <crtdbg.h>
#include <conio.h>
#include <string>
#include "BST.h"

using std::string;
using std::cout;
using std::cin;
using std::endl;

#define _CRT_SECURE_NO_WARNINGS
#define _CRTDBG_MAP_ALLOC

// Strings to test
const string NAMES[] = { "Kyle", "Brit", "Seth", "Alex", "Josh", "Kian",
"Kate", "Terry", "Ann", "Elaine", "Stephanie", "Wanda", "Oscar", "Oliver", "Tobey" };

const string INORDERCPLX[] = { "Alex", "Ann", "Brit", "Elaine", "Josh", "Kate", "Kian", 
"Kyle", "Oliver", "Oscar", "Seth", "Stephanie", "Terry", "Tobey", "Wanda" };

const string PREORDERCPLX[] = { "Kyle", "Brit", "Alex", "Ann", "Josh", "Elaine", "Kian",
"Kate", "Seth", "Oscar", "Oliver", "Terry", "Stephanie", "Wanda", "Tobey" };

const string POSTORDERCPLX[] = { "Ann", "Alex", "Elaine", "Kate", "Kian", "Josh", "Brit",
 "Oliver", "Oscar", "Stephanie", "Tobey", "Wanda", "Terry", "Seth", "Kyle" };

const string BREADTHCPLX[] = { "Kyle", "Brit", "Seth", "Alex", "Josh", "Oscar", "Terry",
  "Ann", "Elaine", "Kian", "Oliver", "Stephanie", "Wanda", "Kate", "Toby" };

//numbers to test
const int NUMS[] = { 44, 12, 37, 99, 18, 88, 4, 100, 98, 6 };
const int ORDERED_NUMS[] = { 4, 6, 12, 18, 37, 44, 88, 98, 99, 100 };
const int PRE_NUMS[] = { 44, 12, 4, 6, 37, 18, 99, 88, 98, 100 };
const int POST_NUMS[] = { 6, 4, 18, 37, 12, 98, 88, 100, 99, 44 };
const int BREADTH_NUMS[] = { 44, 12, 99, 4, 37, 88, 100, 6, 18, 98 };

const int NUM_NUMS = 10;
const int NUM_NAMES = 15;


typedef bool(*FunctionPointer)();					// Define a function pointer type

template <typename U>
void Display(U data)								//display function is passed to all traversal methods
{
	cout << data << endl;
}


bool test_default_ctor()						//tests default constructor using Height()
{
	bool pass = false;

	BST<int> BST_test;
	
	try
	{
		BST_test.Height();
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Default ctor test ";

	return pass;
}


bool test_param_ctor()								//tests param ctor, using height function
{
	bool pass = true;
	int h;
	BST<int> tree(10);

	try {h = tree.Height(); }
	catch (Exception& exception)
	{
		pass = false;
	}

	if (h != 1)
		pass = false;

	cout << "Parameterize constructor test ";

	return pass;
}

//tests copy constructor
bool test_copy_ctor()								//tests copy ctor with insert, copy(), getRoot(), and Height
{
	bool pass = true;

	BST<int> test_BST;
	for (int i = 0; i < NUM_NUMS; ++i)
		test_BST.Insert(NUMS[i]);

	BST<int> BST_test(test_BST);

	Node<int>* BT = BST_test.getRoot();
	Node<int>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;

	for (int i = 0; i < test_BST.Height(); i++)
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value() || BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Copy constructor test ";

	return pass;
}

BST<int> ReturnIntBST();

bool test_move_ctor()								//tests the move constructor by ensuring a moved BST and a BST with the same value created
													//within the testing function end up with the same values
{
	bool pass = true;

	BST<int> test_BST(ReturnIntBST());
	BST<int> BST_test;

	// Check data integrity
	for (int i = 0; i < NUM_NUMS; i++)
	{
		BST_test.Insert(NUMS[i]);
	}

	Node<int>* BT= BST_test.getRoot();
	Node<int>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;
	
	for (int i = 0; i < test_BST.Height(); i++)
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value() || BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Move ctor test ";

	return pass;
}

bool test_op_equal()									//tests op =
{
	bool pass = true;

	BST<int> test_BST;
	for (int i = 0; i < NUM_NUMS; ++i)
	{
		test_BST.Insert(NUMS[i]);
	}

	BST<int> BST_test;
	BST_test = test_BST;									//	Op =

	Node<int>* BT = BST_test.getRoot();
	Node<int>* TB = test_BST.getRoot();

	// Check data integrity
	for (int i = 0; i < NUM_NUMS; ++i)
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value() || BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Op equals test ";

	return pass;
}

bool test_move_op_equal()							//tests move op = by moving an =ing a BST, an comparing to the exact
{													//same BST create within this function.
	bool pass = true;

	BST<int> test_BST;
	test_BST = ReturnIntBST();							//Op =

	BST<int> BST_test;

	// Check data integrity
	for (int i = 0; i < NUM_NUMS; i++)
	{
		BST_test.Insert(NUMS[i]);
	}

	Node<int>* BT = BST_test.getRoot();
	Node<int>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())							//tests root value
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;

	for (int i = 0; i < test_BST.Height(); i++)
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Value() != TB->Value())
			pass = false;

		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Move operator = test ";

	return pass;
}

bool test_Height_empty()				//tests the Height() function with an empty BST
{
	bool pass = false;

	BST<int> emptyBST;

	try 
	{
		emptyBST.Height();
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Height on empty test ";
	return pass;

}

bool test_Height()						//tests Height with integers
{
	bool pass = false;

	BST<int> tree;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	int h = tree.Height();

	if (h == 4)									
		pass = true;							

	cout << "Height with integers test ";

	return pass;

}

bool test_delete_empty()							//tests deleting on empty BST
{
	bool pass = false;

	BST<int> emptyBST;

	try
	{
		emptyBST.Delete(5);
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Empty BST Delete test ";

	return pass;

}

bool test_delete_data_DNE()								//tests deleting data that's not in a BST with integers
{
	bool pass = false;
	BST<int> tree;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	try
	{
		tree.Delete(5);
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Deleting non-existent integer test ";

	return pass;
}

bool valid_delete_test()					//Tests deleting the ROOT!
{
	bool pass = true;
	BST<int> tree;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	try
	{
		tree.Delete(44);					//deleting the root
	}
											//the new root's value should be 37

	catch (Exception& exception)			//if an exception is thrown, something's wrong
	{
		pass = false;
	}

	if (tree.getRoot()->Value() != 37)
		pass = false;

	cout << "Delete root integer test ";


	return pass;
}

bool test_purge_empty()									//tests the Purge() function with an empty tree
{
	bool pass = false;
	BST<int> tree;

	try {
		tree.Purge();
	}
	catch (Exception& except)
	{
		pass = true;
	}

	cout << "Purge empty BST test ";

	return pass;
}

bool test_purge()									//tests purge with a 3 height tree of ints
{
	bool pass = true;
	BST<int> tree;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	try {
		tree.Purge();
	}

	catch (Exception& e)
	{
		pass = false;								//if any exception is thrown, there is an error
	}

	if (tree.getRoot() != nullptr)
		pass = false;

	cout << "Purge integer tree test ";

	return pass;
}

bool test_copy_ctor_complex()						//tests the copy constructor with strings
{
	bool pass = true;

	BST<string> test_BST;
	for (int i = 0; i < NUM_NAMES; ++i)
		test_BST.Insert(NAMES[i]);

	BST<string> BST_test(test_BST);

	Node<string>* BT = BST_test.getRoot();
	Node<string>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;

	for (int i = 0; i < test_BST.Height(); i++)
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value() || BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Copy constructor w/ strings test ";

	return pass;
}

BST<string> ReturnStrBST();

bool test_move_ctor_complex()								//tests the move constructor with strings
{
	bool pass = true;

	BST<string> BST_test{ ReturnStrBST() };

	BST<string> test_BST;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		test_BST.Insert(NAMES[i]);
	}

	Node<string>* BT = BST_test.getRoot();
	Node<string>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;

	for (int i = 0; i < test_BST.Height(); i++)				//doesn't traverse the whole tree, but it checks some values
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Value() != TB->Value())
			pass = false;
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Move ctor test complex ";

	return pass;
}

bool test_op_equal_complex()						//tests op = with strings
{
	bool pass = true;

	BST<string> test_BST;
	for (int i = 0; i < NUM_NAMES; ++i)
	{
		test_BST.Insert(NAMES[i]);
	}

	BST<string> BST_test;
	BST_test = test_BST;									//	Op =

	Node<string>* BT = BST_test.getRoot();
	Node<string>* TB = test_BST.getRoot();

	// Check data integrity
	for (int i = 0; i < test_BST.Height(); ++i)				//doesn't test every value, but definitely filters through some
	{
		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Value() != TB->Value())
			pass = false;
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Op equals test complex ";

	return pass;
}

bool test_move_op_equal_complex()							//tests move op = with strings
{
	bool pass = true;

	BST<string> test_BST;
	test_BST = ReturnStrBST();								//Op =

	BST<string> BST_test;

	// Check data integrity
	for (int i = 0; i < NUM_NAMES; i++)
	{
		BST_test.Insert(NAMES[i]);
	}

	Node<string>* BT = BST_test.getRoot();
	Node<string>* TB = test_BST.getRoot();

	if (BT->Value() != TB->Value())							//tests root value
		pass = false;

	if (test_BST.Height() != BST_test.Height())
		pass = false;

	for (int i = 0; i < test_BST.Height(); i++)				//decided to cycle through other branch for testing
	{
		if (BT->Previous() != nullptr)
		{
			BT = BT->Previous();
			TB = TB->Previous();
		}
		if (BT->Value() != TB->Value())
			pass = false;

		if (BT->Next() != nullptr)
		{
			BT = BT->Next();
			TB = TB->Next();
		}
		if (BT->Value() != TB->Value())
			pass = false;
	}

	cout << "Move operator = test complex ";

	return pass;
}

bool test_height_complex()						//tests Height() function with strings
{
	bool pass = true;
	BST<string> tree;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		tree.Insert(NAMES[i]);
	}

	try {
		int h = tree.Height();
	}
	catch (Exception& e)
	{
		pass = false;
	}

	if (tree.Height() != 5)
		pass = false;

	cout << "Tree Height test complex ";

	return pass;
}

bool test_pre_empty()									//tests the preOrder function with an empty tree
{
	bool pass = false;
	BST<int> tree;

	try
	{
		tree.preOrder(Display);
	}
	catch (Exception& e)
	{
		pass = true;
	}

	cout << "preOrder empty tree test ";

	return pass;
}

bool test_post_empty()								//tests the postOrder function with an empty tree
{
	bool pass = false;
	BST<int> tree;

	try
	{
		tree.postOrder(Display);
	}
	catch (Exception& e)
	{
		pass = true;
	}

	cout << "postOrder empty tree test ";

	return pass;
}

bool test_inOrder_empty()								//tests the inOrder function with an empty tree
{
	bool pass = false;
	BST<int> tree;

	try
	{
		tree.inOrder(Display);
	}
	catch (Exception& e)
	{
		pass = true;
	}

	cout << "inOrder empty tree test ";

	return pass;
}

bool test_breadth_empty()								//tests the breadthFirst function with an empty tree
{
	bool pass = false;
	BST<int> tree;

	try
	{
		tree.breadthFirst(Display);
	}
	catch (Exception& e)
	{
		pass = true;
	}

	cout << "Breadth first empty tree test ";

	return pass;
}

bool test_preOrder()								//tests the preOrder function with an int tree
{
	BST<int> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	tree.preOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		cout << PRE_NUMS[i] << endl;
	}

	cout << ".. then the preorder test ";

	return pass;
}

bool test_preOrder_complex()								//tests the preOrder function with a string tree
{
	BST<string> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		tree.Insert(NAMES[i]);
	}

	tree.preOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		cout << PREORDERCPLX[i] << endl;
	}

	cout << ".. then the preorder complex test ";

	return pass;
}

bool test_postOrder()								//tests the postOrder function with an int tree
{
	BST<int> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	tree.postOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		cout << POST_NUMS[i] << endl;
	}

	cout << ".. then the preorder test ";

	return pass;
}

bool test_postOrder_complex()								//tests the postOrder function with a string tree
{
	BST<string> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		tree.Insert(NAMES[i]);
	}


	tree.postOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		cout << POSTORDERCPLX[i] << endl;
	}

	cout << ".. then the preorder complex test ";

	return pass;
}

bool test_inOrder()								//tests the  inOrder function with an int tree
{
	BST<int> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	tree.inOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		cout << ORDERED_NUMS[i] << endl;
	}

	cout << ".. then the preorder test ";

	return pass;
}

bool test_inOrder_complex()								//tests the inOrder function with a string tree
{
	BST<string> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		tree.Insert(NAMES[i]);
	}


	tree.inOrder(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		cout << INORDERCPLX[i] << endl;
	}

	cout << ".. then the in order complex test ";

	return pass;
}

bool test_breadth()								//tests the breadthFirst function with an int tree
{
	BST<int> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		tree.Insert(NUMS[i]);
	}

	tree.breadthFirst(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NUMS; i++)
	{
		cout << BREADTH_NUMS[i] << endl;
	}

	cout << ".. then the breadth first test ";

	return pass;
}

bool test_breadth_complex()								//tests the breadthFirst function with a string tree
{
	BST<string> tree;
	bool pass = true;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		tree.Insert(NAMES[i]);
	}


	tree.breadthFirst(Display);
	cout << "\nIf that list matches this list: " << endl;

	for (int i = 0; i < NUM_NAMES; i++)
	{
		cout << BREADTHCPLX[i] << endl;
	}

	cout << ".. then the breadth first complex test ";

	return pass;
}


// Array of test functions
FunctionPointer test_functions[] = { test_default_ctor, test_param_ctor, test_copy_ctor, test_move_ctor,
test_op_equal, test_move_op_equal, test_Height_empty, test_Height, test_delete_empty,
test_delete_data_DNE, valid_delete_test, test_purge_empty, test_purge, test_copy_ctor_complex,
test_move_ctor_complex, test_op_equal_complex, test_move_op_equal_complex, test_height_complex,
test_pre_empty, test_post_empty, test_inOrder_empty, test_breadth_empty, test_preOrder, test_preOrder_complex,
test_postOrder, test_postOrder_complex, test_inOrder, test_inOrder_complex, test_breadth, test_breadth_complex };


BST<int> ReturnIntBST()							//int BST creating func for move constructor
{
	BST<int> tempBST;
	for (int i = 0; i < NUM_NUMS; ++i)
		tempBST.Insert(NUMS[i]);

	return tempBST;
}


BST<string> ReturnStrBST()						//string BST creating func for move constructor
{
	BST<string> tempBST;
	for (int i = 0; i < NUM_NAMES; ++i)
		tempBST.Insert(NAMES[i]);
	return tempBST;
}




int main()
{
	
		_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);

		int failed_tests = 0;

		// Run the test functions
		for (FunctionPointer func : test_functions)
		{
			if (func())
			{
				cout << "passed" << endl;
			}
			else
			{
				failed_tests++;
				cout << "***** failed *****" << endl;
			}
		}

		if (failed_tests > 0)
			cout << endl << "You have " << failed_tests << " failed tests";
		else
			cout << endl << "All tests passed! Good job!";

		cout << endl;
		system("pause");
		cout << "Exiting..." << endl;

		return 0;
	
}



