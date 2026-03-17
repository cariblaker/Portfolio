#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"

// Make some defines
#define HW_REGS_BASE	( ALT_STM_OFST )
#define HW_REGS_SPAN	( 0x04000000 )
#define HW_REGS_MASK	( HW_REGS_SPAN - 1 )

int main ( void )
{
	int retVal = 0;                         //return value  
	int fd = 0;                             //file descriptor
	void * virtual_base = NULL;
	void * led_addr = NULL;
	
	// Map the Address Space for LED register
	if ( ( fd = open ( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 )
	{
		printf ( "ERROR: Could not open \"/dev/mem\"...\r\n" );
		retVal = 1;
	}
	else
	{
		virtual_base = mmap ( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );
		
		if ( virtual_base == MAP_FAILED )
		{
			printf ( "ERROR: mmap() failed...\r\n" );
			close ( fd );
			retVal = 1;
		}
		else
		{
			led_addr = virtual_base + ( ( unsigned long )( ALT_LWFPGASLVS_OFST + LEDS_BASE ) & ( unsigned long )( HW_REGS_MASK ) );
			
			*( uint32_t * ) led_addr = 0x3ff;
			
			usleep ( 1000 * 1000 );
			
			*( uint32_t * )led_addr = 0x000;
			
			// Cleanup
			if ( munmap ( virtual_base, HW_REGS_SPAN ) != 0 )
			{
				printf ( "ERROR: munmap() failed...\r\n" );
				retVal = 1;
			}
			
			close ( fd );
		}
	}
	return retVal;
}

