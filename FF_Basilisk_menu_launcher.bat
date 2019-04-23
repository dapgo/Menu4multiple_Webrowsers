@echo OFF
rem  --------------------------
rem https://github.com/dapgo/Menu_Launcher4multiple_FF
rem  --------------------------
rem Notes I renamed the executable files with NO_use_EXE_ to avoid launching the .exe without profile argument.
rem Intructions/sections to fill
rem 1 For new computer or change of folder
rem 1.1 Create a new ERRORLEVEL section for a computer using a different drive or folder
rem 1.2 set BROWSERPATH, PROFILEPATH for a computer using a different drive or folder
rem
rem 2. For a new webBrowser fork or version
rem 2.1 Create a new ERRORLEVEL section for the new webbrowser
rem 2.2 rename executable folder and filename.exe
rem  --------------------------
rem ------ My notes/Information
rem Basilisk default folder -profile "c:\Users\username\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\5sq5azxp.default
rem 
rem note that  ECHO/ for newline is not an official instruction, so remove it fails.
rem 

rem  ----------------------------------------------------
rem                SECTION 0 - Path Declaration
rem  ----------------------------------------------------
SET NAME1=Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH1=D:\20 Portables\BasiliskBrowsers 
SET PROFILE1=D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default

SET NAME2=Drive C: (folder: Portables\BasiliskBrowsers)
SET PATH2=C:\daniel\Portables\BasiliskBrowsers
SET PROFILE2=C:\daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default

SET NAME3=Drive C (default Basilisk at Roaming\Moonchild Productions\)
SET PATH3=c:\Users\myusername\Documents\Basilisk
SET PROFILE3=c:\Users\myusername\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\5sq5azxp.default

SET NAME4=WaterFox+Basilisk(profile at D:)
SET PATH4=D:\20 Portables\WaterfoxPortable56.2.7\App\Waterfox\
SET PROFILE4=D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default

:MAINMENU
ECHO ************************************************************************************  
ECHO ***********        BATCH MENU for Firefox/Basilisk       ***************************
ECHO ***********     v1.0 (by DaPGo2019) - GPL         **********************************
ECHO ***********   https://github.com/dapgo/Menu_Launcher4multiple_FF      **************
ECHO ************************************************************************************
 rem ECHO/ white line remove if it fails
ECHO/ 

ECHO OFF

:SECTION1
rem  ----------------------------------------------------
rem                SECTION1 - Root folder and PROFILE folder
rem  ----------------------------------------------------
ECHO ********************************************************************
ECHO ***********   SELECT a PATH/DRIVE for app/profile     **************
ECHO ***********   Help for more info and predefined paths  *************
ECHO ********************************************************************
ECHO 1)%NAME1% 
ECHO 2)%NAME2% 
ECHO 3)%NAME3% 
ECHO 4)%NAME4% 
ECHO 5)HELP/INFO
CHOICE /C 12345 /M "Choose an option "
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO Path4
IF %ERRORLEVEL% == 5 GOTO HELP
GOTO SECTION1

:Path1
 ECHO %NAME1% (Lenovo)
 SET BROWSERPATH=%PATH1%
 SET PROFILEPATH=%PROFILE1%
 GOTO SECTION2

:Path2	
  ECHO %NAME2% (HP laptop)
 SET BROWSERPATH=%PATH2%
 SET PROFILEPATH=%PROFILE2%
 GOTO SECTION2
  
:Path3	
 ECHO %NAME3%
 SET BROWSERPATH=%PATH3%
 SET PROFILEPATH=%PROFILE3%
 GOTO SECTION2
:Path4	
 ECHO %NAME4% Waterfox loading a Basilisk profile (be careful and do not update addons)
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 GOTO SECTION2
  
