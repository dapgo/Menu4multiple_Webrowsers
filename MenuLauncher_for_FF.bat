@echo OFF
SET VERSION=1.93(201909)
SET V_MODEDEBUG=N
REM SET V_MODEDEBUG=Y 
REM Debug and Verbose output mode
SET V_VERBOSELIST=NO
REM SET V_VERBOSELIST=ALL  
REM ALL will list all browsers in MenuScreen2
IF %V_MODEDEBUG% ==Y (  
	ver 
	wmic os get version
	)

rem findstr usign regexp not supported in Reactos
ver | findstr /i "5\.0\." >nul && ( ECHO Windows2000 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "5\.1\." >nul && ( echo WindowsXP32bit & SET VAR_OS=WINXP_W2003) 
ver | findstr /i "5\.2\." >nul && ( echo WindowsXP64b/WinServer2003 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "ReactOS" >nul && ( ECHO ReactOS/Windows & SET VAR_OS=REACTOS)
ver | findstr /i "6\.0\." > nul && ( ECHO Windows Vista/Server2008 & SET VAR_OS=WIN7)
ver | findstr /i "6.1." > nul && ( ECHO win7/Server2008R2 & SET VAR_OS=WIN7 )
rem ver | findstr /i "6.1." > nul && ( SET VAR_OS=REACTOS )
rem ver | findstr /i "6\.1\." > nul && (echo Windows 7 / Server 2008R2 & GOTO :WIN7)
ver | findstr /i "6\.2\." > nul && (echo Windows8/Server2012 & SET VAR_OS=WIN7 )
ver | findstr /i "6\.3\." > nul && (echo Windows8.1/Server2012R2 & SET VAR_OS=WIN7 )
ver | findstr /i "10\.0\." > nul && (echo Windows10/Server2016 & SET VAR_OS=WIN7 )

ECHO OS detected: %VAR_OS%

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
rem                SECTION 0 - Variables and Path Declaration
rem  ----------------------------------------------------

:MAINMENU

SET V_FAMILY=%V_VERBOSELIST%
REM SET V_FAMILY=ALL
REM ALL will list all browsers in Menu
REM NO or something else, will list only these browsers compatible with a specific family  
CLS
SET NAME1=FF52/Basilisk (C:  \Program Files + \Roaming\Moonchild Prod.)	.
SET PATH1=C:\Program Files\Basilisk
SET PROFILE1=C:\Users\danielp\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\7jgwm62d.default
IF EXIST "%PROFILE1%" (SET Profile1Exist=[Y])  ELSE (SET Profile1Exist=[ ])

SET NAME2=FF52/Basilisk (C: folder: Portables\BasiliskBrowsers)		.
REM =PC2 - Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH2=C:\Daniel\Portables\BasiliskBrowsers
REM D:\20 Portables\BasiliskBrowsers 
SET PROFILE2=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
REM D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE2% (SET Profile2Exist=[Y]) ELSE (SET Profile2Exist=[ ])


SET NAME3=FF28/Palemoon (C: folder: Portables\PalemoonBrowsers)		.
SET PATH3=C:\Daniel\Portables\PalemoonBrowsers
SET PROFILE3=C:\Daniel\Portables\PalemoonBrowsers\Profiles\Default
IF EXIST %PROFILE3% (SET Profile3Exist=[Y]) ELSE (SET Profile3Exist=[ ])

SET NAME4=!! FF52/Basilisk + Waterfox bin +  (C: Caution and backup profile)	.
SET PATH4=C:\Daniel\Portables\Waterfox_browsers
REM \WaterfoxPortable56.2.7\App\Waterfox
SET PROFILE4=C:\Daniel\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE4% (SET Profile4Exist=[Y]) ELSE (SET Profile4Exist=[ ])

SET NAME5=FF56/Waterfox (C: folder: Portables\Waterfox_browsers)		.
SET PATH5=C:\Daniel\Portables\Waterfox_browsers
SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\Profile
IF EXIST %PROFILE5% (SET Profile5Exist=[Y]) ELSE (SET Profile5Exist=[ ])
REM DEFAULT profile path
REM SET PROFILE5=C:\Daniel\Portables\Waterfox_browsers\WaterfoxPortable56.2.7\Data\profile

SET NAME6=FF57/FirefoxQuantum (C: folder: Portables\QuantumBrowsers)		.
SET PATH6=C:\Daniel\Portables\QuantumBrowsers
SET PROFILE6=C:\Daniel\Portables\QuantumBrowsers\Profiles\1a9stydz.dev-default
IF EXIST %PROFILE6% (SET Profile6Exist=[Y]) ELSE (SET Profile6Exist=[ ])

SET NAME7=USB PenDrive - Drive G: (folder: Portables\PalemoonBrowsers)		.
SET PATH7=G:\Portables\PalemoonBrowsers 
SET PROFILE7=G:\Portables\PalemoonBrowsers\Profiles\palemoon.default
IF EXIST %PROFILE7% (SET Profile7Exist=[Y]) ELSE (SET Profile7Exist=[ ])

SET NAME8=USB PenDrive - Drive G: (folder: Portables\BasiliskBrowsers)		.
SET PATH8=G:\Portables\BasiliskBrowsers 
SET PROFILE8=G:\Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE8% (SET Profile8Exist=[Y]) ELSE (SET Profile8Exist=[ ])


SET NAME9=ANY PORTABLE with its own portable folder				.
rem SET PATH9=no need
rem SET PROFILE9=noo need

ECHO "  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
ECHO " |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
ECHO "  __  __ _____ _   _ _   _           _____ ___ ____  _____ _____ _____  __ "
ECHO " |  \/  | ____| \ | | | | |         |  ___|_ _|  _ \| ____|  ___/ _ \ \/ / "
ECHO " | |\/| |  _| |  \| | | | |  _____  | |_   | || |_) |  _| | |_ | | | \  /  "
ECHO " | |  | | |___| |\  | |_| | |_____| |  _|  | ||  _ <| |___|  _|| |_| /  \  "
ECHO " |_|  |_|_____|_| \_|\___/          |_|   |___|_| \_|_____|_|   \___/_/\_\ "

ECHO ******  v %VERSION%	 (by DaPGo) - GPL  - FullList: %V_FAMILY%	**************
ECHO ******   https://github.com/dapgo/Menu_Launcher4multiple_FF      *********
ECHO " _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
ECHO "|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
 rem ECHO/ white line remove if it fails

ECHO OFF
IF "%V_MODEDEBUG%" == "Y"  ( 
   CD
   ver
 )

:SECTION1
rem  ----------------------------------------------------
rem                SECTION1 - Root folder and PROFILE folder
rem  ----------------------------------------------------
rem ECHO ********************************************************************
ECHO ***********   Menu1: PROFILE - SELECT a PATH/DRIVE     **************
ECHO *********** H) Help for more info and predefined paths *************
ECHO ********************************************************************
ECHO/
ECHO [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
REM ECHO "______  ___________________________________     __________________"
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
REM ###### CHOICE OS VARIANTS MENU1 ######
IF %VAR_OS% == WIN7 ( 	
	CHOICE /C 123456789HQ /M "Choose an option:"
	)
IF %VAR_OS% == REACTOS ( 	
	CHOICE /C:123456789HQ "Choose an option:"
)
IF %VAR_OS% == WINXP_W2003 ( 	
	CHOICE.COM /C:123456789HQ "Choose an option:"
)
	
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO Path4
IF %ERRORLEVEL% == 5 GOTO Path5
IF %ERRORLEVEL% == 6 GOTO Path6
IF %ERRORLEVEL% == 7 GOTO Path7
IF %ERRORLEVEL% == 8 GOTO Path8
IF %ERRORLEVEL% == 9 GOTO Path9
IF %ERRORLEVEL% == 10 GOTO HELP
IF %ERRORLEVEL% == 11 GOTO FIN
GOTO SECTION1

:Path1 
 SET BROWSERPATH=%PATH1%
 SET PROFILEPATH=%PROFILE1%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=52 
 GOTO SECTION2
 
:Path2	  
 SET BROWSERPATH=%PATH2%
 SET PROFILEPATH=%PROFILE2%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=52
 GOTO SECTION2
 
:Path3	 
 SET BROWSERPATH=%PATH3%
 SET PROFILEPATH=%PROFILE3%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=27
 GOTO SECTION2
:Path4	 
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=56
 GOTO SECTION2
:Path5	
 SET BROWSERPATH=%PATH5%
 SET PROFILEPATH=%PROFILE5%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=56
 GOTO SECTION2 
 
:Path6	
 SET BROWSERPATH=%PATH6%
 SET PROFILEPATH=%PROFILE6%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=57
 GOTO SECTION2  
:Path7	
 SET BROWSERPATH=%PATH7%
 SET PROFILEPATH=%PROFILE7%
 IF NOT "%V_FAMILY%"=="ALL" SET V_FAMILY=27
 GOTO SECTION2
:Path8	
 SET BROWSERPATH=%PATH8%
 SET PROFILEPATH=%PROFILE8%
 IF NOT "%V_FAMILY%"=="ALL" SET "V_FAMILY=52
 GOTO SECTION2
 
:Path9	 
 IF NOT "%V_FAMILY%"=="ALL" SET "V_FAMILY=00
 GOTO SECTION2 
 
:HELP		
    CLS
	
	ECHO "      __  __ ______ __     ____              ____ _   __ ______ ____     "
	ECHO "     / / / // ____// /    / __ \            /  _// | / // ____// __ \    "
	ECHO "    / /_/ // __/  / /    / /_/ /  ______    / / /  |/ // /_   / / / /    "
	ECHO "   / __  // /___ / /___ / ____/  /_____/  _/ / / /|  // __/  / /_/ /     "
	ECHO "  /_/ /_//_____//_____//_/               /___//_/ |_//_/     \____/      "
	ECHO **********************************************************************
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
  ECHO Basilisk2018 Based FF52.9 Compatible with MozillaSync, MultiAccount container, basic webext.)(UXP)
  ECHO Basilisk201906 Based FF52.9 Incompatible with webext. (PM sync) (UXP)
  ECHO Centaury/Basilisk Based FF52.9 Compat. webextension? (PM sync) (UXP)
  ECHO #Waterfox code:
  ECHO Waterfox 56.2.10. Based FF56, Compatible with XUL and webextensions  
  ECHO Waterfox Beta. Based FF68, Limited compatibility with XUL - webextensions  
  ECHO #Palemoon code:
  ECHO Palemoon27. Based FF38. Compatible XUL extension FF27(pre Australis UI)(PM sync)
  ECHO Palemoon28. Based FF52. Compatible XUL extension FF27(pre Australis UI)(PM sync)(UXP)
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
  ECHO About: By Daniel Perez Gonzalez 
  ECHO/
  PAUSE
  CLS
  GOTO MAINMENU



rem  ----------------------------------------------------
rem                SECTION2 - Executable folder and filename 
rem  ----------------------------------------------------

  
:SECTION2
CLS

IF "%V_MODEDEBUG%" == "Y"  (  
    
    ECHO Browser Compatible/Family: %V_FAMILY%  Debug: %V_MODEDEBUG%
	ECHO Profile: %PROFILEPATH% 
	ECHO Bin: %BROWSERPATH%
  )
ECHO/ 
rem ECHO/ white line remove if it fails
ECHO *************************************************************************
ECHO ******  Menu2:   SELECT a WebBrowser version/fork                  ******
ECHO ******  [Y] = Available and compatible with previous profile/root  ******
ECHO *************************************************************************
ECHO/
ECHO [Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]
ECHO/

IF "%V_FAMILY%"=="52" GOTO SECTION2.1_GROUP1
IF "%V_FAMILY%"=="56" GOTO SECTION2.1_GROUP2
IF "%V_FAMILY%"=="27" GOTO SECTION2.1_GROUP3
IF "%V_FAMILY%"=="57" GOTO SECTION2.1_GROUP4
IF "%V_FAMILY%"=="00" GOTO SECTION2.1_GROUP5


REM ### BEGIN FF52 #####    
:SECTION2.1_GROUP1
	SET NAME1=Basilisk201906(64b)					.
	SET PATH1BIN=\basilisk_201906\
	IF EXIST "%BROWSERPATH%%PATH1BIN%" (SET Bin1Exist=[Y])  ELSE (SET Bin1Exist=[ ])

	SET NAME2=Basilisk2018(64b) (Mozilla SYNC)			.
	SET PATH2BIN=\basilisk_2018_SYNC\
	IF EXIST "%BROWSERPATH%%PATH2BIN%" (SET Bin2Exist=[Y])  ELSE (SET Bin2Exist=[ ])

	SET NAME3=Serpent(32b/XP) 201908 (Basilisk fork inc. SYNC)	.
	SET PATH3BIN=\Serpent_201908_wXP\
	IF EXIST "%BROWSERPATH%%PATH3BIN%" (SET Bin3Exist=[Y])  ELSE (SET Bin3Exist=[ ])

	SET NAME4=Centaury(32b/XP) 0.0.6/201909 (Basilisk fork)	.
	SET PATH4BIN=\Centaury_201909_006_wXP\
	IF EXIST "%BROWSERPATH%%PATH4BIN%" (SET Bin4Exist=[Y])  ELSE (SET Bin4Exist=[ ])

	IF NOT "%V_FAMILY%"=="ALL" GOTO SECTION2.2
REM ### END FF52  #####    

REM BEGIN FF56 #####
:SECTION2.1_GROUP2
	SET NAME5=Waterfox 56.2.7 (64b)				.
	SET PATH5BIN=\WaterfoxPortable56.2.7\App\Waterfox\
	IF EXIST "%BROWSERPATH%%PATH5BIN%" (SET Bin5Exist=[Y])  ELSE (SET Bin5Exist=[ ])

	SET NAME6=Waterfox 56.2.14 (64b)				.
	SET PATH6BIN=\WaterfoxPortable56.2.14\App\Waterfox\
	IF EXIST "%BROWSERPATH%%PATH6BIN%" (SET Bin6Exist=[Y])  ELSE (SET Bin6Exist=[ ])

	IF NOT "%V_FAMILY%"=="ALL" GOTO SECTION2.2
REM END FF52  #####    

REM BEGIN FF27/28 #####
:SECTION2.1_GROUP3
	SET NAME7=Palemoon28.5.2 (32b)					.
	SET PATH7BIN=\PM2852_32b\Bin\Palemoon\
	IF EXIST "%BROWSERPATH%%PATH7BIN%" (SET Bin7Exist=[Y])  ELSE (SET Bin7Exist=[ ])

	SET NAME8=MyPal28 (32b/XP)					.
	SET PATH8BIN=\Mypal28_61_wXP\
	IF EXIST "%BROWSERPATH%%PATH8BIN%" (SET Bin8Exist=[Y])  ELSE (SET Bin8Exist=[ ])

	rem SET NAME9=NewMoon28 201908(32b/XP)				.
	rem SET PATH9BIN=\NewMoon287_201908_wXP\
	SET NAME9=NewMoon27.9.6 (32b/XP)				.
	SET PATH9BIN=\Newmoon2796_wXP\
	IF EXIST "%BROWSERPATH%%PATH9BIN%" (SET Bin9Exist=[Y])  ELSE (SET Bin9Exist=[ ])

	REM END FF27/28 #####
	SET NAMEA=MyPal27.9.4 (32b/XP/ReactOS)				.
	SET PATHABIN=\Mypal27_94_wXP\
	IF EXIST "%BROWSERPATH%%PATHABIN%" (SET BinAExist=[Y])  ELSE (SET BinAExist=[ ])
	
	IF NOT "%V_FAMILY%"=="ALL" GOTO SECTION2.2

REM BEGIN FF57 #####
:SECTION2.1_GROUP4
	SET NAMEB=Firefox Quantum v5704 (64b) 				.
	SET PATHBBIN=\FirefoxPortableQ5704\App\Firefox64\
	IF EXIST "%BROWSERPATH%%PATHBBIN%" (SET BinBExist=[Y])  ELSE (SET BinBExist=[ ])

	SET NAMEC=Firefox Dev Edition 70 (64b) 			.
	SET PATHCBIN=\FirefoxDev_70_x64\
	IF EXIST "%BROWSERPATH%%PATHCBIN%" (SET BinCExist=[Y])  ELSE (SET BinCExist=[ ])

	SET NAMED=Waterfox68beta (64b) 				.
	SET PATHDBIN=\PENDING\
	IF EXIST "%BROWSERPATH%%PATHDBIN%" (SET BinDExist=[Y])  ELSE (SET BinDExist=[ ])
	
	IF NOT "%V_FAMILY%"=="ALL" GOTO SECTION2.2
REM END FF57 #####

REM BEGIN Portables #####
:SECTION2.1_GROUP5
	SET NAMEE=Firefox Portable 12 (32b)				.
	SET PATHEBIN=C:\Daniel\Portables\Firefox\FirefoxPortable12\
	IF EXIST "%PATHEBIN%" (SET BinEExist=[Y])  ELSE (SET BinEExist=[ ])

	SET NAMEF=Firefox Portable 3.6 (32b)				.
	SET PATHFBIN=C:\Daniel\Portables\Firefox\FirefoxPortableLegacy36\
	IF EXIST "%PATHFBIN%" (SET BinFExist=[Y])  ELSE (SET BinFExist=[ ])
	
	SET NAMEG=Firefox Portable Quantum (64b)			.
	SET PATHGBIN=C:\Daniel\Portables\Firefox\PEND\
	IF EXIST "%PATHFBIN%" (SET BinGExist=[Y])  ELSE (SET BinGExist=[ ])
	
	SET NAMEI=K-meleon 76 Goanna 3.4(32b/XP)			.
	SET PATHIBIN=C:\Daniel\Portables\PalemoonBrowsers\KM76.2_20190831\
	IF EXIST "%PATHIBIN%" (SET BinIExist=[Y])  ELSE (SET BinIExist=[ ])
	
	SET NAMEJ=K-(32b/XP)			.
	SET PATHJBIN=C:\Daniel\Portables\PalemoonBrowsers\
	IF EXIST "%PATHJBIN%" (SET BinIExist=[Y])  ELSE (SET BinIExist=[ ])
	
REM END Portables #####



:SECTION2.2
IF "%V_FAMILY%"=="52" GOTO SECTION2.2_GROUP1
IF "%V_FAMILY%"=="56" GOTO SECTION2.2_GROUP2
IF "%V_FAMILY%"=="27" GOTO SECTION2.2_GROUP3
IF "%V_FAMILY%"=="57" GOTO SECTION2.2_GROUP4
IF "%V_FAMILY%"=="00" GOTO SECTION2.2_GROUP5
REM Otherwise (and value ALL) display entries

:SECTION2.2_GROUP1
ECHO 1) %NAME1%  %Bin1Exist%
ECHO 2) %NAME2%  %Bin2Exist%
ECHO 3) %NAME3%  %Bin3Exist%
ECHO 4) %NAME4%  %Bin4Exist%
IF NOT "%V_FAMILY%"=="ALL" GOTO MENU2_CHOICE

