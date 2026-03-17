#include "bleService.hpp"
#include "footSense.hpp"

void serialSetup()
{
  Serial.begin(115200);
  //while (!Serial) delay(10);  // for nrf52840 with native usb

  Serial.println("--------------------------------");
  Serial.println("Prodigy Health Innovations");
  Serial.println("Seeed Board nRF52840 Sense");
  Serial.println("Smart Stepper");
  Serial.println("--------------------------------");
}

void setup() {
  serialSetup();
  bleSetup();
  footSetup();
}

void loop() {
  // put your main code here, to run repeatedly:

  footMain();

  delay(10);

}
