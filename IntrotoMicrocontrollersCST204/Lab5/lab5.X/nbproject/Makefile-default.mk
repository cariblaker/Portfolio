#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S C:/Users/carib/CST204/Lab5/lab5.X/source/data.S C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S C:/Users/carib/CST204/Lab5/lab5.X/source/main.S C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1114508679/app_heartbeat.o ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o ${OBJECTDIR}/_ext/1114508679/config_bits.o ${OBJECTDIR}/_ext/1114508679/data.o ${OBJECTDIR}/_ext/1114508679/hardware.o ${OBJECTDIR}/_ext/1114508679/keypad.o ${OBJECTDIR}/_ext/1114508679/main.o ${OBJECTDIR}/_ext/1114508679/svc_keypad.o ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o ${OBJECTDIR}/_ext/1114508679/isr_timer1.o ${OBJECTDIR}/_ext/1114508679/isr_timer32.o ${OBJECTDIR}/_ext/1114508679/blinky_lights.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o.d ${OBJECTDIR}/_ext/1114508679/config_bits.o.d ${OBJECTDIR}/_ext/1114508679/data.o.d ${OBJECTDIR}/_ext/1114508679/hardware.o.d ${OBJECTDIR}/_ext/1114508679/keypad.o.d ${OBJECTDIR}/_ext/1114508679/main.o.d ${OBJECTDIR}/_ext/1114508679/svc_keypad.o.d ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o.d ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d ${OBJECTDIR}/_ext/1114508679/blinky_lights.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1114508679/app_heartbeat.o ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o ${OBJECTDIR}/_ext/1114508679/config_bits.o ${OBJECTDIR}/_ext/1114508679/data.o ${OBJECTDIR}/_ext/1114508679/hardware.o ${OBJECTDIR}/_ext/1114508679/keypad.o ${OBJECTDIR}/_ext/1114508679/main.o ${OBJECTDIR}/_ext/1114508679/svc_keypad.o ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o ${OBJECTDIR}/_ext/1114508679/isr_timer1.o ${OBJECTDIR}/_ext/1114508679/isr_timer32.o ${OBJECTDIR}/_ext/1114508679/blinky_lights.o