:SECTION2.2_GROUP2
ECHO 5) %NAME5%  %Bin5Exist%
ECHO 6) %NAME6%  %Bin6Exist%
IF NOT "%V_FAMILY%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP3
ECHO 7) %NAME7%  %Bin7Exist%
ECHO 8) %NAME8%  %Bin8Exist%
ECHO 9) %NAME9%  %Bin9Exist%
ECHO A) %NAMEA%  %BinAExist%
IF NOT "%V_FAMILY%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP4
ECHO B) %NAMEB%  %BinBExist%
ECHO C) %NAMEC%  %BinCExist%
ECHO D) %NAMED%  %BinDExist%
IF NOT "%V_FAMILY%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP5
ECHO E) %NAMEE%  %BinEExist%
ECHO F) %NAMEF%  %BinFExist%
ECHO G) %NAMEG%  %BinGExist%
ECHO I) %NAMEI%  %BinIExist%
ECHO J) %NAMEJ%  %BinJExist%
IF NOT "%V_FAMILY%"=="ALL" GOTO MENU2_CHOICE
:MENU2_CHOICE
ECHO H/h) HELP/INFO
ECHO Q/q) Quit/Exit
ECHO/

REM ###### CHOICE OS VARIANTS MENU2 ######
IF %VAR_OS% == WIN7 ( 
	CHOICE /C 123456789ABCDEFGIJHQ /M "Choose an option:"
	)
