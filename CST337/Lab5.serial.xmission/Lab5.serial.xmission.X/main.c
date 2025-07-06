
//Lab5 CST337
//Cari Blaker
//This lab writes and reads data from and to the 25LC256 32Kbyte SPI serial EEProm


// PIC32MZ2048ECG144, EFM144 or or EFG144 based HMZ144 board Configuration Bit Settings
// DEVCFG2
#if defined(__32MZ2048EFG144__) || defined(__32MZ2048EFM144__)
#pragma config FPLLIDIV = DIV_4 // System PLL Input Divider (4x Divider) for 24MHz clock
(Rev C1 board w EFG) 24MHz / 4 = 6MHz // also 24MHz clock rev C board w EFM (weird - went back to C. rev D also is EFM but with Osc)
#pragma config UPLLFSEL = FREQ_24MHZ // USB PLL Input Frequency Selection (USB PLL input is 24 MHz)
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
        
const uint8_t WRITE = 0b00000010;
const uint8_t READ = 0b00000011;
const uint8_t WRITE_ENABLE = 0b00000110;
const uint8_t READ_STATUS = 0b00000101;
const uint8_t WRITE_STATUS = 0b00000001;

const uint8_t WIP = 0x01;
const uint8_t WEL = 0x02;

const uint8_t DUMMY = 0b11110000;

        
uint8_t readStatus();
uint8_t read(uint16_t);
void write(uint16_t, uint8_t);
void writeEnable();


int main() {
    //turn prefetch on & reduce wait states to 1
    PRECON = (1 & _PRECON_PFMWS_MASK) | ((2 << _PRECON_PREFEN_POSITION) & _PRECON_PREFEN_MASK);     

    //clock configuration
    SYSKEY = 0;                                                 //LOCK
    SYSKEY = 0xAA996655;                                        //WRITE KEY 1
    SYSKEY = 0x556699AA;                                        //WRITE KEY 2
    PB2DIV = _PB2DIV_ON_MASK | 0 & _PB2DIV_PBDIV_MASK;          //DIV BY 0 so that PBCLK3 has 1:1 prescaling from SYSCLK
    SYSKEY = 0;                                                 //RELOCK
    
    
    //turn off analog functionality of RPB3 before mapping it
    ANSELBCLR = 0x8;                                            //clear bit 3 in the ANSELB register
    
    
    //PPS register mapping for input/output
    SDI4R = 0b1000;                                             //SDI4 mapped to RPB3
    RPF2R = 0b1000;                                             //SD04 mapped to RPF2
    
    
    //disable all SPI4 interrupts before configuring SPI4
    //IEC5CLR = _IEC5_SPI4EIE_MASK | _IEC5_SPI4TXIE_MASK | _IEC5_SPI4RXIE_MASK;  
    
    
    //SPI4 configuration
    LATFSET = _LATF_LATF8_MASK;                                 //set LATF bit 8 to ensure CS line is driven high, leaving 25LC256 un-selected, safeguard to high before enabling for output
    SPI4CON = _SPI4CON_MSTEN_MASK | _SPI4CON_CKP_MASK;          //turn SPI4 off, enable master, un-framed, 8-bit, SMP 0, CKE 0, & CKP 1, MSSEN bit cleared (that and above and below lines to configure software control of CS)
    TRISFCLR = _TRISF_TRISF8_MASK;                              //clear TRISF bit 8 to enable CS line for output
    
    SPI4BRG = 8;                                               //84M/(2*20+1) = 2.0487804878048780 MHz... 84M/(2*(7+1)) = 4.67 MHz, which is a 214.29 ns period
    
    //IFS5CLR = _IFS5_SPI4RXIF_MASK;                            //clear any pending RX interrupts
    
    //this is where further interrupt configuration should go when using that method instead of polling
    
    SPI4BUF;                                                    //read/clear any data from SPI4BUF to start clean
    SPI4STATCLR = _SPI4STAT_SPIROV_MASK;                        //clear any previous overflow
 
    
    //Turn on the SPI unit!
    SPI4CONSET = _SPI4CON_ON_MASK; 
    
    uint16_t address1 = 0xCCCC;
    uint8_t data1 = 0xCC;
    
    uint8_t byte_read = 0;
    
    uint8_t unwritten_read = read(address1);
    int whatever1 = 1;
    
    write(address1, data1);
    
    byte_read = read(address1);
    int whatever = 0;
}


