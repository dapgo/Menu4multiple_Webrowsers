@echo OFF
SET VERSION=1.51
rem  --------------------------
rem https://github.com/dapgo/Menu_Launcher4multiple_FF
rem  --------------------------
rem 1st menu to identify paths for common/shared (profile)
rem 2nd menu to identify a specific Webbrowser and its bin path (can use shared profiles)
rem
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
rem Basilisk default folder: -profile "c:\Users\username\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\5sq5azxp.default
rem
rem if path has not spaces inside do not quote variable %PROFILEPATH% it can fail (WF)
rem 
rem Portable.exe doesn't support profile parameters :  -no-remote -profile
rem
rem note that  ECHO/ for newline is not an official instruction, so remove it fails.
rem be careful, do not add  slash at the end of paths
rem 
rem PEND!!!  add 1st menu profile, 2nd menu browser, limit combination of profile and browser

rem  ----------------------------------------------------
rem                SECTION 0 - Path Declaration
rem  ----------------------------------------------------
SET NAME1=PC1 - Drive C: (default Basilisk at \Program Files and \Roaming\Moonchild Productions\)
SET PATH1=C:\Program Files\Basilisk
SET PROFILE1=C:\Users\danielp\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\7jgwm62d.default


SET NAME2=Drive C: (folder: Portables\BasiliskBrowsers)
REM =PC2 - Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH2=C:\Daniel\Portables\BasiliskBrowsers
REM D:\20 Portables\BasiliskBrowsers 
SET PROFILE2=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
REM D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default


SET NAME3=Drive C: (folder: Portables\PalemoonBrowsers)
SET PATH3=C:\Daniel\Portables\PalemoonBrowsers
SET PROFILE3=C:\Daniel\Portables\PalemoonBrowsers\Profiles\Default

SET NAME4= !! Mix browsers(prev backup) - Basilisk profile+WF bin (folder: Portables\xxxx)
SET PATH4=C:\Daniel\Portables\Waterfox_browsers
REM \WaterfoxPortable56.2.7\App\Waterfox
SET PROFILE4=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default

SET NAME5=Drive C: (folder: Portables\Waterfox_browsers)
SET PATH5=C:\Daniel\Portables\Waterfox_browsers
SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\profile					 
REM DEFAULT profile path
REM SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.7\Data\profile

SET NAME6=USB PenDrive - Drive G: (folder: Portables\BasiliskBrowsers)
SET PATH6=G:\Portables\BasiliskBrowsers 
SET PROFILE6=G:\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default

SET NAME7=USB PenDrive - Drive G: (folder: Portables\PalemoonBrowsers)
SET PATH7=G:\Portables\PalemoonBrowsers 
SET PROFILE7=G:\Portables\PalemoonBrowsers\Profiles\palemoon.default

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
ECHO ***********         Menu1: SELECT a PATH/DRIVE        **************
ECHO ***********       for Profile(data)/ browser family    *************
ECHO ***********   Help for more info and predefined paths  *************
ECHO ********************************************************************
ECHO 1) %NAME1% 
ECHO 2) %NAME2% 
ECHO 3) %NAME3% 
ECHO 4) %NAME4% 
ECHO 5) %NAME5% 
ECHO 6) %NAME6% 
ECHO 7) %NAME7% 
ECHO 8) HELP/INFO
CHOICE /C 12345678 /M "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO Path4
IF %ERRORLEVEL% == 5 GOTO Path5
IF %ERRORLEVEL% == 6 GOTO Path6
IF %ERRORLEVEL% == 7 GOTO Path7
IF %ERRORLEVEL% == 8 GOTO HELP
GOTO SECTION1

:Path1
 ECHO (DRIVE C laptop)
 SET BROWSERPATH=%PATH1%
 SET PROFILEPATH=%PROFILE1%
 GOTO SECTION2
:Path2	
  ECHO (DRIVE C )
 SET BROWSERPATH=%PATH2%
 SET PROFILEPATH=%PROFILE2%
 GOTO SECTION2
:Path3	
 ECHO (DRIVE C )
 SET BROWSERPATH=%PATH3%
 SET PROFILEPATH=%PROFILE3%
 GOTO SECTION2
