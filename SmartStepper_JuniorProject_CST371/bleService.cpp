#include <bluefruit.h>

#define L_MODEL 1
#define R_MODEL 2

#define CURRENT_MODEL L_MODEL

#define LEFT_FOOT "L"
#define RIGHT_FOOT "R"

#if CURRENT_MODEL == L_MODEL
#define FOOT LEFT_FOOT
#else
#define FOOT RIGHT_FOOT
#endif

#define MAX_PRPH_CONNECTION   2
uint8_t connection_count = 0;

const char DeviceName[] = FOOT "SmartStepper";

// BLE Service
// Custom Service and Characteristic UUIDs
#if CURRENT_MODEL == L_MODEL
#define STEPPER_SERVICE_UUID            "936f7a1c-052d-4dda-b676-db64cc778da5"
#define GOOD_STEPS_CHARACTERISTIC_UUID  "beef"
#define BAD_STEPS_CHARACTERISTIC_UUID   "cafe"
#else
#define STEPPER_SERVICE_UUID            "936f7a1c-052d-4dda-b676-db64cc778da5"
#define GOOD_STEPS_CHARACTERISTIC_UUID  "beef"
#define BAD_STEPS_CHARACTERISTIC_UUID   "cafe"
//#define STEPPER_SERVICE_UUID            "ff21bea8-7334-4662-bafe-ca48be467dc0"
//#define GOOD_STEPS_CHARACTERISTIC_UUID  "feeb"
//#define BAD_STEPS_CHARACTERISTIC_UUID   "efac"
#endif

#define DEBUG_LAST_TRIGGER_0_UUID "ff00"//"f1247096-664e-4a00-89aa-38e465f7a0aa"
#define DEBUG_LAST_TRIGGER_1_UUID "ff01"//"287a0e34-853f-4be1-960d-fb7b272bb791"
#define DEBUG_LAST_TRIGGER_2_UUID "ff02"//"60b5376c-a25f-49af-970f-8f44e7a51921"
#define DEBUG_LAST_TRIGGER_3_UUID "ff03"//"e7ccad9f-9cc2-452c-b631-1f22f357f6cb"

uint32_t goodSteps = 0;
uint32_t badSteps = 0;
BLEService stepperService(STEPPER_SERVICE_UUID);
BLECharacteristic goodStepsCharacteristic(GOOD_STEPS_CHARACTERISTIC_UUID);
BLECharacteristic badStepsCharacteristic(BAD_STEPS_CHARACTERISTIC_UUID);

/*
BLECharacteristic lastTrigger0Characteristic(DEBUG_LAST_TRIGGER_0_UUID);
BLECharacteristic lastTrigger1Characteristic(DEBUG_LAST_TRIGGER_1_UUID);
BLECharacteristic lastTrigger2Characteristic(DEBUG_LAST_TRIGGER_2_UUID);
BLECharacteristic lastTrigger3Characteristic(DEBUG_LAST_TRIGGER_3_UUID);
*/
void connectCallback(uint16_t conn_handle) {
  Serial.println("Device connected");
}

void disconnectCallback(uint16_t conn_handle, uint8_t reason) {
  Serial.println("Device disconnected");
  goodSteps = 0;
  badSteps = 0;
}

