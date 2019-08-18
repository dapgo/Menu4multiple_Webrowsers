@echo OFF
SET VERSION=1.863_WinXP_fork
set "ROOTDIR=%cd%"

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
rem  ----------------------------------------------------
rem ------         NOTES /Information
rem  ----------------------------------------------------
rem Basilisk default folder: -profile "c:\Users\username\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\5sq5azxp.default
rem
rem if path has not spaces inside do not quote variable %PROFILEPATH% it can fail (WF)
rem 
rem Portable.exe doesn't support profile parameters :  -no-remote -profile
rem
rem note that  ECHO/ for newline is not an official instruction, so remove it fails.
rem be careful, do not add  slash at the end of paths
rem be careful with hidden tab symbols in path etc
rem 
rem  ----------------------------------------------------
rem                SECTION PENDING/BUGS/TO IMPROVE
rem  ----------------------------------------------------
rem CHoice is not part of w2000 and XP commands
rem download https://archive.org/details/MSDOS6.22_201905
rem store CHOICE.COM in folder
rem /M is not compatible with 6.22
rem reemplazar /C 123 por /C:123
rem  limit combination of profile and browser
rem  replace all CMD/K  by START (go back to MENU)
rem  add verbose mode, to print additional ECHO
REM  identify available/existing folders and/or binaries and display
REM  add WAIT_A_MIN pause after launch to all entries

rem  ----------------------------------------------------
rem                SECTION testing -hardcored
rem  ----------------------------------------------------
REM CD /D "C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.10\App\Waterfox"
REM CD
REM CALL Waterfox.exe -v |more
REM IF EXIST C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.10\App\Waterfox\NUL SET Folder1Exist=Available
REM IF NOT EXIST C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.10\App\Waterfox\NUL SET Folder1Exist=Not Available
REM ECHO %Folder1Exist%

rem  ----------------------------------------------------
rem                SECTION 0 - Path Declaration
rem  ----------------------------------------------------

:MAINMENU
CLS
REM required for 2nd and later execution
CD %ROOTDIR%  

SET NAME1=Drive C: (Basilisk default : \Program Files and \Roaming\Moonchild Prod.)		.
SET PATH1=C:\Program Files\Basilisk
SET PROFILE1=C:\Users\danielp\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\7jgwm62d.default
IF EXIST "%PROFILE1%" (SET Profile1Exist=[Y])  ELSE (SET Profile1Exist=[ ])

SET NAME2=Drive C: Basilisk (folder: Portables\BasiliskBrowsers)				.
REM =PC2 - Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH2=C:\Daniel\Portables\BasiliskBrowsers
REM D:\20 Portables\BasiliskBrowsers 
SET PROFILE2=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
REM D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE2% (SET Profile2Exist=[Y]) ELSE (SET Profile2Exist=[ ])


SET NAME3=Drive C: Palemoon (folder: Portables\PalemoonBrowsers)				.
SET PATH3=C:\Daniel\Portables\PalemoonBrowsers
SET PROFILE3=C:\Daniel\Portables\PalemoonBrowsers\Profiles\Default
IF EXIST %PROFILE3% (SET Profile3Exist=[Y]) ELSE (SET Profile3Exist=[ ])

SET NAME4=Drive C: !! Waterfox bin + Basilisk profile (Caution and backup profile)		.
SET PATH4=C:\Daniel\Portables\Waterfox_browsers
REM \WaterfoxPortable56.2.7\App\Waterfox
SET PROFILE4=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE4% (SET Profile4Exist=[Y]) ELSE (SET Profile4Exist=[ ])

SET NAME5=Drive C: Waterfox (folder: Portables\Waterfox_browsers)				.
SET PATH5=C:\Daniel\Portables\Waterfox_browsers
SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\Profile
IF EXIST %PROFILE5% (SET Profile5Exist=[Y]) ELSE (SET Profile5Exist=[ ])
REM DEFAULT profile path
REM SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.7\Data\profile