uint8_t readStatus(){
    //1.
    LATFCLR = _LATF_LATF8_MASK;                                             //assert CS line
    //2.
    SPI4BUF = READ_STATUS;                                                  //write read status command to SPI4BUF, which gets xmitted to 25LC256
    //3.
    while ( !(SPI4STAT & _SPI4STAT_SPITBE_MASK) );                          //wait for transmit buffer empty
    //4.
    SPI4BUF = DUMMY;                                                        //clock out dummy data in order to receive real data
    //5.
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for receive buffer full
    //6.
    SPI4BUF;                                                                //read dummy data sent while read status was sent
    //7.
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF from dummy data sent
    //8.
    int buff_read = SPI4BUF;                                                //read status byte now here while dummy data clocked out at step 3
    //9.
    LATFSET = _LATF_LATF8_MASK;                                             //negate CS
    
    return buff_read;
}   //end of read_status


void writeEnable(){
    LATFCLR = _LATF_LATF8_MASK;                                             //assert CS line
    SPI4BUF = WRITE_ENABLE;                                                 //send the write enable command
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    SPI4BUF;                                                                //read dummy data
    LATFSET = _LATF_LATF8_MASK;                                             //negate CS line
}   //end of writeEnable())


void write(uint16_t address, uint8_t data){
    while (readStatus() & WIP);                                             //ensure there is not a write already in progress
    writeEnable();                                                          //enable write
    
    LATFCLR = _LATF_LATF8_MASK;                                             //assert CS line
    SPI4BUF = WRITE;                                                        //send write command
    uint8_t upper = (uint8_t)(address >> 8);                                //prepare upper 8 bits of the address to send next
    while ( !(SPI4STAT & _SPI4STAT_SPITBE_MASK) );                          //wait for transmit buffer empty
    
    uint8_t lower = (uint8_t)(address & 0xFF);                              //prepare lower 8 bits of address to send next
    SPI4BUF = upper;                                                        //send most significant address byte
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
        
    uint8_t read_buff = SPI4BUF;                                            //read dummy coming from write command
    SPI4BUF = lower;                                                        //send least significant address byte (writing to address 0x00000000 here))
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF;                                                    //read dummy coming from LSaddress sent
    SPI4BUF = data;                                                         //send data to write
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF;                                                    //read dummy coming in from MSaddress sent
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF;                                                    //read dummy coming in from data sent
    LATFSET = _LATF_LATF8_MASK;                                             //negate CS line
    
}


uint8_t read(uint16_t address){
    while (readStatus() & WIP);                                   //ensure there is not a write already in progress
    
    LATFCLR = _LATF_LATF8_MASK;                                             //assert CS line
    SPI4BUF = READ;                                                         //send read command
    uint8_t upper = (uint8_t)(address >> 8);                                //prepare upper 8 bits of the address to send next
    while ( !(SPI4STAT & _SPI4STAT_SPITBE_MASK) );                          //wait for transmit buffer empty
    
    SPI4BUF = upper;                                                        //send most significant address
    uint8_t lower = (uint8_t)(address);                                     //prepare lower 8 bits of address to send next
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    uint16_t read_buff = SPI4BUF;                                            //read dummy coming from read command
    SPI4BUF = lower;                                                        //send least significant address byte
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF;                                                    //read dummy coming from MSA
    SPI4BUF = DUMMY;                                                        //write a dummy for ultimate receival of real data                                                
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF;                                                    //read dummy coming from LSA
    SPI4BUF = DUMMY;                                                        //write another dummy for receival of real data byte 2
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = SPI4BUF << 8;                                               //real data byte 1
    while ( !(SPI4STAT & _SPI4STAT_SPIRBF_MASK) );                          //wait for RBF
    
    read_buff = read_buff | SPI4BUF;                                        //real data byte 2
    
    LATFSET = _LATF_LATF8_MASK;                                             //negate CS line 
    return read_buff;
}   //end of read()

