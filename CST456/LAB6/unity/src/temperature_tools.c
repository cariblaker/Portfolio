#include "temperature_tools.h"

int8_t conv_f_to_c (int8_t deg_f)
{
if (deg_f < -100 || deg_f > 100) {
        return 0x7F; 						 // return 127 if x<-100 or x>100
    }
    return ((int8_t)((deg_f - 32) * 5 / 9));  // perform conversion
}