void bleSetup()
{
  // Initialize Bluefruit
  Bluefruit.begin(2, 0);
  Bluefruit.setName(DeviceName);
  Bluefruit.setTxPower(4);    // Check bluefruit.h for supported values
  Bluefruit.Periph.setConnectCallback(connectCallback);
  Bluefruit.Periph.setDisconnectCallback(disconnectCallback);

  // Setup Custom Service
  stepperService.begin();

  // Setup Data Characteristic
  goodStepsCharacteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  goodStepsCharacteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  goodStepsCharacteristic.setFixedLen(5); // uint32 = 4 + 1 char L/R
  goodStepsCharacteristic.begin();

  badStepsCharacteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  badStepsCharacteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  badStepsCharacteristic.setFixedLen(5); // uint32 = 4 + 1 char L/R
  badStepsCharacteristic.begin();

/*
  lastTrigger0Characteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  lastTrigger0Characteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  lastTrigger0Characteristic.setFixedLen(4); // Assuming data is a single byte
  lastTrigger0Characteristic.begin();

  lastTrigger1Characteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  lastTrigger1Characteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  lastTrigger1Characteristic.setFixedLen(4); // Assuming data is a single byte
  lastTrigger1Characteristic.begin();

  lastTrigger2Characteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  lastTrigger2Characteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  lastTrigger2Characteristic.setFixedLen(4); // Assuming data is a single byte
  lastTrigger2Characteristic.begin();

  lastTrigger3Characteristic.setProperties(CHR_PROPS_NOTIFY | CHR_PROPS_READ | CHR_PROPS_WRITE);
  lastTrigger3Characteristic.setPermission(SECMODE_OPEN, SECMODE_OPEN);
  lastTrigger3Characteristic.setFixedLen(4); // Assuming data is a single byte
  lastTrigger3Characteristic.begin();
*/
  // Start Advertising
  Bluefruit.Advertising.addFlags(BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE);
  Bluefruit.Advertising.addName();
  Bluefruit.Advertising.addService(stepperService);
  Bluefruit.Advertising.restartOnDisconnect(true);
  Bluefruit.Advertising.setInterval(32, 244);    // in unit of 0.625 ms
  Bluefruit.Advertising.setFastTimeout(30);      // number of seconds in fast mode
  Bluefruit.Advertising.start(0);  // Start advertising forever
  
  Serial.println("BLE advertisement started...");

  uint8_t buf[5] = {0,0,0,0,0};
  char c[] = FOOT;
  buf[4] = c[0];
  goodStepsCharacteristic.write(buf, 5);  
  goodStepsCharacteristic.notify(buf, 5);
  badStepsCharacteristic.write(buf, 5);  
  badStepsCharacteristic.notify(buf, 5);
}

// print a string to Serial Uart and all connected BLE Uart
void addGoodStep()
{
  goodSteps+=1;
  uint8_t buf[5];
  Serial.print("GOOD STEP\n");

  uint8_t* pArray = (uint8_t*)&goodSteps;
  for (int i = 0; i < 4; i++) {
    buf[i] = pArray[i];
    Serial.print(buf[i],HEX);
  }

  char c[] = FOOT;
  buf[4] = c[0];
  // Write new value to data characteristic
  goodStepsCharacteristic.write(buf, 5);
  
  // Notify connected clients about the update (optional)
  goodStepsCharacteristic.notify(buf, 5);
}

void addBadStep()
{
  badSteps+=1;
  uint8_t buf[5];
  Serial.print("BAD STEP\n");

  uint8_t* pArray = (uint8_t*)&badSteps;
  for (int i = 0; i < 4; i++) {
    buf[i] = pArray[i];
    Serial.print(buf[i],HEX);
  }
  char c[] = FOOT;
  buf[4] = c[0];
  // Write new value to data characteristic
  badStepsCharacteristic.write(buf, 5);
  
  // Notify connected clients about the update (optional)
  badStepsCharacteristic.notify(buf, 5);
}


//this code is unused, in full.
/*
void updateLastTriggers(unsigned long* lastTriggers)
{
  
  lastTrigger0Characteristic.write(&lastTriggers[0], sizeof(lastTriggers[0]));
  lastTrigger0Characteristic.notify(&lastTriggers[0], sizeof(lastTriggers[0]));

  lastTrigger1Characteristic.write(&lastTriggers[1], sizeof(lastTriggers[1]));
  lastTrigger1Characteristic.notify(&lastTriggers[1], sizeof(lastTriggers[1]));

  lastTrigger2Characteristic.write(&lastTriggers[2], sizeof(lastTriggers[2]));
  lastTrigger2Characteristic.notify(&lastTriggers[2], sizeof(lastTriggers[2]));

  lastTrigger3Characteristic.write(&lastTriggers[3], sizeof(lastTriggers[3]));
  lastTrigger3Characteristic.notify(&lastTriggers[3], sizeof(lastTriggers[3]));


}

*/