SET NAME6=Drive C: FirefoxQuantum >57 (folder: Portables\Firefox_browsers)			.
SET PATH6=C:\Daniel\Portables\Firefox_browsers
SET PROFILE6=C:\Daniel\Portables\Firefox_browsers\Profiles\ADDPROFILE
IF EXIST %PROFILE6% (SET Profile6Exist=[Y]) ELSE (SET Profile6Exist=[ ])

SET NAME7=USB PenDrive - Drive G: (folder: Portables\PalemoonBrowsers)				.
SET PATH7=G:\Portables\PalemoonBrowsers 
SET PROFILE7=G:\Portables\PalemoonBrowsers\Profiles\palemoon.default
IF EXIST %PROFILE7% (SET Profile7Exist=[Y]) ELSE (SET Profile7Exist=[ ])

SET NAME8=USB PenDrive - Drive G: (folder: Portables\BasiliskBrowsers)				.
SET PATH8=G:\Portables\BasiliskBrowsers 
SET PROFILE8=G:\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE8% (SET Profile8Exist=[Y]) ELSE (SET Profile8Exist=[ ])

SET NAME9=ANY PORTABLE with its own portable folder						.
rem SET PATH9=no need
rem SET PROFILE9=no need


ECHO "   ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______  "
ECHO "  /_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____/  "
ECHO "      __  ___ ______ _   __ __  __            ______ ____ ____   ______ ______ ____  _  __     "
ECHO "     /  |/  // ____// | / // / / /           / ____//  _// __ \ / ____// ____// __ \| |/ /     "
ECHO "    / /|_/ // __/  /  |/ // / / /  ______   / /_    / / / /_/ // __/  / /_   / / / /|   /      "
ECHO "   / /  / // /___ / /|  // /_/ /  /_____/  / __/  _/ / / _, _// /___ / __/  / /_/ //   |       "
ECHO "  /_/  /_//_____//_/ |_/ \____/           /_/    /___//_/ |_|/_____//_/     \____//_/|_|       "
ECHO "   ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______  "
ECHO "  /_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____/  "

ECHO ***********        Batch Menu for Firefox Browsers       ***************************
ECHO ***********  Focused in FF Legacy (Basilisk/Waterfox/Palemoon and forks)  **********************
ECHO ***********          v %VERSION% (by DaPGo2019) - GPL        ***************************
ECHO ***********   https://github.com/dapgo/Menu_Launcher4multiple_FF      **************
ECHO "   ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______  "
ECHO "  /_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____/  "
 rem ECHO/ white line remove if it fails
ECHO/ 

ECHO OFF
cd

:SECTION1
rem  ----------------------------------------------------
rem                SECTION1 - Root folder and PROFILE folder
rem  ----------------------------------------------------
ECHO ********************************************************************
ECHO ***********         Menu1: SELECT a PATH/DRIVE        **************
ECHO ***********       for Profile(data)/ browser(bin)      *************
ECHO ***********   Help for more info and predefined paths  *************
ECHO ********************************************************************
ECHO/
ECHO [Option] [   Drive   -     BrowserName               (folder)              ]   [Profile available Y/N]
REM ECHO "______  _____________________________________________________     __________________"
ECHO/ 
ECHO 1) %NAME1%  %Profile1Exist%
ECHO 2) %NAME2%  %Profile2Exist%
ECHO 3) %NAME3%  %Profile3Exist%
ECHO 4) %NAME4%  %Profile4Exist%
ECHO 5) %NAME5%  %Profile5Exist%
ECHO 6) %NAME6%  %Profile6Exist%
ECHO 7) %NAME7%  %Profile7Exist%
ECHO 8) %NAME8%  %Profile8Exist%
ECHO 9) %NAME9%  [?]
ECHO H/h) HELP/INFO
ECHO Q/q) Quit/Exit
ECHO/
rem win7 CHOICE /C 123456789HQ /M "Choose an option:"
CHOICE.COM /C:123456789HQ  "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO Path4
IF %ERRORLEVEL% == 5 GOTO Path5
IF %ERRORLEVEL% == 6 GOTO Path6
IF %ERRORLEVEL% == 7 GOTO Path7
IF %ERRORLEVEL% == 8 GOTO Path8
IF %ERRORLEVEL% == 9 GOTO SECTION2
IF %ERRORLEVEL% == 10 GOTO HELP
IF %ERRORLEVEL% == 11 GOTO FIN
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
 ECHO (DRIVE C ) Waterfox with a Basilisk profile (be careful and do not update addons)
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 GOTO SECTION2
:Path5	
 ECHO (DRIVE C )
 SET BROWSERPATH=%PATH5%
 SET PROFILEPATH=%PROFILE5%
 GOTO SECTION2 
 
