//Cari Blaker
//Lab 3
//02/02/23

#define _CRT_SECURE_NO_WARNINGS
#define _CRTDBG_MAP_ALLOC

typedef bool(*FunctionPointer)();  // Define a function pointer type

#include <string>
using std::string;

#include <iostream>
using std::cout;
using std::cin;
using std::endl;

#include <crtdbg.h>
#include <conio.h>
#include "List.h"
#include "Stack.h"

// Strings to test
const string NAMES[] = { "Kyle", "Brit", "Seth", "Alex", "Josh", "Kian",
"Kate", "Terry", "Ann", "Elaine"};
const string TOO_MANY_NAMES [] = { "Kyle", "Brit", "Seth", "Alex", "Josh", "Kian",
"Kate", "Terry", "Ann", "Elaine", "Stephanie", "Wanda", "Oscar",
"Oliver", "Tobey" };

const int NUM_NAMES = 10;
const int TOO_MANY_NUM = 15;
const int NUM_SIZE = 10;
const int NUM_EXTRACT = 4;

// Test function declaration
bool test_default_ctor();
bool test_copy_ctor();
bool test_move_ctor();
bool test_op_equal();
bool test_move_op_equal();
bool test_is_empty();
bool test_pop_with_value();
bool test_pop_empty_stack();
bool test_peek_empty_stack();
bool multiple_value_test();
bool test_is_full();

bool test_copy_ctor_complex();
bool test_move_ctor_complex();
bool test_op_equal_complex();
bool test_move_op_equal_complex();
bool test_is_empty_complex();
bool test_is_full_complex();
bool test_peek_with_value_complex();
bool test_peek_empty_stack_complex();

bool test_pop_empty_stack_complex();
bool test_push_complex();
bool test_pop_empty_complex();
bool test_multiple_value_complex();


// Test functions for moves
Stack<int> ReturnIntStack();
Stack<string> ReturnStrStack();

// Array of test functions
FunctionPointer test_functions[] = { test_default_ctor, 
test_copy_ctor, test_move_ctor, test_op_equal, test_move_op_equal, test_is_empty,
test_pop_with_value, test_pop_empty_stack, test_peek_empty_stack,
multiple_value_test, test_is_full, test_copy_ctor_complex, test_move_ctor_complex, test_op_equal_complex,
test_move_op_equal_complex, test_is_empty_complex, test_is_full_complex,
test_peek_empty_stack_complex, test_peek_with_value_complex, test_pop_empty_stack_complex,
test_push_complex, test_pop_empty_complex,
test_multiple_value_complex };

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

bool test_default_ctor()					//this function tests the default constructor
{
	bool pass = true;

	Stack<int> stack_test;

	if (stack_test.getNumElements() != 10)
		pass = false;

	cout << "Default ctor test ";

	return pass;
}

bool test_copy_ctor()									//This function tests the copy constructor
{														//but also, peek, pop, and push, inadvertently
	bool pass = true;

	Stack<int> test_stack;
	for (int i = 0; i < NUM_SIZE; ++i)
		test_stack.Push(i);

	Stack<int> stack_test(test_stack);

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (stack_test.Peek() != test_stack.Peek())
			pass = false;
		stack_test.Pop();												
		test_stack.Pop();
	}

	cout << "Copy ctor test ";

	return pass;
}

bool test_move_ctor()									//this function tests the move constructor,
{														//and push, pop, and peek inadvertently as well
	bool pass = true;

	Stack<int> test_stack(ReturnIntStack());

	// Check data integrity
	for (int i = 9; i >= 0; i--)
	{
		if (i != test_stack.Peek())
			pass = false;
		test_stack.Pop();
	}

	cout << "Move ctor test ";

	return pass;
}

bool test_op_equal()								//tests copy assignment = operator, but also push and peek and pop
{
	bool pass = true;

	Stack<int> test_stack;
	for (int i = 0; i < NUM_SIZE; ++i)
		test_stack.Push(i);

	Stack<int> stack_test;
	stack_test = test_stack; //	Op =

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (stack_test.Peek() != test_stack.Peek())
			pass = false;
		stack_test.Pop(); 
		test_stack.Pop();
	}

	cout << "Op equals test ";

	return pass;
}

bool test_move_op_equal()							//tests move assignment = operator, and push and pop
{
	bool pass = true;

	Stack<int> test_stack;
	test_stack = ReturnIntStack(); //Op =

	// Check data integrity
	for (int i = 9; i >= 0; i--)
	{
		if (i != test_stack.Peek())
			pass = false;
		test_stack.Pop(); //Remove first value
	}

	cout << "Move op equals test ";

	return pass;
}

