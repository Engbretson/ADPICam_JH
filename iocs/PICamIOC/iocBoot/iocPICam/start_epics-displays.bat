set SUPPORT=C:\PICAM\synApps_5_8\support
set AREA_DETECTOR=%SUPPORT%\areaDetector-R2-0
set ASYN=%SUPPORT%\asyn-4-26
set EPICS_DISPLAY_PATH=%AREA_DETECTOR%\ADPICam\PICamApp\op\adl;%AREA_DETECTOR%\ADCore-R2-2\ADApp\op\adl;%ASYN%\opi\medm
echo %EPICS_DISPLAY_PATH%
start medm -x -macro "P=13PICAM1:, R=cam1:" PICAMBase.adl
