#include "unity.h"
#include "temperature_tools.h"

void setUp(void)
{
}

void tearDown(void)
{
}

// Test the conv_f_to_c function for a single low (less than -100) value and expect an error.
void test_f_to_c_error_once_low (void)
{
    TEST_ASSERT_EQUAL_INT8 (0x7F, conv_f_to_c (-101));
}

// Test the conv_f_to_c function for a single temperature of 32 degrees F = 0 degrees C.
 void test_f_c_zero (void)
 {
	TEST_ASSERT_EQUAL_INT8 (0, conv_f_to_c(32));
 }

 //Test the conv_f_to_c function for any low (less than -100) value and expect an error.
 void test_f_to_c_error_any_low (void)
 {
     for (int16_t temp_f = -101; temp_f > -129; temp_f--)
     {
         TEST_ASSERT_EQUAL_INT8 (0x7F, conv_f_to_c((int8_t) temp_f));
     }
 }

// Test the conv_f_to_c function for a single high (greater than 100) value and expect an error.
 void test_error_response_once_high (void)
 {
     TEST_ASSERT_EQUAL_INT8 (0x7F, conv_f_to_c (101));
 }

// Test the conv_f_to_c function for any legal (-100 to 100) value.
 void test_f_to_c_any_legal (void)
 {
     int8_t expected_temp_c;

     for (int8_t temp_f = -100; temp_f <= 100; temp_f++)
     {
         expected_temp_c = (temp_f - 32) * 5 / 9;

         TEST_ASSERT_EQUAL_INT8 (expected_temp_c, conv_f_to_c (temp_f));
     }
 }

// Test the conv_f_to_c function for any high (greater than 100) value and expect an error.
 void test_f_to_c_error_any_high (void)
 {
     for (int16_t temp_f = 101; temp_f < 128; temp_f++)
     {
         TEST_ASSERT_EQUAL_INT8 (0x7F, conv_f_to_c ((int8_t) temp_f));
     }
 }