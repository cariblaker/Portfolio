/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'NiosV_FreeRTOS' in SOPC Builder design 'Midterm'
 * SOPC Builder design path: ../../Midterm.sopcinfo
 *
 * Generated: Fri Nov 08 12:11:20 PST 2024
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * BUTTONS_0 configuration
 *
 */

#define ALT_MODULE_CLASS_BUTTONS_0 BUTTONS
#define BUTTONS_0_BASE 0x4010040
#define BUTTONS_0_IRQ -1
#define BUTTONS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BUTTONS_0_NAME "/dev/BUTTONS_0"
#define BUTTONS_0_SPAN 16
#define BUTTONS_0_TYPE "BUTTONS"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "intel_niosv_m"
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_DATA_ADDR_WIDTH 0x20
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HAS_CSR_SUPPORT 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x20
#define ALT_CPU_MTIME_OFFSET 0x04010000
#define ALT_CPU_NAME "NiosV_FreeRTOS"
#define ALT_CPU_NIOSV_CORE_VARIANT 1
#define ALT_CPU_NUM_GPR 32
#define ALT_CPU_RESET_ADDR 0x00000000
#define ALT_CPU_TICKS_PER_SEC NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND
#define ALT_CPU_TIMER_DEVICE_TYPE 2


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define ABBOTTSLAKE_CPU_FREQ 50000000u
#define ABBOTTSLAKE_DATA_ADDR_WIDTH 0x20
#define ABBOTTSLAKE_DCACHE_LINE_SIZE 0
#define ABBOTTSLAKE_DCACHE_LINE_SIZE_LOG2 0
#define ABBOTTSLAKE_DCACHE_SIZE 0
#define ABBOTTSLAKE_HAS_CSR_SUPPORT 1
#define ABBOTTSLAKE_HAS_DEBUG_STUB
#define ABBOTTSLAKE_ICACHE_LINE_SIZE 0
#define ABBOTTSLAKE_ICACHE_LINE_SIZE_LOG2 0
#define ABBOTTSLAKE_ICACHE_SIZE 0
#define ABBOTTSLAKE_INST_ADDR_WIDTH 0x20
#define ABBOTTSLAKE_MTIME_OFFSET 0x04010000
#define ABBOTTSLAKE_NIOSV_CORE_VARIANT 1
#define ABBOTTSLAKE_NUM_GPR 32
#define ABBOTTSLAKE_RESET_ADDR 0x00000000
#define ABBOTTSLAKE_TICKS_PER_SEC NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND
#define ABBOTTSLAKE_TIMER_DEVICE_TYPE 2


/*
 * DEBUG configuration
 *
 */

#define ALT_MODULE_CLASS_DEBUG altera_avalon_jtag_uart
#define DEBUG_BASE 0x40100d0
#define DEBUG_IRQ 0
#define DEBUG_IRQ_INTERRUPT_CONTROLLER_ID 0
#define DEBUG_NAME "/dev/DEBUG"
#define DEBUG_READ_DEPTH 64
#define DEBUG_READ_THRESHOLD 8
#define DEBUG_SPAN 8
#define DEBUG_TYPE "altera_avalon_jtag_uart"
#define DEBUG_WRITE_DEPTH 64
#define DEBUG_WRITE_THRESHOLD 8


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __BUTTONS
#define __INTEL_NIOSV_M
#define __LEDS
#define __SEG7S
#define __SWITCHES


/*
 * LEDs configuration
 *
 */

#define ALT_MODULE_CLASS_LEDs LEDs
#define LEDS_BASE 0x4010050
#define LEDS_IRQ -1
#define LEDS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LEDS_NAME "/dev/LEDs"
#define LEDS_SPAN 16
#define LEDS_TYPE "LEDs"


/*
 * SDRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SDRAM altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x0
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/SDRAM"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 67108864
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.4
#define SDRAM_T_MRD 2
#define SDRAM_T_RCD 15.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 15.0
#define SDRAM_T_WR 14.0


/*
 * SEG7s_0 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_0 SEG7s
#define SEG7S_0_BASE 0x40100c0
#define SEG7S_0_IRQ -1
#define SEG7S_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_0_NAME "/dev/SEG7s_0"
#define SEG7S_0_SPAN 16
#define SEG7S_0_TYPE "SEG7s"


/*
 * SEG7s_1 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_1 SEG7s
#define SEG7S_1_BASE 0x40100b0
#define SEG7S_1_IRQ -1
#define SEG7S_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_1_NAME "/dev/SEG7s_1"
#define SEG7S_1_SPAN 16
#define SEG7S_1_TYPE "SEG7s"


/*
 * SEG7s_2 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_2 SEG7s
#define SEG7S_2_BASE 0x40100a0
#define SEG7S_2_IRQ -1
#define SEG7S_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_2_NAME "/dev/SEG7s_2"
#define SEG7S_2_SPAN 16
#define SEG7S_2_TYPE "SEG7s"


/*
 * SEG7s_3 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_3 SEG7s
#define SEG7S_3_BASE 0x4010090
#define SEG7S_3_IRQ -1
#define SEG7S_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_3_NAME "/dev/SEG7s_3"
#define SEG7S_3_SPAN 16
#define SEG7S_3_TYPE "SEG7s"


/*
 * SEG7s_4 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_4 SEG7s
#define SEG7S_4_BASE 0x4010080
#define SEG7S_4_IRQ -1
#define SEG7S_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_4_NAME "/dev/SEG7s_4"
#define SEG7S_4_SPAN 16
#define SEG7S_4_TYPE "SEG7s"


/*
 * SEG7s_5 configuration
 *
 */