:Path4	
 ECHO (Lenovo laptop) Waterfox with a Basilisk profile (be careful and do not update addons)
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 GOTO SECTION2
:Path5	
 ECHO (Lenovo laptop) WaterfoxNew with previousWF profile
 SET BROWSERPATH=%PATH5%
 SET PROFILEPATH=%PROFILE5%
 GOTO SECTION2 
 
:Path6	
 ECHO (Any computer from a USB memory)
 SET BROWSERPATH=%PATH6%
 SET PROFILEPATH=%PROFILE6%
 GOTO SECTION2  
:Path7	
 ECHO (Any computer from USB memory)
 SET BROWSERPATH=%PATH7%
 SET PROFILEPATH=%PROFILE7%
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
  ECHO When a common Profile folder is stored at different PCs, changes on both PCs will disalign profile, sync frequently (copy paste after changes)																																				 
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
  PAUSE
   ECHO/ 
	ECHO **********************************************************************
	ECHO ***********   	HELP: Browsers INFO    **************
	ECHO **********************************************************************
  ECHO/
  ECHO #Basilisk: 
  ECHO Basilisk2018 Based FF52.9 Compatible (FFSync, MultiAccount container, webextensions)
  ECHO Basilisk201906 Based FF52.9 0% Compatible webextensions  (PM sync)
  ECHO #Waterfox:
  ECHO Waterfox 56.2.10. Based FF56, Compatible with XUL and webextensions  
  ECHO Waterfox Beta. Based FF68, Limited compatibility with XUL - webextensions  
  ECHO #Palemoon:
  ECHO Palemoon27. Based FF24,28  (FF sync)
  ECHO Palemoon29. Based FF24,28  (PM sync)
	ECHO **********************************************************************
	ECHO ***********   	HELP: SCRIPT PATHS    **************
	ECHO **********************************************************************
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
  ECHO Path6 %PATH7%  
  ECHO Profile6 %PROFILE7%  
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
ECHO ******************************************************************
ECHO ***********  Menu2:   SELECT a WebBrowser version   **************
ECHO ******************************************************************
ECHO/
ECHO 1) Basilisk201906 
ECHO 2) Basilisk2018 (FF SYNC)
ECHO 3) Serpent_win32_2019 (Basilisk fork for winxp)
ECHO 4) Centaury32b (Basilisk fork for winXP)
ECHO 5) Waterfox 56.2.7 
ECHO 6) Waterfox 56.2.10 (with WF profile)(be careful)
ECHO 7) Palemoon29 (32bits)
ECHO 8) MyPal(Palemoon fork for winXP)
CHOICE /C 12345678 /M "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO basilisk
IF %ERRORLEVEL% == 2 GOTO basilisksync
IF %ERRORLEVEL% == 3 GOTO serpent_win32
IF %ERRORLEVEL% == 4 GOTO centaury32b
IF %ERRORLEVEL% == 5 GOTO waterfox_old
IF %ERRORLEVEL% == 6 GOTO waterfox_new
IF %ERRORLEVEL% == 7 GOTO Palemoon
IF %ERRORLEVEL% == 8 GOTO Mypal
GOTO FIN

:basilisk
 ECHO Basilisk2019
 CD /D "%BROWSERPATH%\basilisk_201906\"
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
 
:waterfox_old
 ECHO Waterfox
CD /D "%BROWSERPATH%\WaterfoxPortable56.2.7\App\Waterfox\"
 CD
 CMD /K Waterfox.exe -no-remote -profile %PROFILEPATH%		
 GOTO FIN	
 
:waterfox_new				
 ECHO WaterfoxNew
 CD /D "%BROWSERPATH%\WaterfoxPortable56.2.10\App\Waterfox\"
 CD
 CMD /K Waterfox.exe -no-remote -profile %PROFILEPATH%
 rem Manual path just for testing 
 rem OK CMD /K Waterfox.exe -no-remote -profile C:\Daniel\Portables\Waterfox_browsers\profile
 GOTO FIN	
 
:Palemoon
 ECHO Palemoon
 CD /D "%BROWSERPATH%\PM29_32b\Bin\Palemoon\"
 CD
 rem portable.exe doesn't support -no-remote -profile "%PROFILEPATH%"			
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
