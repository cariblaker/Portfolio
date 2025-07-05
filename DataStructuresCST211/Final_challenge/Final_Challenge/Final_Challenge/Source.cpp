//Cari Blaker
//Lab 4
//02/09/23
#include <iostream>
#include <crtdbg.h>
#include <conio.h>
#include <string>
#include "Array.h"
#include "Exception.h"
#include "Circular_Q.h"

using std::string;
using std::cout;
using std::cin;
using std::endl;

#define _CRT_SECURE_NO_WARNINGS
#define _CRTDBG_MAP_ALLOC

// Strings to test
const string NAMES[] = { "Brit", "Josh", "Kyle", "Seth", "Alex",  "Kian",
"Kate", "Terry", "Ann", "Elaine" };
const string SORTED_NAMES[] = { "Brit", "Josh", "Kyle", "Seth", "Terry" };
const string TOO_MANY_NAMES[] = { "Kyle", "Brit", "Seth", "Alex", "Josh", "Kian",
"Kate", "Terry", "Ann", "Elaine", "Stephanie", "Wanda", "Oscar", "Oliver", "Tobey" };

const int NUM_SORTED_NAMES = 5;
const int NUM_NAMES = 10;
const int TOO_MANY_NUM = 15;
const int NUM_SIZE = 10;

typedef bool(*FunctionPointer)();  // Define a function pointer type


// Test function declaration
bool test_default_ctor()						//tests default constructor and getSize, front, and back with empty queue
{
	bool pass = true;

	Queue<int> queue_test;

	if (queue_test.getSize() != 0 || queue_test.getFront() != -1 || queue_test.getBack() != -1)
		pass = false;

	cout << "Default ctor test ";

	return pass;
}

//tests copy constructor
bool test_copy_ctor()
{
	bool pass = true;

	Queue<int> test_Q;
	for (int i = 0; i < NUM_SIZE; ++i)
		test_Q.Enqueue(i);

	Queue<int> Q_test(test_Q);

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (Q_test.Peek() != test_Q.Peek())
			pass = false;
		Q_test.Dequeue();
		test_Q.Dequeue();
	}
	
	cout << "Copy constructor test ";

	return pass;
}

Queue<int> ReturnIntQ();

bool test_move_ctor()								//tests the move constructor
{
	bool pass = true;

	Queue<int> test_Q(ReturnIntQ());

	// Check data integrity
	for (int i = 0; i < 10; i++)
	{
		if (i != test_Q.Peek() || i != test_Q.getFront())
			pass = false;

		test_Q.Dequeue();
	}

	cout << "Move ctor test ";

	return pass;
}

bool test_op_equal()									//tests op = and dequeue
{
	bool pass = true;

	Queue<int> test_Q;
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		test_Q.Enqueue(i);
	}

	Queue<int> Q_test;
	Q_test = test_Q;									//	Op =


	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		int QT = Q_test.Dequeue();
		int TQ = test_Q.Dequeue();
		if (QT != TQ)
			pass = false;
	}

	cout << "Op equals test ";

	return pass;
}

bool test_move_op_equal()							//tests move op = and dequeue
{
	bool pass = true;

	Queue<int> test_Q;
	test_Q = ReturnIntQ();							//Op =

	// Check data integrity
	for (int i = 0; i < 10; i++)
	{
		int val = test_Q.Dequeue();
		if (i != val)
			pass = false;
	}

	cout << "Move op equals test ";

	return pass;
}

bool test_is_empty()				//tests the isEmpty() function with an empty and a not empty queue
{
	bool pass = true;

	Queue<int> emptyQ;

	Queue<int> notEmptyQ;

	for (int i = 0; i < 5; i++)
	{
		notEmptyQ.Enqueue(i);
	}

	if (!emptyQ.isEmpty() || notEmptyQ.isEmpty())
		pass = false;

	cout << "Test is empty test ";
	return pass;

}

bool test_one_value()						//tests getfront, getback, getsize, dequeue and enqueue with a queue of one and then dequeuing that queue
{
	bool pass = true;

	Queue<int> notEmptyQ;

	notEmptyQ.Enqueue(1);

	if (notEmptyQ.getFront() != 0 || notEmptyQ.getBack() != 0 || notEmptyQ.getSize() != 1)
		pass = false;

	int val = notEmptyQ.Dequeue();

	if (val != 1 || notEmptyQ.getFront() != -1 || notEmptyQ.getBack() != -1 || notEmptyQ.getSize() != 0)
		pass = false;

	cout << "One value test ";

	return pass;

}

