
#ifdef TEST
#include "unity.h"
#include "foo.h"
#include "i2c.h"
#include <stdint.h>

extern alertStatus_t alertStatus; 

void setUp(void) {
    initAlertStatus(); 
}

void tearDown(void) {}

void test_updateAlertStatus_withI2C(void) {
    // (75, 37) good, good = no alert
    updateAlertStatus(i2c_readBuffer(0), i2c_readBuffer(1));
    TEST_ASSERT_EQUAL(NO_ALERT, alertStatus);
    
    // 39, 33 serious, serious, ALERT_DOCTOR 
    updateAlertStatus(i2c_readBuffer(2), i2c_readBuffer(3));
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);
    
	//reset for next test
    initAlertStatus();
    
    // 91, 34 fair, fair ALERT_USER (after 2nd read)
    updateAlertStatus(i2c_readBuffer(4), i2c_readBuffer(5));
    TEST_ASSERT_EQUAL(NO_ALERT, alertStatus); // 1st read
    updateAlertStatus(i2c_readBuffer(4), i2c_readBuffer(5));
    TEST_ASSERT_EQUAL(ALERT_USER, alertStatus); // 2nd read should now trigger
    
    //150, 41 serious, serious, ALERT_DOCTOR
    updateAlertStatus(i2c_readBuffer(6), i2c_readBuffer(7));
    TEST_ASSERT_EQUAL(ALERT_DOCTOR, alertStatus);
}

#endif // TEST
