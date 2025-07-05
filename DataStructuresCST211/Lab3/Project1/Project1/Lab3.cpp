//Cari Blaker
//Lab 3
//02/02/23

#define _CRT_SECURE_NO_WARNINGS
#define _CRTDBG_MAP_ALLOC

typedef bool(*FunctionPointer)();  // Define a funtion pointer type

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
"Kate", "Terry", "Ann", "Elaine", "Stephanie", "Wanda", "Oscar",
"Oliver", "Tobey" };

const int NUM_NAMES = 15;
const int NUM_SIZE = 10;
const int NUM_EXTRACT = 4;

// Test function declaration
bool test_default_ctor();
bool test_param_ctor();
bool test_copy_ctor();
bool test_move_ctor();
bool test_op_equal();
bool test_move_op_equal();
bool test_is_empty();
bool test_first_with_value();
bool test_first_empty_list();
bool test_last_with_value();
bool test_last_empty_list();
bool test_prepend();
bool test_append();
bool test_purge();
bool test_extract_empty();
bool test_extract_match();
bool test_extract_no_match();
bool test_inserta_empty();
bool test_inserta_match();
bool test_inserta_no_match();
bool test_insertb_empty();
bool test_insertb_match();
bool test_insertb_no_match();

bool test_default_ctor_complex();
bool test_param_ctor_complex();
bool test_copy_ctor_complex();
bool test_move_ctor_complex();
bool test_op_equal_complex();
bool test_move_op_equal_complex();
bool test_is_empty_complex();
bool test_first_with_value_complex();
bool test_first_empty_list_complex();
bool test_last_with_value_complex();
bool test_last_empty_list_complex();
bool test_prepend_complex();
bool test_append_complex();
bool test_purge_complex();
bool test_extract_empty_complex();
bool test_extract_match_complex();
bool test_extract_no_match_complex();
bool test_inserta_empty_complex();
bool test_inserta_match_complex();
bool test_inserta_no_match_complex();
bool test_insertb_empty_complex();
bool test_insertb_match_complex();
bool test_insertb_no_match_complex();


// Test functions for moves
Stack<int> ReturnIntStack();
Stack<string> ReturnStrStack();

// Array of test functions
FunctionPointer test_functions[] = { test_default_ctor, /*test_param_ctor,*/
test_copy_ctor, test_move_ctor, test_op_equal, test_move_op_equal, test_is_empty,
test_first_with_value, test_first_empty_list, test_last_with_value, test_last_empty_list,
test_prepend, test_append, test_purge, test_extract_empty, test_extract_match,
test_extract_no_match, test_inserta_empty, test_inserta_match, test_inserta_no_match,
test_insertb_empty, test_insertb_match, test_insertb_no_match, test_default_ctor_complex,
test_param_ctor_complex, test_copy_ctor_complex, test_move_ctor_complex, test_op_equal_complex,
test_move_op_equal_complex, test_is_empty_complex, test_first_with_value_complex,
test_first_empty_list_complex, test_last_with_value_complex, test_last_empty_list_complex,
test_prepend_complex, test_append_complex, test_purge_complex, test_extract_empty_complex,
test_extract_match_complex, test_extract_no_match_complex, test_inserta_empty_complex,
test_inserta_match_complex, test_inserta_no_match_complex, test_insertb_empty_complex,
test_insertb_match_complex, test_insertb_no_match_complex };

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

bool test_default_ctor()
{
	bool pass = true;


	Stack<int> stack_test;

	if (stack_test.getNumElements() != 0)
		pass = false;

	cout << "Default ctor test ";

	return pass;
}

//bool test_param_ctor()
//{
//	bool pass = true;
//	List<int> test_list(12);
//	//test_list.Prepend(12);
//	int test_value = test_list.First();
//
//	pass = (test_value == 12);
//
//	cout << "Param ctor test ";
//
//	return pass;
//}

bool test_copy_ctor()									//hmm... maybe 
{
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
		stack_test.Pop(); //Remove first value					
		test_stack.Pop();
	}

	cout << "Copy ctor test ";

	return pass;
}

bool test_move_ctor()
{
	bool pass = true;

	Stack<int> test_stack(ReturnIntStack());

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (i != test_stack.Peek())
			pass = false;
		test_stack.Pop(); // Remove value
	}

	cout << "Move ctor test ";

	return pass;
}

bool test_op_equal()
{
	bool pass = true;

	Stack<int> test_stack;
	for (int i = 0; i < NUM_SIZE; ++i)
		test_stack.Push(i);

	Stack<int> stack_test;
	stack_test = test_stack; //Op =

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (stack_test.Peek() != test_stack.Peek())
			pass = false;
		stack_test.Pop(); //Remove first value
		test_stack.Pop();
	}

	cout << "Op equals test ";

	return pass;
}