bool test_dequeue_empty()							//tests dequeueing an empty queue
{
	bool pass = false;

	Queue<int> emptyQ;

	try
	{
		emptyQ.Dequeue();
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Empty Queue Dequeue test ";

	return pass;

}

bool test_peek_empty_Q()								//tests the peek function with an empty queue
{
	bool pass = false;
	Queue<int> emptyQ;

	try
	{
		emptyQ.Peek();
	}
	catch (Exception& exception)
	{
		pass = true;
	}

	cout << "Empty Queue Peek test ";

	return pass;
}

bool multiple_value_test()					//Tests dequeue and enqueue with ints from empty to full
{
	bool pass = false;
	Queue<int> test_Q;

	for (int i = 0; i < NUM_SIZE; ++i)
	{
		test_Q.Enqueue(i);
	}								

	int TQ;

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		TQ = test_Q.Dequeue();
		if (i == TQ);
			pass = true;
	}

	cout << "Multiple value test ";

	return pass;
}

bool test_is_full()									//tests the isFull() function
{
	bool pass = false;
	Queue<int> test_Q;

	for (int i = 0; i < NUM_SIZE; ++i)
	{
		test_Q.Enqueue(i);
	}

	if (test_Q.isFull())
		pass = true;

	cout << "Queue is full test ";

	return pass;
}

bool test_copy_ctor_complex()						//tests the copy constructor with strings
{
	bool pass = false;

	Queue<string> test_Q;
	for (int i = 0; i < NUM_NAMES; ++i) {
		try {
			test_Q.Enqueue(NAMES[i]);
		}
		catch (Exception& e) {
			pass = true;
		}
	}

	Queue<string> Q_test{ test_Q };

	if (Q_test.Peek() != test_Q.Peek())
		pass = false;

	// Check data integrity
	for (int i = 0; i < NUM_SORTED_NAMES; ++i)
	{
		if (Q_test.Dequeue() != test_Q.Dequeue())
			pass = false;
	}

	cout << "Copy ctor test complex ";

	return pass;
}

Queue<string> ReturnStrQ();

bool test_move_ctor_complex()								//tests the move constructor with strings
{
	bool pass = true;

	Queue<string> Q_test{ ReturnStrQ() };

	// Check data integrity
	for (int i = 0; i < NUM_SORTED_NAMES; ++i)
	{
		if (Q_test.Dequeue() != SORTED_NAMES[i])
			pass = false;
	}

	cout << "Move ctor test complex ";

	return pass;
}

bool test_op_equal_complex()						//tests op = with strings
{
	bool pass = false;

	Queue<string> test_Q;
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		try {
			test_Q.Enqueue(NAMES[i]);
		}
		catch (Exception& e) {
			pass = true;
		}
	}

	Queue<string> Q_test;
	Q_test = test_Q;									//	Op =

	// Check data integrity
	for (int i = 0; i < NUM_SORTED_NAMES; ++i)
	{
		string QT = Q_test.Dequeue();
		string TQ = test_Q.Dequeue();
		if (QT != TQ)
			pass = false;
	}

	cout << "Op equals test complex ";

	return pass;
}

bool test_move_op_equal_complex()					//tests move op = with strings
{
	bool pass = true;

	Queue<string> test_Q;
	test_Q = ReturnStrQ();							//Op =

	// Check data integrity
	for (int i = 0; i < NUM_SORTED_NAMES; i++)
	{
		string val = test_Q.Dequeue();
		if (SORTED_NAMES[i] != val)
			pass = false;
	}

	cout << "Move op equals test complex ";

	return pass;
}

bool test_is_empty_complex()						//tests isEmpty() function with strings
{
	bool pass = false;
	Queue<string> emptyQ;
	Queue<string> notEmptyQ;

	for (int i = 0; i < 5; i++)
	{
		try {
			notEmptyQ.Enqueue(NAMES[i]);
		}
		catch (Exception& E) {
			pass = true;
		}
	}

	if (!emptyQ.isEmpty() || notEmptyQ.isEmpty())
		pass = false;

	cout << "Test is empty test complex ";

	return pass;
}

bool test_is_full_complex()									//tests isFull() function with strings
{
	bool pass = false;
	Queue<string> test_Q;

	for (int i = 0; i < NUM_SORTED_NAMES; ++i){
		test_Q.Enqueue(SORTED_NAMES[i]);
	}
	test_Q.Enqueue("Theresa");
	test_Q.Enqueue("Uvie");
	test_Q.Enqueue("Veronica");
	test_Q.Enqueue("Wanda");
	test_Q.Enqueue("Xanthi");

	if (test_Q.isFull())
		pass = true;

	cout << "Queue is full test complex ";

	return pass;
}

