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
FINAL_IMAGE=${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1357343641/app_heartbeat.o ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o ${OBJECTDIR}/_ext/1357343641/config_bits.o ${OBJECTDIR}/_ext/1357343641/data.o ${OBJECTDIR}/_ext/1357343641/hardware.o ${OBJECTDIR}/_ext/1357343641/keypad.o ${OBJECTDIR}/_ext/1357343641/main.o ${OBJECTDIR}/_ext/1357343641/svc_keypad.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o.d ${OBJECTDIR}/_ext/1357343641/config_bits.o.d ${OBJECTDIR}/_ext/1357343641/data.o.d ${OBJECTDIR}/_ext/1357343641/hardware.o.d ${OBJECTDIR}/_ext/1357343641/keypad.o.d ${OBJECTDIR}/_ext/1357343641/main.o.d ${OBJECTDIR}/_ext/1357343641/svc_keypad.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1357343641/app_heartbeat.o ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o ${OBJECTDIR}/_ext/1357343641/config_bits.o ${OBJECTDIR}/_ext/1357343641/data.o ${OBJECTDIR}/_ext/1357343641/hardware.o ${OBJECTDIR}/_ext/1357343641/keypad.o ${OBJECTDIR}/_ext/1357343641/main.o ${OBJECTDIR}/_ext/1357343641/svc_keypad.o

# Source Files
SOURCEFILES=C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c



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
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

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
${OBJECTDIR}/_ext/1357343641/app_heartbeat.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S  .generated_files/flags/default/d3679b9ab6ab6ad6752972ee4efb0545f61653c4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/config_bits.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S  .generated_files/flags/default/dfea51684a8bca1c031793854736c2f920987dea .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o.ok ${OBJECTDIR}/_ext/1357343641/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1357343641/config_bits.o C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/config_bits.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/config_bits.o.d" "${OBJECTDIR}/_ext/1357343641/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/data.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S  .generated_files/flags/default/a44288e7aef6ddf1d29e6fc22239c3056d3d2f58 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o.ok ${OBJECTDIR}/_ext/1357343641/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/data.o.d"  -o ${OBJECTDIR}/_ext/1357343641/data.o C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/data.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/data.o.d" "${OBJECTDIR}/_ext/1357343641/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/hardware.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S  .generated_files/flags/default/8e2dcfb2e75739128187b12f5cc7985bbf6974db .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o.ok ${OBJECTDIR}/_ext/1357343641/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/hardware.o.d"  -o ${OBJECTDIR}/_ext/1357343641/hardware.o C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/hardware.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/hardware.o.d" "${OBJECTDIR}/_ext/1357343641/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S  .generated_files/flags/default/bfe0111afef27f66ffdda38e6b4b954fc8472576 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o.ok ${OBJECTDIR}/_ext/1357343641/keypad.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/keypad.o.d"  -o ${OBJECTDIR}/_ext/1357343641/keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/keypad.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/keypad.o.d" "${OBJECTDIR}/_ext/1357343641/keypad.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/main.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S  .generated_files/flags/default/f83306575d048f4e68a36b86de3ca293b27b1979 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o.ok ${OBJECTDIR}/_ext/1357343641/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/main.o.d"  -o ${OBJECTDIR}/_ext/1357343641/main.o C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/main.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/main.o.d" "${OBJECTDIR}/_ext/1357343641/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/_ext/1357343641/app_heartbeat.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S  .generated_files/flags/default/6097f2c1317107c5ad2a19f7b910438a7112be87 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1357343641/app_heartbeat.o C:/Users/carib/CST204/Lab3/Lab3.X/source/app_heartbeat.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1357343641/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/config_bits.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S  .generated_files/flags/default/580319f56fe068160d15d73c8a17ffc81686b0cc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/config_bits.o.ok ${OBJECTDIR}/_ext/1357343641/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1357343641/config_bits.o C:/Users/carib/CST204/Lab3/Lab3.X/source/config_bits.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/config_bits.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/config_bits.o.d" "${OBJECTDIR}/_ext/1357343641/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/data.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S  .generated_files/flags/default/6adf9db1ba5bca09f33b3b07497133d5af3e667e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/data.o.ok ${OBJECTDIR}/_ext/1357343641/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/data.o.d"  -o ${OBJECTDIR}/_ext/1357343641/data.o C:/Users/carib/CST204/Lab3/Lab3.X/source/data.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/data.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/data.o.d" "${OBJECTDIR}/_ext/1357343641/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/hardware.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S  .generated_files/flags/default/3db15efe88acb2903d042abc65b052746fcfb9cd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/hardware.o.ok ${OBJECTDIR}/_ext/1357343641/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/hardware.o.d"  -o ${OBJECTDIR}/_ext/1357343641/hardware.o C:/Users/carib/CST204/Lab3/Lab3.X/source/hardware.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/hardware.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/hardware.o.d" "${OBJECTDIR}/_ext/1357343641/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S  .generated_files/flags/default/13e62f457b24463b14db7c3233fe5779d3e021f1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/keypad.o.ok ${OBJECTDIR}/_ext/1357343641/keypad.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/keypad.o.d"  -o ${OBJECTDIR}/_ext/1357343641/keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/keypad.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/keypad.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/keypad.o.d" "${OBJECTDIR}/_ext/1357343641/keypad.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1357343641/main.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S  .generated_files/flags/default/e1098c900f03e8622c72732041660676570ef211 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o 
	@${RM} ${OBJECTDIR}/_ext/1357343641/main.o.ok ${OBJECTDIR}/_ext/1357343641/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1357343641/main.o.d"  -o ${OBJECTDIR}/_ext/1357343641/main.o C:/Users/carib/CST204/Lab3/Lab3.X/source/main.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1357343641/main.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1357343641/main.o.d" "${OBJECTDIR}/_ext/1357343641/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1357343641/app_test_keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c  .generated_files/flags/default/e85d1b7d3e82d1dbc63eb076a1ecf5df6f6ef1fc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1357343641/app_test_keypad.o.d" -o ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1357343641/svc_keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c  .generated_files/flags/default/6adf1ff4b5b14039b4e251effdd5c1e5e4d3d5fb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/svc_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/svc_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1  -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1357343641/svc_keypad.o.d" -o ${OBJECTDIR}/_ext/1357343641/svc_keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/_ext/1357343641/app_test_keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c  .generated_files/flags/default/3bfefc7be41a3638aab0d775d037c042bded0c2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1357343641/app_test_keypad.o.d" -o ${OBJECTDIR}/_ext/1357343641/app_test_keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/app_test_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/_ext/1357343641/svc_keypad.o: C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c  .generated_files/flags/default/b030517199dd25796a1abfca1a105a5fc7f64eec .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1357343641" 
	@${RM} ${OBJECTDIR}/_ext/1357343641/svc_keypad.o.d 
	@${RM} ${OBJECTDIR}/_ext/1357343641/svc_keypad.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -fno-common -MP -MMD -MF "${OBJECTDIR}/_ext/1357343641/svc_keypad.o.d" -o ${OBJECTDIR}/_ext/1357343641/svc_keypad.o C:/Users/carib/CST204/Lab3/Lab3.X/source/svc_keypad.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  C:/Users/carib/CST204/Lab3/Lab3.X/library/lab1_libs.X.a  
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g -mdebugger -D__MPLAB_DEBUGGER_ICD4=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    C:\Users\carib\CST204\Lab3\Lab3.X\library\lab1_libs.X.a      -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x0:0x1FC -mreserve=boot@0x1FC02000:0x1FC02FEF -mreserve=boot@0x1FC02000:0x1FC024FF  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=__MPLAB_DEBUGGER_ICD4=1,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  C:/Users/carib/CST204/Lab3/Lab3.X/library/lab1_libs.X.a 
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    C:\Users\carib\CST204\Lab3\Lab3.X\library\lab1_libs.X.a      -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/Lab3.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
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
