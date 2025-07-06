#include "unity.h"
#include "foo.h"

extern alertStatus_t alertStatus;

void setUp(void)
{
}

void tearDown(void)
{
}

// [Step 1] Exhaustively test returnHeartRateConcern for heart rates from 0 to 255.
void testHeartRateConcern (void)
{
	for (int hr = 0; hr <= 255; hr++) {
        concernLevel_t expected;
        if (hr < 40)
            expected = SERIOUS;
        else if (hr >= 40 && hr <= 59)
            expected = fair;
        else if (hr >= 60 && hr <= 90)
            expected = good;
        else if (hr >= 91 && hr <= 120)
            expected = fair;
        else
            expected = SERIOUS;
        
        TEST_ASSERT_EQUAL(expected, returnHeartRateConcern(hr));
    }
} //end: void testHeartRateConcern (void)

// [Step 2] Exhaustively test returnTemperatureConcern for temperatures from from 0 to 255.
void testTemperatureConcern (void)
{
	for (int temp = 0; temp <= 255; temp++) {
        concernLevel_t expected;
        if (temp < 34)
            expected = SERIOUS;
        else if (temp >= 34 && temp <= 35)
            expected = fair;
        else if (temp >= 36 && temp <= 38)
            expected = good;
        else if (temp >= 39 && temp <= 40)
            expected = fair;
        else
            expected = SERIOUS;
        
        TEST_ASSERT_EQUAL(expected, returnTemperatureConcern(temp));
    }
} // end: void testTemperatureConcern (void)

// [Step 3] Test updateAlertStatus function for several values of heart rate and temperature. alertStatus is a global variable.
void testAlertStatus (void)
{	
    initAlertStatus();
	// good
    updateAlertStatus(75, 37);
    TEST_ASSERT_EQUAL(NO_ALERT, alertStatus);

    // 2 consecutive fairs
    updateAlertStatus(48, 35);
    TEST_ASSERT_EQUAL(NO_ALERT, alertStatus);
    updateAlertStatus(59, 34);
    TEST_ASSERT_EQUAL(ALERT_USER, alertStatus);

    // serious
    updateAlertStatus(60, 41);
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);

    // serious
    initAlertStatus();
    updateAlertStatus(39, 38); 
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);
	
	// Test: Transition back to no-alert after three consecutive good readings
    initAlertStatus();
    updateAlertStatus(57, 34); // fair-fair 
    updateAlertStatus(40, 35); // fair-fair (2nd alert user trigger)
	TEST_ASSERT_EQUAL(ALERT_USER, alertStatus);
    updateAlertStatus(75, 37); // good-good 
    updateAlertStatus(90, 36); // good-good 
    updateAlertStatus(60, 38); // good-good (3rd resets to no alert)
    TEST_ASSERT_EQUAL(NO_ALERT, alertStatus);
	
	//THREE ALERT DR. TESTS:

    initAlertStatus();
    updateAlertStatus(15, 22); // both serious
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);

    initAlertStatus();
    updateAlertStatus(50, 41); // fair HR, serious temp
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);

    initAlertStatus();
    updateAlertStatus(75, 68); // good HR, serious Temp
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);
			
}//end: void testAlertStatus (void)