bool test_with_value_complex()					//tests enqueue and dequeue with strings
{
	bool pass = false;
	Queue<string> test_Q;

	for (int i = 0; i < NUM_SIZE; ++i)
	{
		try {
			test_Q.Enqueue(NAMES[i]);
		}
		catch (Exception& E) {
			pass = true;
		}
	}

	for (int i = 0; i < NUM_SORTED_NAMES; ++i)
	{
		if (test_Q.Dequeue() != SORTED_NAMES[i])
			pass = false;
	}

	cout << "Queue peek test complex ";

	return pass;
}

bool test_peek_empty_Q_complex()
{
	bool pass = false;
	
	Queue<string> test_Q;

	try {
		test_Q.Peek();
	}
	catch (Exception& exception) {
		pass = true;
	}

	cout << "Peek empty complex test ";

	return pass;
}

bool test_peek_full_complex()							//tests peek throughout an entire dequeueing of a full queue
{
	bool pass = false;
	Queue<string> test_Q, Q_test;

	for (int i = 0; i < NUM_SIZE; ++i) {
		try {
			test_Q.Enqueue(NAMES[i]);
			Q_test.Enqueue(NAMES[i]);
		}
		catch (Exception& E) {
			pass = true;
		}
	}

	for (int i = 0; i < NUM_SORTED_NAMES; ++i) {
		if (test_Q.Peek() != Q_test.Peek() || test_Q.Peek() != SORTED_NAMES[i] || Q_test.Peek() != SORTED_NAMES[i])
			pass = false;
		test_Q.Dequeue();
		Q_test.Dequeue();
	}

	cout << "Queue peek test complex ";

	return pass;
}

bool test_print_complex()						//tests printing with a full Queue
{
	bool pass = false;
	Queue<string> test_Q;

	for (int i = 0; i < NUM_NAMES; ++i)
	{
		try {
			test_Q.Enqueue(NAMES[i]);
		}
		catch (Exception& E) {
			pass = true;
		}
	}
	try{
		test_Q.Print();									//should print the list of  sorted names
	}
	catch (Exception& exception) {
		pass = false;
	}

	cout << "As long as five names are above this line, the complex print function test ";

	return pass;
}

bool test_print_empty()									//tests printing with an empty queue
{
	bool pass = false;

	Queue<int> Q;

	try {
		Q.Print();
	}

	catch (Exception& exception) {
		pass = true;
	}

	cout << "Print with empty queue test ";

	return pass;

}

bool test_enqueue_full_Q()						//tests enqueue when Q is full
{
	bool pass = false;
	Queue<string> test_Q;

	for (int i = 0; i < NUM_SORTED_NAMES; ++i) {
		test_Q.Enqueue(SORTED_NAMES[i]);
	}

	test_Q.Enqueue("Theresa");
	test_Q.Enqueue("Uvie");
	test_Q.Enqueue("Veronica");
	test_Q.Enqueue("Wanda");
	test_Q.Enqueue("Xanthi");

	try {
		test_Q.Enqueue("Zoolanda");
	}
	catch (Exception& exception) {
		pass = true;
	}

	cout << "Queue is full test complex ";

	return pass;
}

bool test_smaller_ints() {								//added function to test new functionality, smaller integers should not be allowed
	bool pass = false;
	Queue<int> test_Q;
	for (int i = 10; i > 0; i--) {
		try {
			test_Q.Enqueue(i);
		}
		catch (Exception& E) {
			pass = true;
		}
	}

	if (test_Q.Peek() != 10)
		pass = false;

	cout << "Test adding smaller ints test ";

	return pass;
}


// Test functions for moves
Queue<int> ReturnIntStack();
Queue<string> ReturnStrStack();

// Array of test functions
FunctionPointer test_functions[] = { test_default_ctor, test_copy_ctor, test_move_ctor,
test_op_equal, test_move_op_equal, test_is_empty, test_one_value, test_dequeue_empty,
test_peek_empty_Q, multiple_value_test, test_is_full, test_copy_ctor_complex,
test_move_ctor_complex, test_op_equal_complex, test_move_op_equal_complex,
test_is_empty_complex, test_is_full_complex, test_peek_empty_Q_complex,
test_with_value_complex, test_peek_full_complex, test_print_complex, test_print_empty,
test_enqueue_full_Q, test_smaller_ints };


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


Queue<int> ReturnIntQ()							//int stack creating func for move constructor
{
	Queue<int> tempQ;
	for (int i = 0; i < NUM_SIZE; ++i)
		tempQ.Enqueue(i);

	return tempQ;
}


Queue<string> ReturnStrQ()						//string stack creating func for move constructor
{
	Queue<string> tempQ;
	for (int i = 0; i < NUM_NAMES; ++i) {
		try {
			tempQ.Enqueue(NAMES[i]);
		}
		catch(Exception& E) {
			cout << "Oh, good, exception caught!" << endl;
		}
	}
	return tempQ;
}