IF %VAR_OS% == REACTOS ( 	
	CHOICE /C:123456789ABCDEFGIJHQ  "Choose an option:"	
)
IF %VAR_OS% == WINXP_W2003 ( 	
	CHOICE.COM /C:123456789ABCDEFGIJHQ  "Choose an option:"	
)


ECHO/ 
IF %ERRORLEVEL% == 1 GOTO label_1
IF %ERRORLEVEL% == 2 GOTO label_2
IF %ERRORLEVEL% == 3 GOTO label_3
IF %ERRORLEVEL% == 4 GOTO label_4
IF %ERRORLEVEL% == 5 GOTO label_5
IF %ERRORLEVEL% == 6 GOTO label_6
IF %ERRORLEVEL% == 7 GOTO label_7
IF %ERRORLEVEL% == 8 GOTO label_8
IF %ERRORLEVEL% == 9 GOTO label_9
IF %ERRORLEVEL% == 10 GOTO label_A
IF %ERRORLEVEL% == 11 GOTO label_B
IF %ERRORLEVEL% == 12 GOTO label_C
IF %ERRORLEVEL% == 13 GOTO label_D
IF %ERRORLEVEL% == 14 GOTO label_E
IF %ERRORLEVEL% == 15 GOTO label_F
IF %ERRORLEVEL% == 16 GOTO PEND!
IF %ERRORLEVEL% == 17 GOTO label_I
IF %ERRORLEVEL% == 18 GOTO label_J
IF %ERRORLEVEL% == 19 GOTO HELP
IF %ERRORLEVEL% == 20 GOTO FIN
GOTO FIN

