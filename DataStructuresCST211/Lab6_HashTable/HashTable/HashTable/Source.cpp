//Cari Blaker
//Lab 6
//03/02/23

#include <iostream>
#include <crtdbg.h>
#include <conio.h>
#include <string>
#include "Hash.h"

using std::string;
using std::cout;
using std::cin;
using std::endl;

#define _CRT_SECURE_NO_WARNINGS
#define _CRTDBG_MAP_ALLOC

typedef bool(*FunctionPointer)();					// Define a function pointer type

const string FRUIT[] = { "apples", "bananas", "cherries", "dragonfruit", "eeples", "fwoot", "gojiberries", "huckleberries",
						"ipples", "jojos", "kant-elope", "lingonberries", "marionberries", "naners", "out of fruit" };		//15 strings

const int NUMS[] = { 50, 99, 1, 0, 478, 2, 12, 92, 87, 49, 69, 68, 333, 13, 16 };		//15 ints

template <typename K>
int hash_func1(K key) {											//the djb2 algorithm, most of this function came from https://stackoverflow.com/questions/19892609/djb2-by-dan-bernstein-for-c
	const char* str = reinterpret_cast<const char*>(&key);
	unsigned long hash = 5381;
	int c;

	while ((c = *str++)) {
		hash = ((hash << 5) + hash) + c;
	}

	return static_cast<int>(hash);	
}

template<typename K>
int hash_func2(K key) {
	int hash = 0;
	std::string strKey = std::to_string(key);
	for (int i = 0; i < strKey.size(); i++) {
		hash += strKey[i];
	}
	return hash;
}

template <typename V>
void printValue(V value) {
    cout << value << endl;
}

bool test_default_ctor() {							//tests default using default size
	bool pass = true;
	Hash<int, int> hashy;
	if (hashy.getSize() != 100)
		pass = false;
	cout << "Default ctor test ";
	return pass;
}

bool test_param_ctor() {							//tests parameterized ctor using size 10
    bool pass = true;
    Hash<int, string> hashy(10);
    if (hashy.getSize() != 10)
        pass = false;
	cout << "Param ctor test ";
	return pass;
}

bool test_copy_ctor() {								//this tests the copy constructor AND the != op AND ==op
	bool pass;

	Hash<int, int> hashy(10);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 10; i++)
		hashy.Add(i, i * i);

	Hash<int, int> hashy_copy(hashy);

	if (hashy == hashy_copy)
		pass = true;

	if (hashy != hashy_copy)
		pass = false;

	cout << "Copy ctor test ";

	return pass;
}


Hash<int, string> move_helper() {
	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);
	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);
	return hashy;
}

bool test_move_ctor() {									//tests the move constructor, and the [] reading op
	bool pass = true;

	Hash<int, string> hashy(move_helper());

	for (int i = 0; i < 15; i++) {
		if (hashy[NUMS[i]] != FRUIT[i])
			pass = false;
	}

	cout << "Move ctor test ";
	return pass;
}

bool test_op_equal() {										//tests copy op= AND reading[] op
	bool pass = true;
	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);

	Hash<int, string> hashy_twin = hashy;
	
	for (int i = 0; i < 15; i++) {
		if (hashy_twin[NUMS[i]] != hashy_twin[NUMS[i]])
			pass = false;
	}

	if (hashy_twin.getSize() != hashy_twin.getSize())
		pass = false;

	cout << "Copy op= test ";

	return pass;
}

bool test_move_op_equal() {									//tests move op=, and Add(), and rehashing for over 75% full
	bool pass = true;
	Hash<int, string> hashy = move_helper();

	for (int i = 0; i < 15; i++) {
		if (hashy[NUMS[i]] != FRUIT[i])
			pass = false;
	}

	if (hashy.getSize() != 30)								//it should've doubled in size since it got more than 75% full
		pass = false;

	cout << "Move op= test ";

	return pass;
}

bool test_writing_op() {									//tests writing []operator
	bool pass = true;

	Hash<int, string> hashy;
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++) {
		hashy[std::make_pair(NUMS[i], FRUIT[i])];
	}

	for (int i = 0; i < 15; i++) {
		if (hashy[NUMS[i]] != FRUIT[i])
			pass = false;
	}

	cout << "Writing [] operator test ";
	
	return pass;
}

bool test_remove_valid() {												//tests removing a key that does exist
	bool pass = true;

	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);
	try {
		hashy.Remove(16);
	}
	catch (Exception& e){
		pass = false;
	}

	cout << "Remove valid test ";
	return pass;
}

bool test_remove_invalid() {									//tests removing a key that doesn't exist
	bool pass = false;

	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);

	try {
		hashy.Remove(15);
	}
	catch (Exception& e) {
		pass = true;
	}

	cout << "Remove invalid test ";
	return pass;
}

bool test_traverse() {											//set hash function is also tested here
	bool pass = true;

	Hash<int, string> hashy(10);
	hashy.setHash(hash_func2);

	for (int i = 0; i < 10; i++)
		hashy.Add(i, FRUIT[i]);

	hashy.Traverse(printValue);

	cout << "\nIf the above matches the below, then the traverse test passed" << endl;

	for (int i = 0; i < 10; i++)
		cout << FRUIT[i] << endl;

	return pass;
}

bool test_data_request() {								//requests data with valid key
	bool pass = true;

	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);

	try {
		string boop = hashy[0];
		if (boop != "dragonfruit")
			pass = false;
	}
	catch (Exception& e) {
		pass = false;
	}

	cout << "Valid data request test ";

	return pass;
}

bool test_data_request_invalid() {							//requests data w/ invalid key
	bool pass = false;

	Hash<int, string> hashy(15);
	hashy.setHash(hash_func1);

	for (int i = 0; i < 15; i++)
		hashy.Add(NUMS[i], FRUIT[i]);

	try {
		string boop = hashy[3];
	}
	catch (Exception& e) {
		pass = true;
	}

	cout << "Invalid data request test ";

	return pass;
}

bool test_request_empty() {
	bool pass = false;
	Hash<int, string> hashy;

	try {
		string boop = hashy[0];
	}
	catch (Exception& e) {
		pass = true;
	}

	cout << "Request data from empty hash test ";

	return pass;
}

// Array of test functions
FunctionPointer test_functions[] = { test_default_ctor, test_param_ctor, test_copy_ctor, test_move_ctor,
test_op_equal, test_move_op_equal, test_writing_op, test_remove_valid, test_remove_invalid, test_traverse, 
test_data_request, test_data_request_invalid, test_request_empty};


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
