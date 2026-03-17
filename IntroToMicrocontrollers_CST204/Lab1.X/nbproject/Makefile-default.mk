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
FINAL_IMAGE=${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED="C:/Users/carib/CST 204/Lab1/Lab1.X/source/data.S" "C:/Users/carib/CST 204/Lab1/Lab1.X/source/config_bits.S" "C:/Users/carib/CST 204/Lab1/Lab1.X/source/hardware.S" "C:/Users/carib/CST 204/Lab1/Lab1.X/source/app_heartbeat.S" "C:/Users/carib/CST 204/Lab1/Lab1.X/source/main.S"

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1553929669/data.o ${OBJECTDIR}/_ext/1553929669/config_bits.o ${OBJECTDIR}/_ext/1553929669/hardware.o ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o ${OBJECTDIR}/_ext/1553929669/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1553929669/data.o.d ${OBJECTDIR}/_ext/1553929669/config_bits.o.d ${OBJECTDIR}/_ext/1553929669/hardware.o.d ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d ${OBJECTDIR}/_ext/1553929669/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1553929669/data.o ${OBJECTDIR}/_ext/1553929669/config_bits.o ${OBJECTDIR}/_ext/1553929669/hardware.o ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o ${OBJECTDIR}/_ext/1553929669/main.o

# Source Files
SOURCEFILES=C:/Users/carib/CST 204/Lab1/Lab1.X/source/data.S C:/Users/carib/CST 204/Lab1/Lab1.X/source/config_bits.S C:/Users/carib/CST 204/Lab1/Lab1.X/source/hardware.S C:/Users/carib/CST 204/Lab1/Lab1.X/source/app_heartbeat.S C:/Users/carib/CST 204/Lab1/Lab1.X/source/main.S



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
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

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
${OBJECTDIR}/_ext/1553929669/data.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/data.S  .generated_files/flags/default/b743c42064735e871c7dc7879068bfb8337e01a4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o.ok ${OBJECTDIR}/_ext/1553929669/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/data.o.d"  -o ${OBJECTDIR}/_ext/1553929669/data.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/data.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/data.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/data.o.d" "${OBJECTDIR}/_ext/1553929669/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/config_bits.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/config_bits.S  .generated_files/flags/default/171187bde8e2823d62bf1fb1ef7f3cc9b89c2b90 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o.ok ${OBJECTDIR}/_ext/1553929669/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1553929669/config_bits.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/config_bits.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/config_bits.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/config_bits.o.d" "${OBJECTDIR}/_ext/1553929669/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/hardware.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/hardware.S  .generated_files/flags/default/ccf4df202252ccc1ba200c322c278c0d05c4d07 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o.ok ${OBJECTDIR}/_ext/1553929669/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/hardware.o.d"  -o ${OBJECTDIR}/_ext/1553929669/hardware.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/hardware.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/hardware.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/hardware.o.d" "${OBJECTDIR}/_ext/1553929669/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/app_heartbeat.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/app_heartbeat.S  .generated_files/flags/default/524147921086c35e8db653c2c2f012bb55c8a27f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/app_heartbeat.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/main.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/main.S  .generated_files/flags/default/7a11224110a86e514b15e5a0b934d8c47cf43f4c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o.ok ${OBJECTDIR}/_ext/1553929669/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD4=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/main.o.d"  -o ${OBJECTDIR}/_ext/1553929669/main.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/main.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/main.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD4=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/main.o.d" "${OBJECTDIR}/_ext/1553929669/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/_ext/1553929669/data.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/data.S  .generated_files/flags/default/9edf6375d1c516ede6bb5548660a02e248d66a87 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/data.o.ok ${OBJECTDIR}/_ext/1553929669/data.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/data.o.d"  -o ${OBJECTDIR}/_ext/1553929669/data.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/data.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/data.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/data.o.d" "${OBJECTDIR}/_ext/1553929669/data.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/config_bits.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/config_bits.S  .generated_files/flags/default/1c20558d93b5d2cd1fbeae593d1c712fd967f240 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/config_bits.o.ok ${OBJECTDIR}/_ext/1553929669/config_bits.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/config_bits.o.d"  -o ${OBJECTDIR}/_ext/1553929669/config_bits.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/config_bits.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/config_bits.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/config_bits.o.d" "${OBJECTDIR}/_ext/1553929669/config_bits.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/hardware.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/hardware.S  .generated_files/flags/default/ad2e105a5aaadfc3d42c0ccbc1addfc895e6329d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/hardware.o.ok ${OBJECTDIR}/_ext/1553929669/hardware.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/hardware.o.d"  -o ${OBJECTDIR}/_ext/1553929669/hardware.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/hardware.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/hardware.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/hardware.o.d" "${OBJECTDIR}/_ext/1553929669/hardware.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/app_heartbeat.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/app_heartbeat.S  .generated_files/flags/default/24af62f2dd9a56fd2674e12e08ca9d58e011828d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.ok ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d"  -o ${OBJECTDIR}/_ext/1553929669/app_heartbeat.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/app_heartbeat.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.d" "${OBJECTDIR}/_ext/1553929669/app_heartbeat.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/_ext/1553929669/main.o: C:/Users/carib/CST\ 204/Lab1/Lab1.X/source/main.S  .generated_files/flags/default/9d88fc98211a7d939f488ffd4e9c3291a9fc0d55 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1553929669" 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o 
	@${RM} ${OBJECTDIR}/_ext/1553929669/main.o.ok ${OBJECTDIR}/_ext/1553929669/main.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/_ext/1553929669/main.o.d"  -o ${OBJECTDIR}/_ext/1553929669/main.o "C:/Users/carib/CST 204/Lab1/Lab1.X/source/main.S"  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/1553929669/main.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/_ext/1553929669/main.o.d" "${OBJECTDIR}/_ext/1553929669/main.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  C:/Users/carib/CST\ 204/Lab1/Lab1.X/library/lab1_libs.X.a  
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g -mdebugger -D__MPLAB_DEBUGGER_ICD4=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    "C:\Users\carib\CST 204\Lab1\Lab1.X\library\lab1_libs.X.a"      -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x0:0x1FC -mreserve=boot@0x1FC02000:0x1FC02FEF -mreserve=boot@0x1FC02000:0x1FC024FF  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=__MPLAB_DEBUGGER_ICD4=1,--no-code-in-dinit,--no-dinit-in-serial-mem,-L"library",-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  C:/Users/carib/CST\ 204/Lab1/Lab1.X/library/lab1_libs.X.a 
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}    "C:\Users\carib\CST 204\Lab1\Lab1.X\library\lab1_libs.X.a"      -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--no-code-in-dinit,--no-dinit-in-serial-mem,-L"library",-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/Lab1.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
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