:WAIT_A_MIN
ECHO **********************************************************************
ECHO ********     Selected WebBrowser is being launched        ************
ECHO ********           Please Wait a Minute                  *************
ECHO ***************************************************** ****************
pause
GOTO MAINMENU

REM *************** SECTION FF52_BASILISK *************** 
REM ***************************************************** 


:label_1
 rem basilisk
 REM basilisk_201906
 CD /D "%BROWSERPATH%%PATH1BIN%"
 CD
 CALL NO_use_EXE_basilisk.exe -v |more
 START NO_use_EXE_basilisk.exe -no-remote -profile "%PROFILEPATH%" 
 GOTO WAIT_A_MIN				

:label_2
 rem basilisksync 
 CD /D "%BROWSERPATH%%PATH2BIN%"
 CD 
 CALL NO_use_EXE_basilisk_ffsync.exe -v |more
 START NO_use_EXE_basilisk_ffsync.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN	
 
:label_3
 rem serpent201908_wXP
 CD /D "%BROWSERPATH%%PATH3BIN%"
 CD 
 CALL basilisk.exe -v |more
 START basilisk.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
:label_4
 rem centaury_xp				
 CD /D "%BROWSERPATH%%PATH4BIN%"
 CD 
 CALL centaury.exe -v |more
 START centaury.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN		
 