:Path6	
 ECHO (DRIVE C  Quantum PEND!!!)
 SET BROWSERPATH=%PATH6%
 SET PROFILEPATH=%PROFILE6%
 GOTO SECTION2  
:Path7	
 ECHO (Any computer from USB memory)
 SET BROWSERPATH=%PATH7%
 SET PROFILEPATH=%PROFILE7%
 GOTO SECTION2
 Path8	
 ECHO (Any computer from USB memory)
 SET BROWSERPATH=%PATH8%
 SET PROFILEPATH=%PROFILE8%
 GOTO SECTION2
:HELP		
    CLS
	ECHO "   ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ "
	ECHO "  /_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____/ "
	ECHO "      __  __ ______ __     ____              ____ _   __ ______ ____           "
	ECHO "     / / / // ____// /    / __ \            /  _// | / // ____// __ \          "
	ECHO "    / /_/ // __/  / /    / /_/ /  ______    / / /  |/ // /_   / / / /          "
	ECHO "   / __  // /___ / /___ / ____/  /_____/  _/ / / /|  // __/  / /_/ /           "
	ECHO "  /_/ /_//_____//_____//_/               /___//_/ |_//_/     \____/            "
	ECHO "   ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ "
	ECHO "  /_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____/ "
	ECHO ***********    HELP1: for Firefox Legacy browsers       **************
	ECHO ***********         Information, tips, about            **************
	ECHO **********************************************************************
 rem ECHO/ white line remove if it fails
  ECHO/
  ECHO The default Profile folder name is dynamic and change for each browser/computer, can be renamed when using from Menu/Command line
  ECHO When a common Profile folder is stored at different PCs, changes on both PCs will disalign profile, sync frequently (copy paste after changes)
  ECHO/
  ECHO #tip1: To avoid problems caused by incompatible extensions/add-ins 
  ECHO Share a profile folder among webbrowsers based in same or similar Firefox version
  ECHO #tip2: Disable Addin automatic updates 
  ECHO #tip2: Disable WebBrowser automatic updates 
  ECHO #tip3: Update Addins always from your main browser
  ECHO/
  ECHO #Info about FF extension compatibility
  ECHO Compatible FF27 AddIns(pre Australis UI). Browsers: Palemoon, FF27, Palemoon forks (Mypal, Newmoon, Kmeleon-Goanna), Basilisk!
  ECHO Compatible FF52 (Australis UI) AddIns. Browsers: Basilisk, FF52, Basilisk forks (Centaury, Serpent), Waterfox! ..
  ECHO Compatible FF56 AddIns. Browsers: Waterfox, FF56, ..
  ECHO Compatible FF57 (Quantum) AddIns. Browsers: FF57, FF>57, Waterfox!
  ECHO/
  PAUSE
   ECHO/ 
   
	ECHO **********************************************************************
	ECHO ***********   	HELP2: Browsers/forks INFO    **************
	ECHO **********************************************************************
  ECHO/
  ECHO #Basilisk code: 
  ECHO Basilisk2018 Based FF52.9 Compatible with MozillaSync, SyncTabs, MultiAccount container, basic webext.)
  ECHO Basilisk201906 Based FF52.9 No Compatible with webext. (PM sync)
  ECHO Centaury/Basilisk Based FF52.9 Compat. webextension? (PM sync)
  ECHO #Waterfox code:
  ECHO Waterfox 56.2.10. Based FF56, Compatible with XUL and webextensions  
  ECHO Waterfox Beta. Based FF68, Limited compatibility with XUL - webextensions  
  ECHO #Palemoon code:
  ECHO Palemoon27. Based FF38. Compatible XUL extension FF27(pre Australis UI)(PM sync)
  ECHO Palemoon29. Based FF52. Compatible XUL extension FF27(pre Australis UI)(PM sync)
  ECHO K-meleon74-Goanna2.2. Compatible Windows2000, WinXP, [Win98+KernelEx]
  ECHO K-meleon76-Goanna3.4. Compatible WinXP, Windows2000 (CPU: SSE instructions??)
  PAUSE
  ECHO/
  ECHO **********************************************************************
  ECHO ***********   	HELP3: Browsers/forks Downloads        **************
  ECHO **********************************************************************
  ECHO #Download Basilisk: http://archive.palemoon.org/basilisk/    
  ECHO #Download Palemoon: http://archive.palemoon.org/palemoon/
  ECHO #Download Mypal: https://github.com/Feodor2/Mypal/releases 
  ECHO #Download Centaury: https://github.com/Feodor2/Centaury/releases
  ECHO #ChangeLog for NM28XP, Serpent/UXP, Kmeleon:  http://rtfreesoft.blogspot.com/
  ECHO #Download NewMoon(NM28XP):  https://o.rths.cf/palemoon/
  ECHO #Download Serpent/UXP: https://o.rths.cf/basilisk/
  ECHO #Download K-meleon-Goanna: https://o.rths.cf/kmeleon/
  ECHO/
	ECHO **********************************************************************
	ECHO ***********   	HELP4: PATHS configured in Script        **************
	ECHO **********************************************************************
  ECHO/  
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

