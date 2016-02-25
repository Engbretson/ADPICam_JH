TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

ifeq (windows-x64, $(findstring windows-x64, $(T_A)))
USR_CPPFLAGS += -D__X64
endif

LIBRARY_IOC_WIN32 = ADPICam
LIB_SRCS_WIN32 += ADPICam.cpp
LIB_LIBS += Picam
LIB_LIBS += MaddenPlugins.lib

DBD += PICamSupport.dbd
#DBD += IMMpluginSupport.dbd
#DBD += immViewPluginSupport.dbd

include $(ADCORE)/ADApp/commonLibraryMakefile

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

