#include "unity.h"
#include "foo.h"

void setUp(void)
{
}

void tearDown(void)
{
}

// Create one passing and one failing assertion using TEST_ASSERT_TRUE.
void testTEST_ASSERT_TRUE (void)
{
    TEST_ASSERT_TRUE (1 == 1); 
    //TEST_ASSERT_TRUE (1 == 2); //failing
}

// Create one passing and one failing assertion using TEST_ASSERT_FALSE.
void testTEST_ASSERT_FALSE (void)
{
	TEST_ASSERT_FALSE (1 == 2);
	//TEST_ASSERT_FALSE (1 == 1); //failing
}

// Create one passing and one failing assertion using TEST_ASSERT_EQUAL_INT8.
// Try it with negative decimal numbers, positive decimal numbers, and hexadecimal numbers.
void testTEST_ASSERT_EQUAL_INT8 (void)
{	
	TEST_ASSERT_EQUAL_INT8( 1, 1);
	//TEST_ASSERT_EQUAL_INT8(-1, 1); //failing
}

// Create one passing and one failing assertion using TEST_ASSERT_EQUAL_UINT8.
// Try it with negative decimal numbers, positive decimal numbers, and hexadecimal numbers.
void testTEST_ASSERT_EQUAL_UINT8 (void)
{	
	TEST_ASSERT_EQUAL_UINT8(1, 1);
	//TEST_ASSERT_EQUAL_UINT8(1, -1); //failing
}

// Create one passing and one failing assertion using TEST_ASSERT_EQUAL_HEX8.
// Try it with negative decimal numbers, positive decimal numbers, and hexadecimal numbers.
void testTEST_ASSERT_EQUAL_HEX8 (void)
{
	TEST_ASSERT_EQUAL_HEX8( 0xff, 0xff );
	//TEST_ASSERT_EQUAL_HEX8( 0x00, 0xff ); //failing
}

// Create one passing and one failing assertion using TEST_ASSERT_UINT_WITHIN.
void testTEST_ASSERT_UINT_WITHIN (void)
{
	TEST_ASSERT_UINT_WITHIN(50, 75, 50);
	//TEST_ASSERT_UINT_WITHIN(25, 75, 25);//failing
}

// Create one passing and one failing assertion using TEST_ASSERT_BITS.
void testTEST_ASSERT_BITS (void)
{
	TEST_ASSERT_BITS(0xa5, 0xe7, 0xa5 );
	//TEST_ASSERT_BITS(0xa5, 0xa4, 0xe7 );//failing
}

// Create one passing and one failing assertion using TEST_ASSERT_BITS_HIGH.
void testTEST_ASSERT_BITS_HIGH (void)
{
	TEST_ASSERT_BITS_HIGH(0xa5, 0xe7);
	//TEST_ASSERT_BITS_HIGH(0xe7, 0xa5);//failing
}

// Create one passing and one failing assertion using TEST_ASSERT_BIT_HIGH.
void testTEST_ASSERT_BIT_HIGH (void)
{
	TEST_ASSERT_BIT_HIGH(2, 4);
	//TEST_ASSERT_BIT_HIGH(3, 4);//failing
}

// Exhaustively test all 256 input values for the squareNumber function located in lab6\unity\src\foo.c.
// squareNumber takes an 8-bit unsigned integer as input, squares it, and then returns the squared value as a 16-bit
// unsigned integer.
void testsquareNumber (void)
{
	for (int i = 0; i < 256; i++)
	{
		TEST_ASSERT_EQUAL_UINT16 (squareNumber(i), i*i);
	}
}