SET NAME1=Basilisk201906(64b)					.
SET PATH1BIN=\basilisk_201906\
REM ECHO "%BROWSERPATH%%PATH1BIN%"
IF EXIST "%BROWSERPATH%%PATH1BIN%" (SET Bin1Exist=[Y])  ELSE (SET Bin1Exist=[ ])

SET NAME2=Serpent(32b/XP) 201908 (Basilisk fork)		.
SET PATH2BIN=\Serpent201908_wXP\
REM ECHO "%BROWSERPATH%%PATH2BIN%"
IF EXIST "%BROWSERPATH%%PATH2BIN%" (SET Bin2Exist=[Y])  ELSE (SET Bin2Exist=[ ])

SET NAME3=Serpent(32b/XP) 2018 (Basilisk fork inc. SYNC)	.
SET PATH3BIN=\Serpent201806_wXP\
IF EXIST "%BROWSERPATH%%PATH3BIN%" (SET Bin3Exist=[Y])  ELSE (SET Bin3Exist=[ ])

SET NAME4=Centaury(32b/XP) 0.0.5/201905 (Basilisk fork)	.
SET PATH4BIN=\Centaury_201905_wXP\
IF EXIST "%BROWSERPATH%%PATH4BIN%" (SET Bin4Exist=[Y])  ELSE (SET Bin4Exist=[ ])

SET NAME5=Centaury(32b/XP) 201809 (Basilisk fork inc. SYNC)	.
SET PATH5BIN=\Centaury201809_wXP\
IF EXIST "%BROWSERPATH%%PATH5BIN%" (SET Bin5Exist=[Y])  ELSE (SET Bin5Exist=[ ])

SET NAME6=Waterfox 56.2.10 (64b)				.
SET PATH6BIN=\WaterfoxPortable56.2.10\App\Waterfox\
IF EXIST "%BROWSERPATH%%PATH6BIN%" (SET Bin6Exist=[Y])  ELSE (SET Bin6Exist=[ ])