bool test_is_empty()								//tests the isEmpty() function with a full stack and an empty stack
{
	bool pass = true;

	Stack<int> full_stack;

	for (int i = 0; i < NUM_SIZE; ++i)
		full_stack.Push(i);

	Stack<int> empty_stack;

	if (full_stack.isEmpty())
		pass = false;

	if (!empty_stack.isEmpty())
		pass = false;

	cout << "isEmpty test ";

	return pass;
}

bool test_pop_with_value()								//tests pop with a full stack
{
	bool pass = true;

	Stack<int> full_stack;
	for (int i = 9; i >= 0; i--)
		full_stack.Push(i);

	for (int i = 0; i < 9; i++)
	{
		if (full_stack.Pop() != i)
			pass = false;
	}

	cout << "Pop with value test ";

	return pass;
}

bool test_pop_empty_stack()										//test pop on an empty stack
{
	bool pass = false;

	Stack<int> empty_stack;

	try
	{
		empty_stack.Pop();
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}

	cout << "Pop with empty stack test ";

	return pass;
}

bool test_peek_empty_stack()						//tests peek with an empty stack
{
	bool pass = false;

	Stack<int> empty_stack;

	try
	{
		empty_stack.Peek();
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}

	cout << "Last with empty list test ";

	return pass;
}

bool multiple_value_test()								//tests with other values and a different size stack than previous
{														//tests the number of elements, which hasn't been done yet
	bool pass = true;
	int init_value = 5;
	int next_value = 3;

	Stack<int> test_stack;

	test_stack.Push(init_value);
	test_stack.Push(next_value);
	if (test_stack.getNumElements() != 10)
		pass = false;

	if (test_stack.Pop() != next_value)
		pass = false;

	if (test_stack.Pop() != init_value)
		pass = false;

	cout << "Multiple Value test ";

	return pass;
}

bool test_is_full()									//tests deleting a whole stack, and isFull when empty and full
{													//tests num elements again
	bool pass = true;
	int num;

	Stack<int> full_stack;
	if (full_stack.isFull())
		pass = false;

	try {
		for (int i = 0; i < NUM_SIZE; ++i)
			full_stack.Push(i);

		if (!full_stack.isFull())						//stack should be full
			pass = false;

		for (int i = 9; i > 0; i--)
		{
			num = full_stack.Pop();
			if (num != i)
				pass = false;
		}
		if (full_stack.isFull())						//stack should be empty again
			pass = false;
	}
	catch (Exception& exception)
	{
		cout << exception.getMessage() <<endl;
	}

	if (full_stack.getNumElements() != 10)
		pass = false;

	cout << "Purge/isFull() test ";

	return pass;
}


bool test_copy_ctor_complex()							//tests the copy constructor with strings
{
	bool pass = true;

	Stack<string> test_stack;
	for (int i = 0; i < NUM_NAMES; ++i)
		test_stack.Push(NAMES[i]);

	Stack<string> stack_test{ test_stack };

	// Check data integrity
	for (int i = 0; i < NUM_NAMES; ++i)
	{
		if (stack_test.Peek() != test_stack.Peek())
			pass = false;
		string boop = stack_test.Pop(); //Remove first value
		string bop = test_stack.Pop();
	}

	cout << "Copy ctor test complex ";

	return pass;
}

bool test_move_ctor_complex()										//tests the move constructor with strings
{
	bool pass = true;

	Stack<string> test_stack{ ReturnStrStack() };

	// Check data integrity
	for (int i = 9; i > 0; i--)
	{
		if (NAMES[i] != test_stack.Peek())
			pass = false;
		string beep = test_stack.Pop(); //Remove first value
	}

	cout << "Move ctor test complex ";

	return pass;
}

bool test_op_equal_complex()											//tests copy = op with strings
{
	bool pass = true;

	Stack<string> test_stack;
	for (int i = 0; i < NUM_NAMES; ++i)
		test_stack.Push(NAMES[i]);

	Stack<string> stack_test;
	stack_test = test_stack; //Op =

	// Check data integrity
	for (int i = 0; i < NUM_NAMES; ++i)
	{
		if (stack_test.Peek() != test_stack.Peek())
			pass = false;
		string beep = stack_test.Pop(); //Remove first value
		string boop = test_stack.Pop();
	}

	cout << "Op equals test complex ";

	return pass;
}