REM *************** SECTION FF56_WATERFOX *************** 
REM ***************************************************** 
 
:label_5
 rem waterfox_old  
 CD /D "%BROWSERPATH%%PATH5BIN%"
 CD 
 CALL Waterfox.exe -v |more
 START Waterfox.exe -no-remote -profile %PROFILEPATH%		
 GOTO WAIT_A_MIN		
 
:label_6
 rem waterfox_new				 
 CD /D "%BROWSERPATH%%PATH6BIN%"
 CD
 CALL Waterfox.exe -v |more
 START Waterfox.exe -no-remote -profile "%PROFILEPATH%" 
 rem Manual path just for testing 
 rem path inside double quotes fail!
 rem OK CMD /K Waterfox.exe -no-remote -profile C:\Daniel\Portables\Waterfox_browsers\Profile
 GOTO WAIT_A_MIN
 
REM *************** SECTION FF27_PALEMOON *************** 
REM ***************************************************** 
 
:label_7
REM Palemoon  
 CD /D "%BROWSERPATH%%PATH7BIN%"
 CD
 CALL palemoon.exe -v |more
 rem portable.exe doesn't support -no-remote -profile "%PROFILEPATH%"			
 START palemoon.exe -no-remote -profile "%PROFILEPATH%"		
 GOTO WAIT_A_MIN
 