SET NAME7=Palemoon29 (32b)					.
SET PATH7BIN=\PM29_32b\Bin\Palemoon\
IF EXIST "%BROWSERPATH%%PATH7BIN%" (SET Bin7Exist=[Y])  ELSE (SET Bin7Exist=[ ])

SET NAME8=MyPal(32b/XP)(Palemoon fork)				.
SET PATH8BIN=\Mypal28_61_wXP\
IF EXIST "%BROWSERPATH%%PATH8BIN%" (SET Bin8Exist=[Y])  ELSE (SET Bin8Exist=[ ])

SET NAME9=K-meleon Goanna(32b/XP)				.
SET PATH9BIN=\KM-Goanna\
IF EXIST "%BROWSERPATH%%PATH9BIN%" (SET Bin9Exist=[Y])  ELSE (SET Bin9Exist=[ ])

SET NAMEA=Firefox Portable 12 (32b)				.
SET PATHABIN=C:\Daniel\Portables\Firefox\FirefoxPortable12\
IF EXIST "%PATHABIN%" (SET BinAExist=[Y])  ELSE (SET BinAExist=[ ])

SET NAMEB=Firefox Portable 3.6 (32b)				.
SET PATHBBIN=C:\Daniel\Portables\Firefox\FirefoxPortableLegacy36\
IF EXIST "%PATHBBIN%" (SET BinBExist=[Y])  ELSE (SET BinBExist=[ ])

rem  ----------------------------------------------------
rem                SECTION2 - Executable folder and filename 
rem  ----------------------------------------------------
rem ECHO/ white line remove if it fails
ECHO/ 
ECHO **********************************************************************************
ECHO ********  Menu2:   SELECT a WebBrowser version/fork                   ************
ECHO ********  [Y] = Available and compatible with previous profile/root  *************
ECHO **********************************************************************************
ECHO/
ECHO [Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]
ECHO/
ECHO 1) %NAME1%  %Bin1Exist%
ECHO 2) %NAME2%  %Bin2Exist%
ECHO 3) %NAME3%  %Bin3Exist%
ECHO 4) %NAME4%  %Bin4Exist%
ECHO 5) %NAME5%  %Bin5Exist%
ECHO 6) %NAME6%  %Bin6Exist%
ECHO 7) %NAME7%  %Bin7Exist%
ECHO 8) %NAME8%  %Bin8Exist%
ECHO 9) %NAME9%  %Bin9Exist%
ECHO A) %NAMEA%  %BinAExist%
ECHO B) %NAMEB%  %BinBExist%
ECHO H/h) HELP/INFO
ECHO Q/q) Quit/Exit
ECHO/
rem win7 CHOICE /C 123456789ABHQ /M "Choose an option:"
CHOICE.COM /C:123456789ABHQ "Choose an option:"
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO basilisk
rem IF %ERRORLEVEL% == 2 GOTO basilisksync
IF %ERRORLEVEL% == 2 GOTO serpent201908_wXP
IF %ERRORLEVEL% == 3 GOTO serpent_xp
IF %ERRORLEVEL% == 4 GOTO centaury2019_xp
IF %ERRORLEVEL% == 5 GOTO centaury2018_xp
IF %ERRORLEVEL% == 6 GOTO waterfox_new
IF %ERRORLEVEL% == 7 GOTO Palemoon
IF %ERRORLEVEL% == 8 GOTO Mypal28
IF %ERRORLEVEL% == 9 GOTO KmeleonGoanna
IF %ERRORLEVEL% == 10 GOTO Firefox12
IF %ERRORLEVEL% == 11 GOTO Firefox3
IF %ERRORLEVEL% == 12 GOTO HELP
IF %ERRORLEVEL% == 13 GOTO FIN
GOTO FIN

:WAIT_A_MIN
ECHO **********************************************************************************
ECHO ********     Selected WebBrowser is being launched                    ************
ECHO ********           Please Wait a Minute                              *************
ECHO **********************************************************************************
pause
GOTO MAINMENU

