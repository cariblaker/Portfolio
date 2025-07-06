#include "i2c.h"
#include <stdint.h>


static uint16_t mockBuffer[8] = {
    75, 37,  
    39, 33,  
    91, 34,  
    150, 41  
};

uint16_t i2c_readBuffer(uint8_t BufferAddress) {
    return mockBuffer[BufferAddress]; 
}
