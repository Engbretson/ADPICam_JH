REM Create Directories
mkdir c:\PICAM
mkdir C:\PICAM\Downloads


REM Download modules
REM ----------------
REM Download tar files
REM downloading base ...
wget --no-check-certificate --output-document=C:\PICAM\Downloads\baseR3.14.12.5.tar.gz http://www.aps.anl.gov/epics/download/base/baseR3.14.12.5.tar.gz
REM downloading synApps
wget --no-check-certificate --output-document=C:\PICAM\Downloads\export_5_8.bat https://subversion.xray.aps.anl.gov/synApps/support/trunk/export_5_8.bat

cd \PICAM
REM uncompressing base ...
gzip -d C:\PICAM\Downloads\baseR3.14.12.5.tar.gz
bsdtar -xf C:\PICAM\Downloads\baseR3.14.12.5.tar

REM Run script to export synApps
call Downloads\export_5_8.bat

REM Add in PICam Stuff
cd support/
cd areaDetector-R2-0

wget --no-check-certificate https://github.com/JPHammonds/ADPICam/archive/R2.0.5.tar.gz
move R2.0.5 ADPICam-R2.0.5.tar.gz
gzip -d ADPICam-R2.0.5.tar.gz
bsdtar xf ADPICam-R2.0.5.tar
rmdir /s /q ADPICam
move ADPICam-R2.0.5 ADPICam
rm ADPICam-R2.0.5.tar
cd ..

cd ..
cd synApps_5_8/support
REM "----------------"
REM " Append Visual Studio 2013"
sed.exe -e "/ Visual / s/^/REM /" -i \PICAM\base-3.14.12.5\startup\win32.bat
sed.exe -e "79 a\REM ------ Visual Studio 2013------/" -i \PICAM\base-3.14.12.5\startup\win32.bat
sed.exe -e "80 a\call \"C:\\Program files \(x86\)\\Microsoft Visual Studio 12\.0\\VC\\vcvarsall\.bat\" x64" -i \PICAM\base-3.14.12.5\startup\win32.bat
sed.exe -e "s/win32-x86/windows-x64/" -i C:\PICAM\base-3.14.12.5\startup\win32.bat
sed.exe -e "s/Perl/Perl64/" -i C:\PICAM\base-3.14.12.5\startup\win32.bat
REM "Add in debug cross-compile"
sed.exe -e "/^CROSS_COMPILER_TARGET_ARCHS/ s/$/windows-x64-debug/" -i C:/PICAM/base-3.14.12.5/configure/CONFIG_SITE
sed.exe -e "s/SHARED_LIBRARIES=YES/SHARED_LIBRARIES=NO/" -i C:/PICAM/base-3.14.12.5/configure/CONFIG_SITE
sed.exe -e "s/STATIC_BUILD=NO/STATIC_BUILD=YES/" -i C:/PICAM/base-3.14.12.5/configure/CONFIG_SITE
REM copy C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64-debug.windows-x64-debug C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64.windows-x64-debug
sed.exe -e "/HOST_OPT/ a\OPT_LDFLAGS += \/debug" -i  C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64.windows-x64-debug
sed.exe -e "/HOST_OPT/ a\OPT_CXXFLAGS += \/Zi" -i  C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64.windows-x64-debug
sed.exe -e "/HOST_OPT/ a\USR_LDFLAGS += \/debug" -i  C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64.windows-x64-debug
sed.exe -e "/HOST_OPT/ a\USR_CXXFLAGS += \/Zi" -i  C:/PICAM/base-3.14.12.5/configure/os/CONFIG.windows-x64.windows-x64-debug
REM Cleanup mess from using sed
del sed??????


REM Comment out unused synApps modules
REM "----------------"
REM "Comment unused synAppsModules"
sed.exe -e "/ALLEN_BRADLEY/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/CAMAC/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/DELAYGEN/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/DEVIOCSTATS/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/DXP/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/IP330/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
REM  sed.exe -e "/IPAC/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/IPUNIDIG/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/LOVE/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/MEASCOMP/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/MCA/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/MODBUS/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/MOTOR/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/OPTICS/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/QUADEM/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/SOFTGLUE/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/STREAM/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/VAC/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/VME/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/XXX/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/STD/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/asyn-4-21/asyn-4-26/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/calc-3-2/calc-3-4-2/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/EPICS_BASE=\/home\/oxygen\/MOONEY\/epics\/base-3.14.12.5-rc1/EPICS_BASE=C:\/PICAM\/base-3.14.12.5/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/EPICS_BASE=H:\/epics\/base-3.14.12.1/EPICS_BASE=C:\/PICAM\/base-3.14.12.5/" -i \PICAM\synApps_5_8\support\configure\EPICS_BASE.windows-x64
sed.exe -e "s/SUPPORT=\/home\/oxygen\/MOONEY\/epics\/synAppsSVN\/support/SUPPORT=C:\/PICAM\/synApps_5_8\/support/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/SUPPORT=J:\/epics\/devel/SUPPORT=C:\/PICAM\/synApps_5_8\/support/" -i \PICAM\synApps_5_8\support\configure\SUPPORT.windows-x64
sed.exe -e "s/areaDetector-1-9-1/areaDetector-R2-0/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "s/autosave-5-1/autosave-5-5/" -i \PICAM\synApps_5_8\support\configure\RELEASE
REM sed.exe -e 's/busy-1-6/busy-1-6-1/" -i \PICAM\synApps_5_8\support\configure\RELEASE
REM sed.exe -e 's/sscan-2-9/sscan-2-10/" -i \PICAM\synApps_5_8\support\configure\RELEASE
REM sed.exe -e 's/seq-2-1-13/seq-2-1-18/" -i \PICAM\synApps_5_8\support\configure\RELEASE   
sed.exe -e "/ipac-2-12/ s/#//" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/SNCSEQ/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/SNCSEQ/ s/^/#/" -i C:\PICAM\synApps_5_8\support\sscan-2-10-1\configure\RELEASE
sed.exe -e "/SNCSEQ/ s/^/#/" -i C:\PICAM\synApps_5_8\support\asyn-4-26\configure\RELEASE
sed.exe -e "/SNCSEQ/ s/^/#/" -i C:\PICAM\synApps_5_8\support\calc-3-4-2-1\configure\RELEASE
sed.exe -e "/DAC128V/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
sed.exe -e "/IP=/ s/^/#/" -i \PICAM\synApps_5_8\support\configure\RELEASE
REM Cleanup mess from using sed
del sed??????

REM "----------------"
REM "Modify areadetector Make file to remove non used detectors and add PICAM"
sed.exe -e "/ADPerkinElmer_DEPEND/ a\\nDIRS := \$\(DIRS\) ADPICAM\nADPICAM_DEPEND_DIRS += ADCore-R2-2" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADADSC/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADAndor/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADAndor3/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADBruker/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADFireWireWin/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADLightField/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPSL/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPerkinElmer/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPilatus/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPixirad/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPointGrey/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADProsilica/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADPvCam/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADURL/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADmarCCD/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
sed.exe -e "/ADmar345/ s/^/#/" -i \PICAM\synApps_5_8\support\areaDetector-R2-0\Makefile
REM Cleanup mess from using sed
del sed??????

mkdir C:\PICAM\synApps_5_8\support\areaDetector-R2-0\ADPICAM\iocs\PICamIOC\iocBoot\iocPICam\autosave