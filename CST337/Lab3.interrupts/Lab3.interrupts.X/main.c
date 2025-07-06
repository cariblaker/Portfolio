
//Lab3 CST337
//Cari Blaker
//This lab aims to practice controlling interrupts on a PIC32MZ ECG microcontroller


// PIC32MZ2048ECG144, EFM144 or or EFG144 based HMZ144 board Configuration Bit Settings
// DEVCFG2
#if defined(__32MZ2048EFG144__) || defined(__32MZ2048EFM144__)
#pragma config FPLLIDIV = DIV_4 // System PLL Input Divider (4x Divider) for 24MHz clock
(Rev C1 board w EFG) 24MHz / 4 = 6MHz
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
#include <sys/attribs.h>
int CNT_ISR;
int TMR3_CNT;

int main() {

    SYSKEY = 0;                                                 //LOCK
    SYSKEY = 0xAA996655;                                        //WRITE KEY 1
    SYSKEY = 0x556699AA;                                        //WRITE KEY 2
    PB3DIV = _PB3DIV_ON_MASK | 0 & _PB3DIV_PBDIV_MASK;          //DIV BY 0 so that PBCLK3 has 1:1 prescaling from SYSCLK
    SYSKEY = 0;                                                 //RELOCK

    PRECON = (1 & _PRECON_PFMWS_MASK) | ((2 << _PRECON_PREFEN_POSITION) & _PRECON_PREFEN_MASK); //turn prefetch on & reduce wait states to 1

    PR2 = 511;                                                  //32 bit synchronous clock for timer2 uses this value for rollover
    PR3 = 999;                                                 //timer3's rollover value
    TMR2 = 0x0;                                                 //make sure timers start from 0
    TMR3 = 0x0;                                                 
    T2CON = 0x0;                                                //clear entire timer 2 control register, which means it's off, 1:1` prescaling, 16 bit timer
    T3CON = 0x0;                                                //clear timer 3 control register

    asm("di");                                                  //disable interrupts globally
    
    IEC0SET = _IEC0_T2IE_MASK;                                  //enable timer2 interrupts
    IEC0SET = _IEC0_T3IE_MASK;                                  
    
    IPC2CLR = _IPC2_T2IP_MASK | _IPC2_T2IS_MASK;                //clear T2 priority & subpriority fields 
    IPC2SET = (4 << _IPC2_T2IP_POSITION) & _IPC2_T2IP_MASK;     //establish priority of T2 ISR (4, sub 0)
    IPC3CLR = _IPC3_T3IP_MASK | _IPC3_T3IS_MASK;                //clear T3 priority & subpriority fields
    IPC3SET = (2 << _IPC3_T3IP_POSITION) & _IPC3_T3IP_MASK;     //establish priority of T3 ISR (2, sub 0)

    CNT_ISR = 0;                                                //start the incrementer for timer 2 ISR at 0
    TMR3_CNT = 0;                                               //start timer3 incrementer at 0
    IFS0CLR = _IFS0_T2IF_MASK;                                  //clear timer2 interrupt flag    
    
    asm("ei");                                                  //turn on interrupts (globally)
    
    T2CONSET = _T2CON_ON_MASK;                                  //start the timer!
    T3CONSET = _T3CON_ON_MASK;
    IFS0SET = _IFS0_T3IF_MASK;
    for(int i = 0; i < 2; i++){                                 //to sync the timers, run twice to get this instruction cached which Has displayed a 5 cycle latency
        TMR2 = 0;
        TMR3 = 5;
    }
    
    IFS0SET = _IFS0_T2IF_MASK | _IFS0_T3IF_MASK;                //set the both timer interrupt flags
  
    
    while (1);

}

void __ISR_AT_VECTOR(0, RIPL) TimerHandler(void) {
    CNT_ISR += 1;                                               //increment the number of times it gets to this service routine
    if (IFS0 & _IFS0_T2IF_MASK == _IFS0_T2IF_MASK){
        IFS0CLR = _IFS0_T2IF_MASK; 
    }
    else if (IFS0 &_IFS0_T3IF_MASK == _IFS0_T3IF_MASK){
        IFS0CLR = _IFS0_T3IF_MASK;
    }
}




