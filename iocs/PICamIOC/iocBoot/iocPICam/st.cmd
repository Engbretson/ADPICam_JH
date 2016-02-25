errlogInit(20000)

< envPaths
#epicsThreadSleep(20)
dbLoadDatabase("$(TOP)/dbd/PICamApp.dbd")
PICamApp_registerRecordDeviceDriver(pdbbase) 

# Prefix for all records
epicsEnvSet("PREFIX", "13PICAM1:")
# The port name for the detector
epicsEnvSet("PORT",   "PICAMDET1")
# The queue size for all plugins
epicsEnvSet("QSIZE",  "20")
# The maximim image width; used for row profiles in the NDPluginStats plugin
epicsEnvSet("XSIZE",  "2048")
# The maximim image height; used for column profiles in the NDPluginStats plugin
epicsEnvSet("YSIZE",  "2048")
# The maximum number of time seried points in the NDPluginStats plugin
epicsEnvSet("NCHANS", "2048")
# The maximum number of frames buffered in the NDPluginCircularBuff plugin
epicsEnvSet("CBUFFS", "500")
# The search path for database files
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(ADCORE)/db")

asynSetMinTimerPeriod(0.001)

# Create a PICam driver
# PICamConfig(const char *portName, IDType, IDValue, maxBuffers, size_t maxMemory, int priority, int stackSize)

# This is for a 
PICamConfig("$(PORT)", 0, 0, 0, 0)
#PICamAddDemoCamera("PIXIS: 100F")
PICamAddDemoCamera("Quad-RO: 4320")
#PICamAddDemoCamera("PI-MAX4: 2048B-RF")
#PICamAddDemoCamera("PIXIS: 1300F")

asynSetTraceIOMask($(PORT), 0, 2)
#asynSetTraceMask($(PORT),0,0xff)

dbLoadRecords("$(ADCORE)/db/ADBase.template", "P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")
dbLoadRecords("$(ADPICAM)/db/PICam.template","P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")

# Create a standard arrays plugin, set it to get data from Driver.
NDStdArraysConfigure("Image1", 3, 0, "$(PORT)", 0)

dbLoadRecords("$(ADCORE)/db/NDPluginBase.template","P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")


dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,NDARRAY_PORT=$(PORT),TIMEOUT=1,TYPE=Int16,SIZE=16,FTVL=SHORT,NELEMENTS=20000000")


# Load all other plugins using commonPlugins.cmd
< $(ADCORE)/iocBoot/commonPlugins.cmd
set_requestfile_path("$(ADPICAM)/PICamApp/Db")

# IMM plugin support

drvNDFileIMMConfigure("IMM", 100, 0,"$(PORT)",0,50,30000000);

#dbLoadRecords("$(ADCORE)/db/NDPluginBase.template","P=$(PREFIX),R=IMM:,PORT=IMM,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")

dbLoadRecords("$(ADCORE)/db/NDPluginBase.template","P=$(PREFIX),R=IMM:,PORT=IMM,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")

dbLoadRecords("$(ADIMMPlugin)/immApp/db/NDFileIMM.template", "P=$(PREFIX),R=IMM:,PORT=IMM,ADDR=0,TIMEOUT=1")

set_requestfile_path("$(ADIMMPlugin)/immApp/Db")

#asynSetTraceMask($(PORT),0,0x09)
iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30, "P=$(PREFIX)")

# Wait for some initialization to complete

#epicsThreadSleep(1.0)
#dbpf ("$(PREFIX)cam1:AvailableCameras.PROC", "1")
# Actually this makes it worse if a default camera is set

# TimeStamps and Frame Meta Data
epicsThreadSleep(2.0)
dbpf("$(PREFIX)cam1:TimeStamps.PROC", "1")
dbpf("$(PREFIX)cam1:TimeStampBitDepth.PROC", "1")
dbpf("$(PREFIX)cam1:TimeStampResolution.PROC", "1")

dbpf("$(PREFIX)cam1:TrackFrames.PROC", "1")
dbpf("$(PREFIX)cam1:FrameTrackingBitDepth.PROC", "1")

# Kinetics mode and frame sizes
epicsThreadSleep(1.0)
dbpf("$(PREFIX)cam1:AcquireTime.PROC", "1")
dbpf("$(PREFIX)cam1:VerticalShiftRate.PROC", "1")
dbpf("$(PREFIX)cam1:KineticsWindowHeight.PROC", "1")
dbpf("$(PREFIX)cam1:ReadoutControlMode.PROC", "1")