:basilisk
 REM CD /D "%BROWSERPATH%\basilisk_201906\"
 CD /D "%BROWSERPATH%%PATH1BIN%"
 CD
 CALL NO_use_EXE_basilisk.exe -v |more
 START NO_use_EXE_basilisk.exe -no-remote -profile "%PROFILEPATH%"
 REM cmd /K NO_use_EXE_basilisk.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN				

rem :basilisksync
rem CD /D "%BROWSERPATH%%PATH2BIN%"
rem CD 
 rem CALL NO_use_EXE_basilisk_ffsync.exe -v |more
 rem START NO_use_EXE_basilisk_ffsync.exe -no-remote -profile "%PROFILEPATH%"
 rem GOTO WAIT_A_MIN	
 
:serpent201908_wXP
 REM CD /D "%BROWSERPATH%\basilisk_2018_SYNC\"
 CD /D "%BROWSERPATH%%PATH2BIN%"
 CD 
 CALL basilisk.exe -v |more
 START basilisk.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN	
 
:serpent_xp		
 CD /D "%BROWSERPATH%%PATH3BIN%"
 CD 
 CALL basilisk.exe -v |more
 START basilisk.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN	

:centaury2019_xp				
 CD /D "%BROWSERPATH%%PATH4BIN%"
 CD 
 CALL centaury.exe -v |more
 START centaury.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN	
 
:centaury2018_xp				
 CD /D "%BROWSERPATH%%PATH5BIN%"
 CD 
 CALL centaury.exe -v |more
 START centaury.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN	
 
:waterfox_old
  REM CD /D "%BROWSERPATH%\WaterfoxPortable56.2.7\App\Waterfox\"
 CD /D "%BROWSERPATH%%PATH5BIN%"
 CD 
 CALL Waterfox.exe -v |more
 START Waterfox.exe -no-remote -profile %PROFILEPATH%		
 GOTO WAIT_A_MIN		
 
:waterfox_new				
  REM CD /D "%BROWSERPATH%\WaterfoxPortable56.2.10\App\Waterfox\"
 CD /D "%BROWSERPATH%%PATH6BIN%"
 CD
 CALL Waterfox.exe -v |more
 START Waterfox.exe -no-remote -profile "%PROFILEPATH%"
 rem CMD /K Waterfox.exe -no-remote -profile "%PROFILEPATH%"
 rem Manual path just for testing 
 rem path inside double quotes fail!
 rem OK CMD /K Waterfox.exe -no-remote -profile C:\Daniel\Portables\Waterfox_browsers\Profile
 GOTO WAIT_A_MIN
 
:Palemoon 
 rem CD /D "%BROWSERPATH%\PM29_32b\Bin\Palemoon\"
 CD /D "%BROWSERPATH%%PATH7BIN%"
 CD
 CALL palemoon.exe -v |more
 rem portable.exe doesn't support -no-remote -profile "%PROFILEPATH%"			
 START palemoon.exe -no-remote -profile "%PROFILEPATH%"		
 GOTO WAIT_A_MIN
 
 
:Mypal28
 CD /D "%BROWSERPATH%%PATH8BIN%"
 CD
 CALL Mypal.exe -v |more
 START Mypal.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
 :KmeleonGoanna
 CD /D "%BROWSERPATH%%PATH9BIN%"
 CD
 rem nas not command line CALL k-meleon.exe -v |more
 START k-meleon.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
 :Firefox12
 CD /D "%PATHABIN%"
 CALL FirefoxPortable12.exe -v |more
 START FirefoxPortable12.exe
 GOTO WAIT_A_MIN
 
 :Firefox3
 CD /D "%PATHBBIN%"
 CALL FirefoxPortable36.exe -v |more
 START FirefoxPortable36.exe
 GOTO WAIT_A_MIN
 
:FIN				
ECHO You can close this window				
EXIT