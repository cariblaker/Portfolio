//lab 1 CST 337
//Cari Blaker
//introduction to using C on the PIC32--blinking LED


// PIC32MZ2048ECG144, EFM144 or or EFG144 based HMZ144 board Configuration Bit Settings
// DEVCFG2
#if defined(__32MZ2048EFG144__) || defined(__32MZ2048EFM144__)
#pragma config FPLLIDIV = DIV_4         // System PLL Input Divider (4x Divider) for 24MHz clock (Rev C1 board w EFG) 24MHz/4 = 6MHz
                                        // also 24MHz clock rev C board w EFM (weird - went back to C. rev D also is EFM but with Osc)
#pragma config UPLLFSEL = FREQ_24MHZ    // USB PLL Input Frequency Selection (USB PLL input is 24 MHz)
#else
#pragma config FPLLIDIV = DIV_2         // System PLL Input Divider (2x Divider) for 12 MHz crystal (Rev B and C boards w ECG) 12MHz/2 = 6MHz
#pragma config UPLLEN = OFF             // USB PLL Enable (USB PLL is disabled)
#endif
#pragma config FPLLRNG = RANGE_5_10_MHZ // System PLL Input Range (5-10 MHz Input)
#pragma config FPLLICLK = PLL_POSC      // System PLL Input Clock Selection (POSC is input to the System PLL)
#pragma config FPLLMULT = MUL_112       // System PLL Multiplier (PLL Multiply by 112) 6MHz * 112 = 672MHz
#pragma config FPLLODIV = DIV_8         // System PLL Output Clock Divider (8x Divider) 672MHz / 2 = 84MHz

// DEVCFG1
#pragma config FNOSC = SPLL             // Oscillator Selection Bits (Primary Osc (HS,EC))
#pragma config FSOSCEN = OFF            // Secondary Oscillator Enable (Disable SOSC)
#if defined(__32MZ2048EFG144__)
#pragma config POSCMOD = EC             // Primary Oscillator Configuration EC - External clock osc
                                        // Rev C1 board w EFG uses an Oscillator (Rev D boards too))
#else
#pragma config POSCMOD = HS             // Primary Oscillator Configuration HS - Crystal osc
                                        // Rev B and C (w ECG or EFM) use Crystals
#endif
#pragma config FCKSM = CSDCMD           // Clock Switching and Monitor Selection (Clock Switch Disabled, FSCM Disabled)
#pragma config FWDTEN = OFF             // Watchdog Timer Enable (WDT Disabled)
#pragma config FDMTEN = OFF             // Deadman Timer Enable (Deadman Timer is disabled)
#pragma config DMTINTV = WIN_127_128    // Default DMT Count Window Interval (Window/Interval value is 127/128 counter value)
#pragma config DMTCNT = DMT31           // Max Deadman Timer count = 2^31

// DEVCFG0
#pragma config JTAGEN = OFF             // JTAG Enable (JTAG Disabled)
#pragma config ICESEL = ICS_PGx2        // ICD/ICE is on PGEC2/PGED2 pins (not default)



#include <xc.h>

int HALF_SECOND = 0xA037;                                       //set global half-second value equaling 41,015 in decimal--which should result in one second LED blinks

void endless_blink(void);
void poll_timer(void);

int main(void){

    T2CON = (7 << _T2CON_TCKPS_POSITION);                       //shift the number 7 (111) into the TCKPS position for 1:256 scaling.
    //T2CON SHOULD NOW READ 0x0000070
    
    //SET UP 21MHz PBCLK3--divide system clock by 4, by assigning 3 to pb3div. Must perform unlock sequence to do so.
    SYSKEY = 0;                                                   // Ensure lock
    SYSKEY = 0xAA996655;                                        // Write Key 1
    SYSKEY = 0x556699AA;                                        // Write Key 2
    PB3DIV = _PB3DIV_ON_MASK | 3 & _PB3DIV_PBDIV_MASK;          // 0 = div by 1, 1 = div by 2, 2 =  div by 3 etc up to 128
    SYSKEY = 0; // Re lock

    TMR2 = 0x0;                                                 //clear the timer value
    PR2 = HALF_SECOND;                                          //load timer count number into PR2
    IFS0CLR = _IFS0_T2IF_MASK;                                  //clear the interrupt flag
    
    
    TRISHCLR = _TRISH_TRISH8_MASK;                              //configure RH8 (LED port) for output
    
    T2CONSET = _T2CON_ON_MASK;                                  //start the timer!
    
    poll_timer();                                               //initial call of endless loop
    
    return 0;
}


void endless_blink(void) {                              
    LATHINV =_LATH_LATH8_MASK;                                  //one step bit inversion to turn on/off LED
    poll_timer();
}

void poll_timer(void){
    while (1){          
        if ( (IFS0 && _IFS0_T2IF_MASK) == 1){                   //if the flag is set, we've reached .5 seconds
            IFS0CLR = _IFS0_T2IF_MASK;                          //clear the interrupt flag
            endless_blink();                                    //toggle LED
        }
    }
}