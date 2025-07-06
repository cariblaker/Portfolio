#ifndef TEMPERATURE_TOOLS
    #define TEMPERATURE_TOOLS

    #include <stdint.h>

    // Convert degrees Fahrenheit to degrees Celcius.
    // Valid input values range from -100 to 100 degrees Fahrenheit.
    // If the input value is outside the valid range then the function will return the most positive value,
    // 127, as an error code.
    int8_t conv_f_to_c (int8_t deg_f);

#endif