bool test_move_op_equal_complex()									//tests move = op with strings
{
	bool pass = true;

	Stack<string> test_stack;
	test_stack = ReturnStrStack(); //Op =

	// Check data integrity
	for (int i = 9; i > 0; i--)
	{
		if (NAMES[i] != test_stack.Peek())
			pass = false;
		string moop = test_stack.Pop(); //Remove first value
	}

	cout << "Move op equals test complex ";

	return pass;
}

bool test_is_empty_complex()										//tests is_empty() with strings
{
	bool pass = true;

	Stack<string> full_stack;
	for (int i = 0; i < NUM_NAMES; ++i)
		full_stack.Push(NAMES[i]);

	Stack<string> empty_stack;

	if (full_stack.isEmpty())
		pass = false;

	if (!empty_stack.isEmpty())
		pass = false;

	cout << "isEmpty test complex ";

	return pass;
}

bool test_is_full_complex()							//tests isFull() with a stack of strings when it's empty and full
{
	bool pass = true;

	Stack<string> full_stack;							//stack should be empty
	if (full_stack.isFull())
		pass = false;

	try {
		for (int i = 0; i < NUM_NAMES; ++i)
			full_stack.Push(NAMES[i]);

		if (!full_stack.isFull())						//stack should be full
			pass = false;
	}

	catch (Exception& exception)
	{
		cout << exception.getMessage() << endl;
	}

	if (full_stack.getNumElements() != 10)
		pass = false;

	cout << "Purge/isFull() test ";

	return pass;
}


bool test_peek_with_value_complex()							//tests peek (and push) with strings
{
	bool pass = false;

	Stack<string> full_stack;
	try
	{
		for (int i = 0; i < NUM_NAMES; ++i)
			full_stack.Push(NAMES[i]);

		if (full_stack.Peek() == NAMES[NUM_NAMES - 1])
			pass = true;
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}
	cout << "Peek with value test complex ";

	return pass;
}

bool test_peek_empty_stack_complex()					//tests empty string stack's isEmpty() function
{
	bool pass = false;

	Stack<string> empty_stack;

	try
	{
		empty_stack.Peek();
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}

	cout << "Peek with empty stack test complex ";

	return pass;
}

bool test_pop_empty_stack_complex()						//tests pop with an empty string stack
{
	bool pass = false;

	Stack<string> empty_stack;

	try
	{
		empty_stack.Pop();
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}

	cout << "Pop with empty stack test complex ";

	return pass;
}

bool test_push_complex()						//tests push with strings.. but also peek.
{
	bool pass = true;
	string init_value = "Person";
	string next_value = "Dog";

	Stack<string> test_stack;


	test_stack.Push(init_value);
	if (test_stack.Peek() != init_value)
		pass = false;


	test_stack.Push(next_value);
	if (test_stack.Peek() != next_value)
		pass = false;

	cout << "Push/Peek test complex ";

	return pass;
}

bool test_pop_empty_complex()						//tests pop with empty string stack
{
	bool pass = false;
	string test_value = "Person";

	Stack<string> empty_stack;

	try
	{
		empty_stack.Pop();
	}
	catch (Exception& exception)
	{
		exception.getMessage();
		pass = true;
	}

	cout << "Pop empty stack test complex ";

	return pass;
}


bool test_multiple_value_complex()					//tests inserting too many strings onto the stack, and the integrity of the stack afterward
{
	bool pass = true;

	Stack<string> test_stack;
	for (int i = 0; i < TOO_MANY_NUM; i++)
	{ 
		try {
			test_stack.Push(TOO_MANY_NAMES[i]);
		}
		catch (Exception& exception)
		{
			exception.getMessage();
			if (i < test_stack.getNumElements())
				pass = false;
		}
	}
	for (int i = test_stack.getNumElements(); i > 0; i--)
	{
		try {
			if (test_stack.Pop() != TOO_MANY_NAMES[i - 1])
				pass = false;
		}
		catch (Exception& exception)
		{
			exception.getMessage();
		}
	}

	cout << "Complex string push & pop test ";

	return pass;
}


Stack<int> ReturnIntStack()							//int stack creating func for move constructor
{
	Stack<int> tempStack;
	for (int i = 0; i < NUM_SIZE; ++i)
		tempStack.Push(i);
	return tempStack;
}

Stack<string> ReturnStrStack()						//string stack creating func for move constructor
{
	Stack<string> tempStack;
	for (int i = 0; i < NUM_NAMES; ++i)
		tempStack.Push(NAMES[i]);
	return tempStack;
}