:HELP		
    ECHO/ 
	ECHO **********************************************************************
	ECHO ***********   	HELP: BATCH MENU for Firefox/Basilisk    **************
	ECHO ***********      Information, tips, about          *******************
	ECHO **********************************************************************
 rem ECHO/ white line remove if it fails
  ECHO/ 
  ECHO #tip1: To avoid problems caused by incompatible extensions/add-ins 
  ECHO Share a profile folder among webbrowsers based in same or similar Firefox version
  ECHO #tip2: Disable Addin automatic updates 
  ECHO #tip2: Disable WebBrowser automatic updates 
  ECHO #tip3: Update Addins always from your main browser
  ECHO/
  ECHO #Info about FF extension compatibility
  ECHO Compatible FF52 Addins browsers: Basilisk, FF52, Centaury, Serpent, ..
  ECHO Compatible FF56 Addins browsers: Waterfox, FF56, ..
  ECHO Compatible FF27 Addins browsers: Palemoon27,28, FF27, Mypal, Palemoon fork
  ECHO Compatible FF Quantum Addins browsers: FF57, FF>57, Waterfox
  ECHO/
  ECHO #Predefined paths at Menu Script:  
  ECHO Path1 %PATH1%
  ECHO Profile1 %PROFILE1%
  ECHO Path2 %PATH2%
  ECHO Profile2 %PROFILE2%
  ECHO Path3 %PATH3%
  ECHO Profile3 %PROFILE3%
  ECHO Path4 %PATH4%
  ECHO Profile4 %PROFILE4%
  ECHO/
  ECHO #For additional info, latest version or submit bugs:	
  ECHO https://github.com/dapgo/Menu_Launcher4multiple_FF
  ECHO/
  PAUSE
  CLS
  GOTO MAINMENU



:SECTION2
ECHO You chose %BROWSERPATH%, %PROFILEPATH%

rem  ----------------------------------------------------
rem                SECTION2 - Executable folder and filename 
rem  ----------------------------------------------------
rem ECHO/ white line remove if it fails
ECHO/ 
ECHO **********************************************************
ECHO ***********   SELECT a WebBrowser           **************
ECHO **********************************************************
ECHO/
ECHO 1) Basilisk2019 
ECHO 2) Basilisk2018 SYNC 
ECHO 3) Serpent_win32_2019 
ECHO 4) Centaury32b 
ECHO 5) Waterfox+Basilisk(profile)(be careful)
CHOICE /C 12345 /M ""
IF %ERRORLEVEL% == 1 GOTO basilisk
IF %ERRORLEVEL% == 2 GOTO basilisksync
IF %ERRORLEVEL% == 3 GOTO serpent_win32
IF %ERRORLEVEL% == 4 GOTO centaury32b
IF %ERRORLEVEL% == 5 GOTO Waterfox+Basilisk(profile)
GOTO FIN

:basilisk
 ECHO Basilisk2019
 CD /D "%BROWSERPATH%\basilisk_2019\"
 CD
 cmd /K NO_use_EXE_basilisk.exe -no-remote -profile "%PROFILEPATH%"
 GOTO FIN				

:basilisksync
 ECHO Basilisk_SYNC
 CD /D "%BROWSERPATH%\basilisk_2018_SYNC\"
 CD
 CMD /K NO_use_EXE_basilisk_ffsync.exe -no-remote -profile "%PROFILEPATH%"
 GOTO FIN	
 
:serpent_win32		
 ECHO serpent_win32_201903
 CD /D "%BROWSERPATH%\serpent_win32_201903\"
 CD
 CMD /K basilisk.exe -no-remote -profile "%PROFILEPATH%"			
 GOTO FIN	

:centaury32b				
 ECHO centaury32b_i
 CD /D "%BROWSERPATH%\centaury32b_i\"
 CD
 CMD /K NO_use_EXE_Centaury.exe -no-remote -profile "%PROFILEPATH%"			
 GOTO FIN	
 
:waterfox				
 ECHO Waterfox
 CD /D "%BROWSERPATH%\"
 CD
 CMD /K waterfox.exe -no-remote -profile "%PROFILEPATH%"			
 GOTO FIN	
 
:FIN				
ECHO You can close this window				
EXIT