:label_8
 REM Mypal28
 CD /D "%BROWSERPATH%%PATH8BIN%"
 CD
 CALL Mypal.exe -v |more
 START Mypal.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
:label_9
 REM Newmoon
 CD /D "%BROWSERPATH%%PATH9BIN%"
 CD
 CALL palemoon.exe -v |more
 START palemoon.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
:label_A
 REM Mypal27
 CD /D "%BROWSERPATH%%PATHABIN%"
 CD
 CALL Mypal.exe -v |more
 START Mypal.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN
 
 
 
REM *************** SECTION FF57_QUANTUM *************** 
REM ****************************************************

:label_B
 REM Quantum57
 CD /D "%BROWSERPATH%%PATHBBIN%"
 CD
 CALL firefox.exe -v |more
 START firefox.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN

:label_C
 REM Quantum57
 CD /D "%BROWSERPATH%%PATHCBIN%"
 CD
 CALL firefox.exe -v |more
 START firefox.exe -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN 
 
 
REM *************** SECTION portables (own local profile) *************** 
REM ***************************************************** 
 
:label_E
 rem Firefox12
 CD /D "%PATHEBIN%"
 CALL FirefoxPortable12.exe -v |more
 START FirefoxPortable12.exe
 GOTO WAIT_A_MIN
:label_F
 rem Firefox3
 CD /D "%PATHFBIN%"
 CALL FirefoxPortable36.exe -v |more
 START FirefoxPortable36.exe
 GOTO WAIT_A_MIN

:label_I
 rem KmeleonGoanna
 CD /D "%PATHIBIN%"
 CD
 rem nas not command line CALL k-meleon.exe -v |more
 rem START k-meleon.exe 
rem  START k-meleon.exe -P "Default"
 START k-meleon.exe 
 GOTO WAIT_A_MIN
rem START k-meleon.exe -P "Default" -profilesDir "C:\Daniel\Portables\PalemoonBrowsers\KM-Goanna\Profiles\"
 
:FIN				
ECHO You can close this window				
EXIT