bool test_move_op_equal()
{
	bool pass = true;

	Stack<int> test_stack;
	test_stack = ReturnIntStack(); //Op =

	// Check data integrity
	for (int i = 0; i < NUM_SIZE; ++i)
	{
		if (i != test_stack.Peek())
			pass = false;
		test_stack.Pop(); //Remove first value
	}

	cout << "Move op equals test ";

	return pass;
}

bool test_is_empty()
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

bool test_first_with_value()
{
	bool pass = true;

	Stack<int> full_stack;
	for (int i = 0; i < NUM_SIZE; ++i)
		full_stack.Push(i);

	if (full_stack.Pop() != 10)
		pass = false;

	cout << "First with value test ";

	return pass;
}

bool test_first_empty_stack()
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

bool test_empty_stack()
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

	cout << "Last with empty list test ";

	return pass;
}

bool multiple_value_test()
{
	bool pass = true;
	int init_value = 5;
	int next_value = 3;

	Stack<int> test_stack;

	test_stack.Push(init_value);
	test_stack.Push(next_value);
	if (test_stack.getNumElements() != 2)
		pass = false;

	if (test_stack.Pop() != next_value)
		pass = false;

	if (test_stack.Pop() != init_value)
		pass = false;

	cout << "Multiple Value test ";

	return pass;
}

bool test_purge()
{
	bool pass = true;

	Stack<int> full_stack;
	for (int i = 0; i < NUM_SIZE; ++i)
		full_stack.Push(i);

	for (int i = 0; i < NUM_SIZE; ++i)
		full_stack.Pop();

	if (full_stack.getNumElements() != 0)
		pass = false;

	cout << "Purge test ";

	return pass;
}

bool test_pop_empty()
{
	bool pass = false;
	int test_value = 5;

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

	cout << "Pop empty stack test ";

	return pass;
}

//bool test_param_ctor_complex()
//{
//	bool pass = true;
//	List<string> test_list("Sandra");
//	//test_list.Prepend("Sandra");
//	string test_value = test_list.First();
//
//	pass = (test_value == "Sandra");
//
//	cout << "Param ctor test complex ";
//
//	return pass;
//}

bool test_copy_ctor_complex()
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

bool test_move_ctor_complex()
{
	bool pass = true;

	Stack<string> test_stack{ ReturnStrStack() };

	// Check data integrity
	for (int i = 0; i < NUM_NAMES; ++i)
	{
		if (NAMES[i] != test_stack.Peek())
			pass = false;
		string beep = test_stack.Pop(); //Remove first value
	}

	cout << "Move ctor test complex ";

	return pass;
}

bool test_op_equal_complex()
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

bool test_move_op_equal_complex()
{
	bool pass = true;

	Stack<string> test_stack;
	test_stack = ReturnStrStack(); //Op =

	// Check data integrity
	for (int i = 0; i < NUM_NAMES; ++i)
	{
		if (NAMES[i] != test_stack.Peek())
			pass = false;
		string moop = test_stack.Pop(); //Remove first value
	}

	cout << "Move op equals test complex ";

	return pass;
}

bool test_is_empty_complex()
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

bool test_peek_with_value_complex()
{
	bool pass = false;

	Stack<string> full_stack;
	for (int i = 0; i < NUM_NAMES; ++i)
		full_stack.Push(NAMES[i]);

	if (full_stack.Peek() == NAMES[NUM_NAMES])
		pass = true;

	cout << "First with value test complex ";

	return pass;
}

bool test_peek_empty_stack_complex()
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

	cout << "First with empty list test complex ";

	return pass;
}



bool test_pop_empty_stack_complex()
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

	cout << "Last with empty list test complex ";

	return pass;
}

bool test_push_complex()
{
	bool pass = true;
	string init_value = "Person";
	string next_value = "Dog";

	Stack<string> test_stack;

	// Prepend empty list
	test_stack.Push(init_value);
	if (test_stack.Peek() != init_value)
		pass = false;

	// Prepend list with existing values
	test_stack.Push(next_value);
	if (test_stack.Peek() != next_value)
		pass = false;

	cout << "Prepend test complex ";

	return pass;
}

bool test_pop_empty_complex()
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


bool test_insertb_match_complex()
{
	bool pass = true;
	string init_value = "Seth";
	string first_new_value = "Kyle";
	string second_new_value = "Brit";

	Stack<string> test_stack;
	test_stack.Push(init_value);

	test_stack.Push(first_new_value);

	test_stack.Push(second_new_value);

	if (test_stack.Pop() != second_new_value)
		pass = false;

	if (test_stack.Pop() != first_new_value)
		pass = false;

	if (test_stack.Pop() != init_value)
		pass = false;

	cout << "Three stack string push & pop test ";

	return pass;
}


Stack<int> ReturnIntStack()
{
	Stack<int> tempStack;
	for (int i = 0; i < NUM_SIZE; ++i)
		tempStack.Push(i);
	return tempStack;
}

Stack<string> ReturnStrStack()
{
	Stack<string> tempStack;
	for (int i = 0; i < NUM_NAMES; ++i)
		tempStack.Push(NAMES[i]);
	return tempStack;
}