#define ALT_MODULE_CLASS_SEG7s_5 SEG7s
#define SEG7S_5_BASE 0x4010070
#define SEG7S_5_IRQ -1
#define SEG7S_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SEG7S_5_NAME "/dev/SEG7s_5"
#define SEG7S_5_SPAN 16
#define SEG7S_5_TYPE "SEG7s"


/*
 * SWITCHES_0 configuration
 *
 */

#define ALT_MODULE_CLASS_SWITCHES_0 SWITCHES
#define SWITCHES_0_BASE 0x4010060
#define SWITCHES_0_IRQ -1
#define SWITCHES_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SWITCHES_0_NAME "/dev/SWITCHES_0"
#define SWITCHES_0_SPAN 16
#define SWITCHES_0_TYPE "SWITCHES"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/DEBUG"
#define ALT_STDERR_BASE 0x40100d0
#define ALT_STDERR_DEV DEBUG
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/DEBUG"
#define ALT_STDIN_BASE 0x40100d0
#define ALT_STDIN_DEV DEBUG
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/DEBUG"
#define ALT_STDOUT_BASE 0x40100d0
#define ALT_STDOUT_DEV DEBUG
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "Midterm"
#define ALT_SYS_CLK_TICKS_PER_SEC ALT_CPU_TICKS_PER_SEC
#define ALT_TIMESTAMP_CLK_TIMER_DEVICE_TYPE ALT_CPU_TIMER_DEVICE_TYPE


/*
 * freertos configuration
 *
 */

#define HEAP_METHOD 4
#define OS_CHECK_STACK_OVERFLOW 1
#define OS_COUNTING_SEM_EN 1
#define OS_IDLE_SHOULD_YEILD 0
#define OS_MALLOC_FAILED_HOOK_EN 0
#define OS_MAX_PRIORITIES 7
#define OS_MAX_TASK_NAME_LEN 16
#define OS_MEMORY_DYNAMIC_ALLOCATION_EN 1
#define OS_MIN_STACK_SIZE 300
#define OS_MUTEX_EN 1
#define OS_PORT_HAS_MTIME 1
#define OS_Q_REG_SIZE 8
#define OS_RECURSIVE_MUTEX_EN 1
#define OS_SEMAPHORE_GET_MUTEX_HOLDER_EN 1
#define OS_TASK_ABORT_DELAY_EN 1
#define OS_TASK_CLEAN_UP_RESOURCES_EN 1
#define OS_TASK_DELAY_EN 1
#define OS_TASK_DELAY_UNTIL_EN 1
#define OS_TASK_DELETE_EN 1
#define OS_TASK_GET_HANDLE_EN 1
#define OS_TASK_GET_STATE_EN 1
#define OS_TASK_PRIORITY_GET_EN 1
#define OS_TASK_PRIORITY_SET_EN 1
#define OS_TASK_SUSPEND_EN 1
#define OS_THREAD_SAFE_C_LIBRARY 1
#define OS_TICKS_PER_SEC ALT_SYS_CLK_TICKS_PER_SEC
#define OS_TIMER_PEND_FUNCTION_CALL_EN 1
#define OS_TIMER_QUEUE_LEN 8
#define OS_TIMER_TASK_DEPTH 160
#define OS_TLS_BYTES_PER_TASK 256
#define OS_TOTAL_HEAP_SIZE 80000
#define OS_USE_16_BIT_TICKS 0
#define OS_USE_IDLE_HOOK 0
#define OS_USE_PREEMPTION 1
#define OS_USE_QUEUE_SETS 1
#define OS_USE_TICK_HOOK 1
#define OS_USE_TIMERS 1
#define OS_USE_TRACE_FACILITY 1


/*
 * hal2 configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK NIOSV_FREERTOS
#define ALT_TIMESTAMP_CLK NIOSV_FREERTOS
#define INTEL_FPGA_DFL_START_ADDRESS 0xffffffffffffffff
#define INTEL_FPGA_USE_DFL_WALKER 0


/*
 * intel_niosv_m_freertos_driver configuration
 *
 */

#define NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND 1000

#endif /* __SYSTEM_H_ */
