//Lab2 CST337
//Cari Blaker
//This lab aims to explore factors that influence execution time.
//It uses the Fast Fourier Transform--without an FPU, the ECG processor will take much time to process this.
//That allows us to observe the impact of performance enhancements.


// PIC32MZ2048ECG144, EFM144 or or EFG144 based HMZ144 board Configuration Bit Settings
// DEVCFG2
#if defined(__32MZ2048EFG144__) || defined(__32MZ2048EFM144__)
#pragma config FPLLIDIV = DIV_4 // System PLL Input Divider (4x Divider) for 24MHz clock
(Rev C1 board w EFG) 24MHz/4 = 6MHz
// also 24MHz clock rev C board w EFM (weird - went back to C. rev D also
is EFM but with Osc)
#pragma config UPLLFSEL = FREQ_24MHZ // USB PLL Input Frequency Selection (USB PLL input
is 24 MHz)
#else
#pragma config FPLLIDIV = DIV_2 // System PLL Input Divider (2x Divider) for 12 MHz crystal (Rev B and C boards w ECG) 12MHz/2 = 6MHz
#pragma config UPLLEN = OFF // USB PLL Enable (USB PLL is disabled)
#endif
#pragma config FPLLRNG = RANGE_5_10_MHZ // System PLL Input Range (5-10 MHz Input)
#pragma config FPLLICLK = PLL_POSC // System PLL Input Clock Selection (POSC is input to the System PLL)
#pragma config FPLLMULT = MUL_112 // System PLL Multiplier (PLL Multiply by 112) 6MHz * 112 = 672MHz
#pragma config FPLLODIV = DIV_8 // System PLL Output Clock Divider (8x Divider) 672MHz / 2 = 84MHz
// DEVCFG1
#pragma config FNOSC = SPLL // Oscillator Selection Bits (Primary Osc (HS,EC))
#pragma config FSOSCEN = OFF // Secondary Oscillator Enable (Disable SOSC)
#if defined(__32MZ2048EFG144__)
#pragma config POSCMOD = EC // Primary Oscillator Configuration EC - External clock osc
// Rev C1 board w EFG uses an Oscillator (Rev D boards too))
#else
#pragma config POSCMOD = HS // Primary Oscillator Configuration HS - Crystal osc
// Rev B and C (w ECG or EFM) use Crystals
#endif
#pragma config FCKSM = CSDCMD // Clock Switching and Monitor Selection (Clock Switch Disabled, FSCM Disabled)
#pragma config FWDTEN = OFF // Watchdog Timer Enable (WDT Disabled)
#pragma config FDMTEN = OFF // Deadman Timer Enable (Deadman Timer is disabled)
#pragma config DMTINTV = WIN_127_128 // Default DMT Count Window Interval (Window/Interval value is 127/128 counter value)
#pragma config DMTCNT = DMT31 // Max Deadman Timer count = 2^31
// DEVCFG0
#pragma config JTAGEN = OFF // JTAG Enable (JTAG Disabled)
#pragma config ICESEL = ICS_PGx2 // ICD/ICE is on PGEC2/PGED2 pins


#include <xc.h>
#include <math.h>
#include "fourier.h"

#define NSAMP 256                                                                   //number of samples to process
#define TPIN (2 * M_PI/NSAMP)                                                       //used to generate sinusoidal inputs for FFT

float input[NSAMP];
float real_output[NSAMP];
float imaginary_output[NSAMP];
float magnitude[NSAMP];





int main(){
    
    PRECON = (1 & _PRECON_PFMWS_MASK) | ((2 << _PRECON_PREFEN_POSITION) & _PRECON_PREFEN_MASK);     //turn prefetch on & reduce wait states to 1
    
    T2CON = 0X0;                                                                    //clear entire timer 2 control register
    
    PR2 = 0XFFFFFFFF;                                                                //32 bit synchronous clock uses this value for rollover, sooo... this is theoretically no rollover.
    T2CONSET = _T2CON_T32_MASK;                                                     //32 BIT TIMER MODE
    
    //T2CONCLR = _T3CON_TCS_MASK;                                                     //configure for internal peripheral clock use <----also shouldn't have to do this, since it will already be 0, having been cleared above
    
    
    SYSKEY = 0;                                                                     //LOCK
    SYSKEY = 0xAA996655;                                                            //WRITE KEY 1
    SYSKEY = 0x556699AA;                                                            //WRITE KEY 2
    PB3DIV = _PB3DIV_ON_MASK | 0 & _PB3DIV_ON_MASK;                                 //DIV BY 0 so that PBCLK3 has 1:1 prescaling from SYSCLK
    SYSKEY = 0;                                                                     //RELOCK
    
    float frequency = 8.0;                                                          //arbitrary unsampled frequency
            for (int n = 0; n < NSAMP; n++){                                        //initialize input array with sine wave values                   
        input[n] = 256 * sin(frequency * TPIN * n);             
        
    }
                                                                         
    
                                                          
    float imaginary_in_null[NSAMP] = {0.0};                                         //create a dummy array to pass to the fft_float routine 
                                                                                   
    
    for (int i = 0; i < 2; i++){
        TMR2 = 0x0;                                                                     //clear timer value to ensure starting from 0
        T2CONSET = _T2CON_ON_MASK;                                                      //start the timer!
        fft_float(NSAMP, 0, input, imaginary_in_null, real_output, imaginary_output);   //pass all necessary values to the FFT routine
        int dummy = i;
        T2CONCLR = _T2CON_ON_MASK;
        for (int n = 0; n < NSAMP; n++){                                                //clearing these values to prevent overflow?
            real_output[n] = 0.0;
            imaginary_output[n] = 0.0;
        }
    }                                                    
    
    for (int n = 0; n < NSAMP; n++){
        magnitude[n] = sqrt((real_output[n] * real_output[n]) + (imaginary_output[n] * imaginary_output[n]));           //calculate the magnitude values
    }
    
    return 0;
}