# Source Files
SOURCEFILES=C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S C:/Users/carib/CST204/Lab5/lab5.X/source/data.S C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S C:/Users/carib/CST204/Lab5/lab5.X/source/main.S C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX460F512L
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1114508679/app_heartbeat.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S  .generated_files/flags/default/77f321fcf607a493a5a96376b0e85714640f6d52 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/config_bits.o: C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S  .generated_files/flags/default/f1f76009a70d33e5135bbb2ff6431867a0667d1a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o.ok ${OBJECTDIR}/_ext/1114508679/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1114508679/config_bits.o C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/config_bits.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/config_bits.o.d" "${OBJECTDIR}/_ext/1114508679/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/data.o: C:/Users/carib/CST204/Lab5/lab5.X/source/data.S  .generated_files/flags/default/bed6cdfa0701749bb6e685da116cf7e8cff99221 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o.ok ${OBJECTDIR}/_ext/1114508679/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/data.o.d"  -o ${OBJECTDIR}/_ext/1114508679/data.o C:/Users/carib/CST204/Lab5/lab5.X/source/data.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/data.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/data.o.d" "${OBJECTDIR}/_ext/1114508679/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/hardware.o: C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S  .generated_files/flags/default/f791023fb4e9d1ed1e992deb9434fa407020fb1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o.ok ${OBJECTDIR}/_ext/1114508679/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/hardware.o.d"  -o ${OBJECTDIR}/_ext/1114508679/hardware.o C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/hardware.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/hardware.o.d" "${OBJECTDIR}/_ext/1114508679/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S  .generated_files/flags/default/37cb75aa3847f6717cd6ec2f26cda91a705311e2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o.ok ${OBJECTDIR}/_ext/1114508679/keypad.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/keypad.o.d"  -o ${OBJECTDIR}/_ext/1114508679/keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/keypad.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/keypad.o.d" "${OBJECTDIR}/_ext/1114508679/keypad.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/main.o: C:/Users/carib/CST204/Lab5/lab5.X/source/main.S  .generated_files/flags/default/c97b134111a91920694c5778ff4302425d1eb809 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o.ok ${OBJECTDIR}/_ext/1114508679/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/main.o.d"  -o ${OBJECTDIR}/_ext/1114508679/main.o C:/Users/carib/CST204/Lab5/lab5.X/source/main.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/main.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/main.o.d" "${OBJECTDIR}/_ext/1114508679/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/isr_timer1.o: C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S  .generated_files/flags/default/f835218995d6e075c427f1f97dd25ba09f00d237 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.ok ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d"  -o ${OBJECTDIR}/_ext/1114508679/isr_timer1.o C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/isr_timer1.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d" "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/isr_timer32.o: C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S  .generated_files/flags/default/ac3a9bc7c663b9c83c12311708211eb98f30a024 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.ok ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d"  -o ${OBJECTDIR}/_ext/1114508679/isr_timer32.o C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/isr_timer32.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d" "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/_ext/1114508679/app_heartbeat.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S  .generated_files/flags/default/23d9e4fe4569f340b719c88637d99e823d315a3e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1114508679/app_heartbeat.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_heartbeat.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1114508679/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/config_bits.o: C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S  .generated_files/flags/default/d8be751dc4b9c63a1d59715a841f5f0e6a9c52bd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/config_bits.o.ok ${OBJECTDIR}/_ext/1114508679/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1114508679/config_bits.o C:/Users/carib/CST204/Lab5/lab5.X/source/config_bits.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/config_bits.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/config_bits.o.d" "${OBJECTDIR}/_ext/1114508679/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/data.o: C:/Users/carib/CST204/Lab5/lab5.X/source/data.S  .generated_files/flags/default/a82bec3c4a9ca04bf430e7bfd8874fe488e978dc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/data.o.ok ${OBJECTDIR}/_ext/1114508679/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/data.o.d"  -o ${OBJECTDIR}/_ext/1114508679/data.o C:/Users/carib/CST204/Lab5/lab5.X/source/data.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/data.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/data.o.d" "${OBJECTDIR}/_ext/1114508679/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/hardware.o: C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S  .generated_files/flags/default/7263b2d0d3f31f0bb9f28db409bf7e5e78c6f0bc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/hardware.o.ok ${OBJECTDIR}/_ext/1114508679/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/hardware.o.d"  -o ${OBJECTDIR}/_ext/1114508679/hardware.o C:/Users/carib/CST204/Lab5/lab5.X/source/hardware.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/hardware.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/hardware.o.d" "${OBJECTDIR}/_ext/1114508679/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S  .generated_files/flags/default/1eb24b850d5ec0c19c42af2f812848a1acd27a90 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/keypad.o.ok ${OBJECTDIR}/_ext/1114508679/keypad.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/keypad.o.d"  -o ${OBJECTDIR}/_ext/1114508679/keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/keypad.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/keypad.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/keypad.o.d" "${OBJECTDIR}/_ext/1114508679/keypad.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/main.o: C:/Users/carib/CST204/Lab5/lab5.X/source/main.S  .generated_files/flags/default/e914e90d4ad12b7666821a834083167773eb0501 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/main.o.ok ${OBJECTDIR}/_ext/1114508679/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/main.o.d"  -o ${OBJECTDIR}/_ext/1114508679/main.o C:/Users/carib/CST204/Lab5/lab5.X/source/main.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/main.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/main.o.d" "${OBJECTDIR}/_ext/1114508679/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/isr_timer1.o: C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S  .generated_files/flags/default/f50100312c7796db94fa2ddfc3a8ebdb76cdfd82 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.ok ${OBJECTDIR}/_ext/1114508679/isr_timer1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d"  -o ${OBJECTDIR}/_ext/1114508679/isr_timer1.o C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/isr_timer1.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.d" "${OBJECTDIR}/_ext/1114508679/isr_timer1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1114508679/isr_timer32.o: C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S  .generated_files/flags/default/df2694e67a84eb6547e85b14d017511914763006 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o 
	@${RM} ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.ok ${OBJECTDIR}/_ext/1114508679/isr_timer32.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d"  -o ${OBJECTDIR}/_ext/1114508679/isr_timer32.o C:/Users/carib/CST204/Lab5/lab5.X/source/isr_timer32.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1114508679/isr_timer32.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.d" "${OBJECTDIR}/_ext/1114508679/isr_timer32.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1114508679/app_test_keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c  .generated_files/flags/default/adbe04a168cfed01094e50aa5442c50e04345e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_test_keypad.o.d" -o ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/svc_keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c  .generated_files/flags/default/422fba792e0b425fa572b4183e16779382cbd8fa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/svc_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/svc_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/svc_keypad.o.d" -o ${OBJECTDIR}/_ext/1114508679/svc_keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/app_test_timer32.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c  .generated_files/flags/default/f55b593199676fde2722c3a3035ec89d94ec1052 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_test_timer32.o.d" -o ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/blinky_lights.o: C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c  .generated_files/flags/default/3fc5f06eea4e2e1b220135288cf94ef964ea5f30 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/blinky_lights.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/blinky_lights.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/blinky_lights.o.d" -o ${OBJECTDIR}/_ext/1114508679/blinky_lights.o C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/_ext/1114508679/app_test_keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c  .generated_files/flags/default/79b90085f0135562517bbfafa0f8af04b837c930 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_test_keypad.o.d" -o ${OBJECTDIR}/_ext/1114508679/app_test_keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/svc_keypad.o: C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c  .generated_files/flags/default/c5236e635bf33b6cc8234b19b2326efac7232fb9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/svc_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/svc_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/svc_keypad.o.d" -o ${OBJECTDIR}/_ext/1114508679/svc_keypad.o C:/Users/carib/CST204/Lab5/lab5.X/source/svc_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/app_test_timer32.o: C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c  .generated_files/flags/default/578cd1ac4105c6836b571d7d35a806af1a783050 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/app_test_timer32.o.d" -o ${OBJECTDIR}/_ext/1114508679/app_test_timer32.o C:/Users/carib/CST204/Lab5/lab5.X/source/app_test_timer32.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1114508679/blinky_lights.o: C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c  .generated_files/flags/default/ffdcf4eaf714383fa486c78d370db1515cc6fed5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1114508679" 
	@${RM} ${OBJECTDIR}/_ext/1114508679/blinky_lights.o.d 
	@${RM} ${OBJECTDIR}/_ext/1114508679/blinky_lights.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1114508679/blinky_lights.o.d" -o ${OBJECTDIR}/_ext/1114508679/blinky_lights.o C:/Users/carib/CST204/Lab5/lab5.X/source/blinky_lights.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g -mdebugger -D__MPLAB_DEBUGGER_ICD4=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x0:0x1FC -mreserve=boot@0x1FC02000:0x1FC02FEF -mreserve=boot@0x1FC02000:0x1FC024FF  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=__MPLAB_DEBUGGER_ICD4=1,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/lab5.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/lab5.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/lab5.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
