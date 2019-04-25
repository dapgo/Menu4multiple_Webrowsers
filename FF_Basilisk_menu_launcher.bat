@echo OFF
SET VERSION=1.04 
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
SET NAME1=PC1 - Drive C: (default Basilisk at \Program Files and \Roaming\Moonchild Productions\)
SET PATH1=C:\Program Files\Basilisk\
SET PROFILE1=C:\Users\danielp\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\7jgwm62d.default


SET NAME2=PC1 - Drive C: (folder: Portables\BasiliskBrowsers)
SET PATH2=C:\Daniel\APPS\BasiliskBrowsers
SET PROFILE2=C:\Daniel\APPS\BasiliskBrowsers\Profiles\3sq5azxp.default

SET NAME3=PC2 - Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH3=D:\20 Portables\BasiliskBrowsers 
SET PROFILE3=D:\20 Portables\BasiliskBrowsers\Profiles\3sq5azxp.default


SET NAME4=PC2 -D:  WaterFox+Basilisk profile (folder: Portables\BasiliskBrowsers)
SET PATH4=D:\20 Portables\WaterfoxPortable56.2.7\App\Waterfox\
SET PROFILE4=D:\20 Portables\BasiliskBrowsers\Profiles\3sq5azxp.default


SET NAME5=USB PenDrive - Drive G: (folder: Portables\BasiliskBrowsers)
SET PATH5=G:\Portables\BasiliskBrowsers 
SET PROFILE5=G:\Portables\BasiliskBrowsers\Profiles\3sq5azxp.default

SET NAME6=USB PenDrive - Drive G: (folder: Portables\PalemoonBrowsers)
SET PATH6=G:\Portables\PalemoonBrowsers 
SET PROFILE6=G:\Portables\PalemoonBrowsers\Profiles\palemoon.default

:MAINMENU
ECHO ************************************************************************************  
ECHO ***********        BATCH MENU for Firefox Browsers       ***************************
ECHO ***********  Focused in FF Legacy/Basilisk/Waterfox/Palemoon  **********************
ECHO ***********          v %VERSION% (by DaPGo2019) - GPL        ***************************
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
ECHO ***********   SELECT a PATH/DRIVE for Exe/Profile     **************
ECHO ***********   Help for more info and predefined paths  *************
ECHO ********************************************************************
ECHO 1) %NAME1% 
ECHO 2) %NAME2% 
ECHO 3) %NAME3% 
ECHO 4) %NAME4% 
ECHO 5) %NAME5% 
ECHO 6) %NAME6% 
ECHO 7) HELP/INFO
CHOICE /C 1234567 /M "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO Path4
IF %ERRORLEVEL% == 5 GOTO Path5
IF %ERRORLEVEL% == 6 GOTO Path6
IF %ERRORLEVEL% == 7 GOTO HELP
GOTO SECTION1

:Path1
 ECHO (HP laptop)
 SET BROWSERPATH=%PATH1%
 SET PROFILEPATH=%PROFILE1%
 GOTO SECTION2
:Path2	
  ECHO (HP laptop)
 SET BROWSERPATH=%PATH2%
 SET PROFILEPATH=%PROFILE2%
 GOTO SECTION2
:Path3	
 ECHO (Lenovo laptop)
 SET BROWSERPATH=%PATH3%
 SET PROFILEPATH=%PROFILE3%
 GOTO SECTION2
:Path4	
 ECHO (Lenovo laptop) Waterfox with a Basilisk profile (be careful and do not update addons)
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 GOTO SECTION2
:Path5	
 ECHO (Any computer from a USB memory)
 SET BROWSERPATH=%PATH5%
 SET PROFILEPATH=%PROFILE5%
 GOTO SECTION2  
:Path6	
 ECHO (Any computer from USB memory)
 SET BROWSERPATH=%PATH6%
 SET PROFILEPATH=%PROFILE6%
 GOTO SECTION2
:HELP		
    ECHO/ 
	ECHO **********************************************************************
	ECHO ***********   	HELP: BATCH MENU for Firefox/Basilisk    **************
	ECHO ***********      Information, tips, about          *******************
	ECHO **********************************************************************
 rem ECHO/ white line remove if it fails
  ECHO/
  ECHO The default Profile folder name is dynamic and change for each browser/computer, can be renamed when using from Menu/Command line
  ECHO #tip1: To avoid problems caused by incompatible extensions/add-ins 
  ECHO Share a profile folder among webbrowsers based in same or similar Firefox version
  ECHO #tip2: Disable Addin automatic updates 
  ECHO #tip2: Disable WebBrowser automatic updates 
  ECHO #tip3: Update Addins always from your main browser
  ECHO/
  ECHO #Info about FF extension compatibility
  ECHO Compatible FF27 Addins browsers: Palemoon27,28, FF27, Mypal, Palemoon forks, Basilisk!
  ECHO Compatible FF52 Addins browsers: Basilisk, FF52, Centaury, Serpent, Waterfox! ..
  ECHO Compatible FF56 Addins browsers: Waterfox, FF56, ..
  ECHO Compatible FF Quantum Addins browsers: FF57, FF>57, Waterfox!
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
  ECHO Path5 %PATH5%
  ECHO Profile5 %PROFILE5%
  ECHO Path6 %PATH6%
  ECHO Profile6 %PROFILE6%
  ECHO/
  ECHO #For additional info, latest version or submit bugs:	
  ECHO https://github.com/dapgo/Menu_Launcher4multiple_FF
  ECHO/
  PAUSE
  CLS
  GOTO MAINMENU



:SECTION2
ECHO Root (exe): %BROWSERPATH% 
ECHO Complete Profile path: %PROFILEPATH%

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
ECHO 2) Basilisk2018 (FF SYNC)
ECHO 3) Serpent_win32_2019 (Basilisk fork for winxp)
ECHO 4) Centaury32b (Basilisk fork for winxp)
ECHO 5) Waterfox (with Basilisk profile)(be careful)
ECHO 6) Palemoon28
ECHO 7) MyPal(Palemoon fork for winxp)
CHOICE /C 1234567 /M "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO basilisk
IF %ERRORLEVEL% == 2 GOTO basilisksync
IF %ERRORLEVEL% == 3 GOTO serpent_win32
IF %ERRORLEVEL% == 4 GOTO centaury32b
IF %ERRORLEVEL% == 5 GOTO Waterfox+Basilisk(profile)
IF %ERRORLEVEL% == 6 GOTO Palemoon
IF %ERRORLEVEL% == 7 GOTO Mypal
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
 
:Palemoon
 ECHO Palemoon
 CD /D "%BROWSERPATH%\"
 CD
 CMD /K palemoon.exe -no-remote -profile "%PROFILEPATH%"			
 GOTO FIN 
 
:Mypal
 ECHO Mypal (Palemoon fork for winxp)
 CD /D "%BROWSERPATH%\"
 CD
 CMD /K palemoon.exe -no-remote -profile "%PROFILEPATH%"			
 GOTO FIN  
 
 
:FIN				
ECHO You can close this window				
EXIT