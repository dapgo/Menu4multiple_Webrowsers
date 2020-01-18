@echo OFF
rem Menu Launcher for multiple Firefox/webbrowsers
rem https://github.com/dapgo/Menu_Launcher4multiple_FF
rem ucbrowser installed extensions are not read by other chromium encripted?
rem install from file crx version number invalid
rem 
rem edge datadir \ChromeBrowsers\Profiles_edge
rem edge extensions at C:\Daniel\Portables\ChromeBrowsers\Profiles_edge\Default\Extensions
rem 
rem chromium77  extensions  - datadir \ChromeBrowsers\Profiles
rem C:\Daniel\Portables\ChromeBrowsers\Profiles\Default\Extensions

REM pending add/test LANG string to reactos winxp
rem pend free variables mem when not using
rem  ----------------------------------------------------
rem                SECTION Vars and input parameters
rem  ----------------------------------------------------

SET VERSION=2.8(202001)
REM Store the path were Menu.batch is located
SET PATH_MENUBIN=%~dp0
REM root folder for browser families


REM ---ROOT PATH --- current chdir or a hardcoded path 
REM SET PATH_ROOT_CONTENT=C:\Daniel\00_PortableBrowsers
SET PATH_ROOT_CONTENT=%CD%
ECHO PATH %PATH_ROOT_CONTENT%


SET V_MODEDEBUG=N
SET V_LANG=EN

REM SET V_MODEDEBUG=Y 
REM Values Y or something else

REM ALL/Verbose output, Menu2 includes the full list of webbrowsers
SET V_VERBOSELIST=N
REM SET V_VERBOSELIST=ALL 
REM Values ALL or something else 

IF %V_MODEDEBUG% ==Y (  
	ver 
	wmic os get version
	)

rem findstr using regexp not supported in Reactos
ver | findstr /i "5\.0\." >nul && ( ECHO Windows2000 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "5\.1\." >nul && ( echo WindowsXP32bit & SET VAR_OS=WINXP_W2003) 
ver | findstr /i "5\.2\." >nul && ( echo WindowsXP64b/WinServer2003 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "ReactOS" >nul && ( ECHO ReactOS/Windows & SET VAR_OS=REACTOS)
ver | findstr /i "6\.0\." > nul && ( ECHO Windows Vista/Server2008 & SET VAR_OS=WIN7)
ver | findstr /i "6.1." > nul && ( ECHO win7/Server2008R2 & SET VAR_OS=WIN7 )
rem ver | findstr /i "6.1." > nul && ( SET VAR_OS=REACTOS )
rem ver | findstr /i "6\.1\." > nul && (echo Windows 7 / Server 2008R2 & GOTO :WIN7)
ver | findstr /i "6\.2\." > nul && ( ECHO Windows8/Server2012 & SET VAR_OS=WIN7 )
ver | findstr /i "6\.3\." > nul && ( ECHO Windows8.1/Server2012R2 & SET VAR_OS=WIN7 )
ver | findstr /i "10\.0\." > nul && ( ECHO Windows10/Server2016 & SET VAR_OS=WIN7 )



rem IF /I "%~1"=="help" GOTO HELP
rem /I  case Insensitive string comparison
IF /I "%*"=="help" GOTO HELP
IF /I "%*"=="h" GOTO HELP
IF /I "%*"=="-h" GOTO HELP
IF /I "%*"=="/?" GOTO HELP
IF /I "%*"=="about" GOTO ABOUT
IF /I "%*"=="v" GOTO ABOUT
IF /I "%*"=="-v" GOTO ABOUT
IF /I "%*"=="version" GOTO ABOUT


REM -------------- LANGUAGE STRINGS
IF /I "%*"=="-l es" SET V_LANG=ES
IF /I "%*"=="-l en" SET V_LANG=EN


rem  --------------------------
rem ------         Customize Batch
rem  --------------------------
rem 1st menu to identify paths for common/shared (profile)
rem 2nd menu to identify a specific Webbrowser and its bin path (can use shared profiles)
rem
rem Intructions/sections to fill
rem 1 For new computer or change of folder
rem 1.1 Create a new ERRORLEVEL section for a computer using a different drive or folder
rem 1.2 set BROWSERPATH, PROFILEPATH for a computer using a different drive or folder
rem
rem 2. For a new webBrowser fork or version
rem 2.1 Create a new ERRORLEVEL section for the new webbrowser
rem 2.2 rename executable folder and filename.exe
rem  ----------------------------------------------------
rem  ------         NOTES /Information
rem  ----------------------------------------------------
rem Basilisk default folder: -profile "c:\Users\username\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\5sq5azxp.default
rem
rem if path has not spaces inside do not quote variable %PROFILEPATH% it can fail (WF)
rem 
rem Portable.exe doesn't support profile parameters :  -no-remote -profile
rem
rem note that  ECHO/ for newline is not an official instruction, so remove if it fails.
rem be careful, do not add  slash at the end of paths
rem be careful with hidden tab symbols in path etc
rem 


rem  ----------------------------------------------------
rem                SECTION 0 - Variables and Path Declaration
rem  ----------------------------------------------------

:MAINMENU
rem GO BACK TO PATH were batch menu is 
CD %PATH_MENUBIN%

REM LANGUAGE STRINGS ------------
REM brackets requires double quotes
IF /I %V_LANG%==ES (  
	SET V_STR_HEADER10=PERFIL - SELECCIONAR una UNIDAD
	SET V_STR_HEADER11="[Opcion] [ Navegador     - (Unidad, Carpeta)     ]    [Perfil disponible S/N]"
	SET V_STR_HEADER20=SELECCIONAR un Navegador    version/variante
	SET V_STR_HEADER21=Disponible y compat. con perfil de navegador:
	SET V_STR_HEADER22="[Opcion] [ Navegador      Version      Desc ]   [Bin carpeta Si/No]"
	SET V_STR_QUESTION1=Escoge una opcion:
	SET V_STR_YES=Si
	)
IF /I NOT %V_LANG%==ES (    
	SET V_STR_HEADER10=PROFILE - SELECT a PATH/DRIVE
	SET V_STR_HEADER11="[Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]"
	SET V_STR_HEADER20=SELECT a WebBrowser version/fork
	SET V_STR_HEADER21=Available and compat. with profile of browser:
	SET V_STR_HEADER22="[Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]"
	SET V_STR_QUESTION1=Choose an option:
	SET V_STR_YES=Y
)


REM delete v1.99 SET V_FAMILY=%V_VERBOSELIST%


REM ALL will list all browsers in Menu
REM NO or something else, will list only these browsers compatible with a specific family  
REM  NAMEx=FF52/Basilisk (C:  \Program Files + \Roaming\Moonchild Prod.)	.
REM PROFILEx=C:\Users\danielp\AppData\Roaming\Moonchild Productions\Basilisk\Profiles\7jgwm62d.default


CLS
SET NAME1=Chrome/Chromium (C: folder: Portables\ChromeBrowsers)		.
SET PATH1=%PATH_ROOT_CONTENT%\ChromeBrowsers
SET PROFILE1=%PATH_ROOT_CONTENT%\ChromeBrowsers\Profiles
REM C:\Users\dperezgo\AppData\Local\Chromium\User Data
IF EXIST "%PROFILE1%" (SET Profile1Exist=[%V_STR_YES%])  ELSE (SET Profile1Exist=[ ])

SET NAME2=FF52/Basilisk (C: folder: Portables\BasiliskBrowsers)		.
REM =PC2 - Drive D: (folder: Portables\BasiliskBrowsers)
SET PATH2=%PATH_ROOT_CONTENT%\BasiliskBrowsers
REM D:\20 Portables\BasiliskBrowsers 
SET PROFILE2=%PATH_ROOT_CONTENT%\BasiliskBrowsers\Profiles\5sq5azxp.default
REM D:\20 Portables\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE2% (SET Profile2Exist=[%V_STR_YES%]) ELSE (SET Profile2Exist=[ ])


SET NAME3=FF28/Palemoon (C: folder: Portables\PalemoonBrowsers)		.
SET PATH3=%PATH_ROOT_CONTENT%\PalemoonBrowsers
SET PROFILE3=%PATH_ROOT_CONTENT%\PalemoonBrowsers\Profiles\Default
IF EXIST %PROFILE3% (SET Profile3Exist=[%V_STR_YES%]) ELSE (SET Profile3Exist=[ ])

SET NAME4=FF52/Basilisk + Waterfox(56) bin +  (C: Caution and backup profile)	.
SET PATH4=%PATH_ROOT_CONTENT%\Waterfox_browsers
REM \WaterfoxPortable56.2.7\App\Waterfox
SET PROFILE4=%PATH_ROOT_CONTENT%\BasiliskBrowsers\Profiles\5sq5azxp.default
IF EXIST %PROFILE4% (SET Profile4Exist=[%V_STR_YES%]) ELSE (SET Profile4Exist=[ ])

SET NAME5=FF56/Waterfox Classic(C: folder: Portables\Waterfox_browsers)	.
SET PATH5=%PATH_ROOT_CONTENT%\Waterfox_browsers
SET PROFILE5=%PATH_ROOT_CONTENT%\Waterfox_browsers\Profile
IF EXIST %PROFILE5% (SET Profile5Exist=[%V_STR_YES%]) ELSE (SET Profile5Exist=[ ])
REM DEFAULT profile path
REM SET PROFILE5=%PATH_ROOT_CONTENT%\Waterfox_browsers\WaterfoxPortable56.2.7\Data\profile

SET NAME6=FF57/FirefoxQuantum (C: folder: Portables\QuantumBrowsers)		.
SET PATH6=%PATH_ROOT_CONTENT%\QuantumBrowsers
rem developer SET PROFILE6=%PATH_ROOT_CONTENT%\QuantumBrowsers\Profiles\1a9stydz.dev-default
SET PROFILE6=%PATH_ROOT_CONTENT%\QuantumBrowsers\Profiles\QuantumDefault
IF EXIST %PROFILE6% (SET Profile6Exist=[%V_STR_YES%]) ELSE (SET Profile6Exist=[ ])

SET NAME7=USB PenDrive - Drive G: (folder: Portables\PalemoonBrowsers)		.
SET PATH7=G:\Portables\PalemoonBrowsers 
SET PROFILE7=G:\Portables\PalemoonBrowsers\Profiles\palemoon.default
IF EXIST %PROFILE7% (SET Profile7Exist=[%V_STR_YES%]) ELSE (SET Profile7Exist=[ ])

SET NAME8=USB PenDrive - Drive G: (folder: Portables\Waterfox)			.
SET PATH8=G:\Portables\Waterfox_browsers
SET PROFILE8=G:\Portables\Waterfox_browsers\Profile
IF EXIST %PROFILE8% (SET Profile8Exist=[%V_STR_YES%]) ELSE (SET Profile8Exist=[ ])


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

ECHO _____	  v %VERSION%	 (by DaPGo) - Lang [%V_LANG%]  - FullList: [%V_VERBOSELIST%] 	_____
ECHO _____  	https://github.com/dapgo/Menu_Launcher4multiple_FF  [GPL]	_____


 rem ECHO/ white line remove if it fails


 
ECHO OFF
IF "%V_MODEDEBUG%" == "Y"  ( 
   ECHO var: %VAR_OS%  var Menu path:%PATH_MENUBIN%
   CD
   ver
 )

:SECTION1
rem  ----------------------------------------------------
rem                SECTION1 - Root folder and PROFILE folder
rem  ----------------------------------------------------
rem ECHO ********************************************************************
ECHO _____   		Menu1: %V_STR_HEADER10%   		_____
ECHO _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
ECHO/
ECHO %V_STR_HEADER11%
rem to delete  ECHO [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
ECHO/
REM ECHO "______  ___________________________________     __________________"
ECHO 1) %NAME1%  %Profile1Exist%
ECHO 2) %NAME2%  %Profile2Exist%
ECHO 3) %NAME3%  %Profile3Exist%
ECHO 4) %NAME4%  %Profile4Exist%
ECHO 5) %NAME5%  %Profile5Exist%
ECHO 6) %NAME6%  %Profile6Exist%
ECHO 7) %NAME7%  %Profile7Exist%
ECHO 8) %NAME8%  %Profile8Exist%
ECHO 9) %NAME9%  [?]
ECHO L/l) Language/Lenguaje EN/ES
ECHO H/h) HELP (Includes info and predefined paths)
ECHO X/x) Change List Mode: Full-All/Family
ECHO Q/q) Quit/Exit
REM ###### CHOICE OS VARIANTS MENU1 ######
IF %VAR_OS% == WIN7 ( 	
	CHOICE.EXE /C 123456789LHXQ /M "%V_STR_QUESTION1%"
	)
IF %VAR_OS% == REACTOS ( 	
	CHOICE.EXE /C:123456789LHXQ "Choose an option:"
)
IF %VAR_OS% == WINXP_W2003 ( 	
    REM verify that 
	CHOICE.COM /C:123456789LHXQ "Choose an option:"
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
IF %ERRORLEVEL% == 10 GOTO ChangeLanguage
IF %ERRORLEVEL% == 11 ( CLS & GOTO HELP )
IF %ERRORLEVEL% == 12 GOTO ChangeListMode_M1
IF %ERRORLEVEL% == 13 GOTO FIN
GOTO SECTION1

:Path1 
 SET BROWSERPATH=%PATH1%
 SET PROFILEPATH=%PROFILE1%
 SET V_FAMILY=CH
 GOTO SECTION2
 
:Path2	  
 SET BROWSERPATH=%PATH2%
 SET PROFILEPATH=%PROFILE2%
 SET V_FAMILY=FF52
 GOTO SECTION2
 
:Path3	 
 SET BROWSERPATH=%PATH3%
 SET PROFILEPATH=%PROFILE3%
 SET V_FAMILY=FF27
 GOTO SECTION2
:Path4	 
 SET BROWSERPATH=%PATH4%
 SET PROFILEPATH=%PROFILE4%
 SET V_FAMILY=FF56
 GOTO SECTION2
:Path5	
 SET BROWSERPATH=%PATH5%
 SET PROFILEPATH=%PROFILE5%
 SET V_FAMILY=FF56
 GOTO SECTION2 
 
:Path6	
 SET BROWSERPATH=%PATH6%
 SET PROFILEPATH=%PROFILE6%
 SET V_FAMILY=FF57
 GOTO SECTION2  
:Path7	
 SET BROWSERPATH=%PATH7%
 SET PROFILEPATH=%PROFILE7%
 SET V_FAMILY=FF27
 GOTO SECTION2
:Path8	
 SET BROWSERPATH=%PATH8%
 SET PROFILEPATH=%PROFILE8%
 SET V_FAMILY=FF52
 GOTO SECTION2
 
:Path9	 
 SET V_FAMILY=00
 rem 00 local profile
 GOTO SECTION2 
 
:ChangeLanguage
 IF /I %V_LANG%==EN (SET TEMP_LANG=ES) 
 IF /I NOT %V_LANG%==EN (SET TEMP_LANG=EN) 
 SET V_LANG=%TEMP_LANG%
GOTO MAINMENU
 
:ChangeListMode_M1
 IF %V_VERBOSELIST% == ALL (SET TEMP_MODE=NO)
 IF NOT %V_VERBOSELIST% == ALL (SET TEMP_MODE=ALL)
 SET V_VERBOSELIST=%TEMP_MODE%
GOTO MAINMENU



rem  ----------------------------------------------------
rem                SECTION2 - Executable folder and filename 
rem  ----------------------------------------------------

:ChangeListMode_M2
 IF %V_VERBOSELIST% == ALL (SET TEMP_MODE=NO)
 IF NOT %V_VERBOSELIST% == ALL (SET TEMP_MODE=ALL)
 SET V_VERBOSELIST=%TEMP_MODE%
GOTO SECTION2

  
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
ECHO ******  Menu2:   %V_STR_HEADER20%                  ******
rem 
ECHO ******  [%V_STR_YES%] = %V_STR_HEADER21% [%V_FAMILY%]   ******
ECHO *************************************************************************
ECHO/
ECHO %V_STR_HEADER22%
rem to delete ECHO [Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]
ECHO/

REM number requires double quotes, text doesn't 

IF "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.1_GROUP1
REM V2.00B
IF "%V_FAMILY%"=="FF52" GOTO SECTION2.1_GROUP1
IF "%V_FAMILY%"=="FF56" GOTO SECTION2.1_GROUP2
IF "%V_FAMILY%"=="FF27" GOTO SECTION2.1_GROUP3
IF "%V_FAMILY%"=="FF57" GOTO SECTION2.1_GROUP4
IF "%V_FAMILY%"=="00" GOTO SECTION2.1_GROUP5
IF "%V_FAMILY%"=="CH" GOTO SECTION2.1_GROUP6
IF %V_FAMILY%==CH GOTO SECTION2.1_GROUP6
                       
REM V1.99 IF %V_FAMILY%==ALL GOTO SECTION2.1_GROUP1

rem optional lines -TO Remove
ECHO %V_FAMILY%   --Menu2 1st IF  Family no recognized
PAUSE
rem optional lines -TO Remove
GOTO MAINMENU


rem  ----------------------------------------------------
rem        SUBSECTION2.1 - SET VAR Executable folder and filename 
rem  ----------------------------------------------------

REM ### BEGIN FF52 #####    
:SECTION2.1_GROUP1
	SET NAME1=Basilisk202001(64b)					.
	SET PATH1BIN=\basilisk_202001_64b\
	IF EXIST "%BROWSERPATH%%PATH1BIN%" (SET Bin1Exist=[%V_STR_YES%])  ELSE (SET Bin1Exist=[ ])

	SET NAME2=Basilisk2018(64b) (Mozilla SYNC)			.
	SET PATH2BIN=\basilisk_2018_SYNC\
	IF EXIST "%BROWSERPATH%%PATH2BIN%" (SET Bin2Exist=[%V_STR_YES%])  ELSE (SET Bin2Exist=[ ])

	SET NAME3=Serpent(32b/XP) 201912				.
	SET PATH3BIN=\Serpent_201912_32b_wXP\
	IF EXIST "%BROWSERPATH%%PATH3BIN%" (SET Bin3Exist=[%V_STR_YES%])  ELSE (SET Bin3Exist=[ ])

	SET NAME4=Centaury(32b/XP) 0.0.6/201909 (Basilisk fork)	.
	SET PATH4BIN=\Centaury_201909_006_wXP\
	IF EXIST "%BROWSERPATH%%PATH4BIN%" (SET Bin4Exist=[%V_STR_YES%])  ELSE (SET Bin4Exist=[ ])

	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2
REM ### END FF52  #####    

REM BEGIN FF56 #####
:SECTION2.1_GROUP2
	SET NAME5=WaterfoxPortable56.2.7 (64b)				.	
	SET PATH5BIN=\WaterfoxPortable56.2.7\App\Waterfox\
	IF EXIST "%BROWSERPATH%%PATH5BIN%" (SET Bin5Exist=[%V_STR_YES%])  ELSE (SET Bin5Exist=[ ])

	SET NAME6=WaterfoxClassic 202001 (64b)				.
	REM SET PATH6BIN=\WaterfoxClassicPort201912\
	SET PATH6BIN=\WaterfoxClassicPort202001\
	IF EXIST "%BROWSERPATH%%PATH6BIN%" (SET Bin6Exist=[%V_STR_YES%])  ELSE (SET Bin6Exist=[ ])

	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2
REM END FF52  #####    

REM BEGIN FF27/28 #####
:SECTION2.1_GROUP3
	SET NAME7=Palemoon28.8.0 (32b)					.
	SET PATH7BIN=\PM28_8_0_32b\Bin\Palemoon\
	IF EXIST "%BROWSERPATH%%PATH7BIN%" (SET Bin7Exist=[%V_STR_YES%])  ELSE (SET Bin7Exist=[ ])

	SET NAME8=MyPal28.7.2 (32b/XP)					.
	SET PATH8BIN=\Mypal28_7_32_wXP\
	IF EXIST "%BROWSERPATH%%PATH8BIN%" (SET Bin8Exist=[%V_STR_YES%])  ELSE (SET Bin8Exist=[ ])

	rem SET NAME9=NewMoon28 201908(32b/XP)				.
	rem SET PATH9BIN=\NewMoon287_201908_wXP\
	SET NAME9=NewMoon28.9 (32b/XP)					.
	SET PATH9BIN=\NewMoon28_9_201912_32_wXP\
	IF EXIST "%BROWSERPATH%%PATH9BIN%" (SET Bin9Exist=[%V_STR_YES%])  ELSE (SET Bin9Exist=[ ])

	REM END FF27/28 #####
	SET NAMEA=MyPal27.9.4 (32b/XP/ReactOS)				.
	SET PATHABIN=\Mypal27_94_wXP\
	IF EXIST "%BROWSERPATH%%PATHABIN%" (SET BinAExist=[%V_STR_YES%])  ELSE (SET BinAExist=[ ])
	
	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2

REM BEGIN FF57 #####
:SECTION2.1_GROUP4

rem	SET NAMEB=Firefox Quantum v69.0 (64b) 				.
rem	SET PATHBBIN=\FirefoxPortableQuantum\App\Firefox64\
rem IF EXIST "%BROWSERPATH%%PATHBBIN%" (SET BinBExist=[%V_STR_YES%])  ELSE (SET BinBExist=[ ])

	SET NAMEB=Waterfox 56.2.14 (64b)				.
	SET PATHBBIN=\WaterfoxPortable56.2.14\App\Waterfox\
	IF EXIST "%BROWSERPATH%%PATHBBIN%" (SET BinBExist=[%V_STR_YES%])  ELSE (SET BinBExist=[ ])

	SET NAMEC=Firefox Quantum v70 (32b) 				.
	SET PATHCBIN=\FirefoxPortableQuantum\App\Firefox\
	IF EXIST "%BROWSERPATH%%PATHCBIN%" (SET BinCExist=[%V_STR_YES%])  ELSE (SET BinCExist=[ ])
	
	SET NAMED=Firefox Dev Edition 71 (64b) 			.
	SET PATHDBIN=\FirefoxDev_70_x64\
	IF EXIST "%BROWSERPATH%%PATHDBIN%" (SET BinDExist=[%V_STR_YES%])  ELSE (SET BinDExist=[ ])

	SET NAMEE=WaterfoxCurrent 68/202001 (64b) 			.
	SET PATHEBIN=\WaterfoxCurrent202001\
	IF EXIST "%BROWSERPATH%%PATHEBIN%" (SET BinEExist=[%V_STR_YES%])  ELSE (SET BinEExist=[ ])
	
	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2
REM END FF57 #####

REM BEGIN Portables #####
:SECTION2.1_GROUP5
rem Note that portables are using a different path var and not profile related
	SET NAMEF=Firefox Portable 3.6 (32b)				.
	SET PATHFBIN=%PATH_ROOT_CONTENT%\Firefox\FirefoxPortableLegacy36\
	IF EXIST "%PATHFBIN%" (SET BinFExist=[%V_STR_YES%])  ELSE (SET BinFExist=[ ])
	
	SET NAMEG=Firefox Portable 12 (32b)				.
	SET PATHGBIN=%PATH_ROOT_CONTENT%\Firefox\FirefoxPortable12\
	IF EXIST "%PATHGBIN%" (SET BinGExist=[%V_STR_YES%])  ELSE (SET BinGExist=[ ])
	
	
	SET NAMEI=K-meleon 76 Goanna 3.4(32b/XP)			.
	SET PATHIBIN=%PATH_ROOT_CONTENT%\PalemoonBrowsers\KM76.2_20191116\
	IF EXIST "%PATHIBIN%" (SET BinIExist=[%V_STR_YES%])  ELSE (SET BinIExist=[ ])
	
	SET NAMEJ=Firefox Portable Quantum (64b)			.
	SET PATHJBIN=%PATH_ROOT_CONTENT%\QuantumBrowsers\FirefoxPortableQuantum\	
	IF EXIST "%PATHJBIN%" (SET BinJExist=[%V_STR_YES%])  ELSE (SET BinJExist=[ ])
	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2
REM END Portables #####

REM Chromium
:SECTION2.1_GROUP6		
	SET NAMEM=Chromium 45.0.2416.0 (32b)				.
	SET PATHMBIN=\Chromium45.0.2416.0-w32\
	IF EXIST "%BROWSERPATH%%PATHMBIN%" (SET BinMExist=[%V_STR_YES%])  ELSE (SET BinMExist=[ ])
	
	SET NAMEN=Chromium 77.0.38 (32b) (ungoogled)(by Marmaduke)	.
	SET PATHNBIN=\Chromium-77.0.3865.75-w32\
	IF EXIST "%BROWSERPATH%%PATHNBIN%" (SET BinNExist=[%V_STR_YES%])  ELSE (SET BinNExist=[ ])
	
	SET NAMEO=Brave 0.68.142 (Ch:77.0.3865) (32b) 			.
	rem C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\
	SET PATHOBIN=\BraveSoftware\Brave-Browser\Application\
	IF EXIST "%BROWSERPATH%%PATHOBIN%" (SET BinOExist=[%V_STR_YES%])  ELSE (SET BinOExist=[ ])
	
	SET NAMEP=Opera 30 (NPAPI) (Ch:43.0) (32b/XP) 			.
	SET PATHPBIN=\Opera30port_NPAPI\30.0.1835.88\
	IF EXIST "%BROWSERPATH%%PATHPBIN%" (SET BinPExist=[%V_STR_YES%])  ELSE (SET BinPExist=[ ])
	
	REM SET NAMER=UCBrowser 7.0.185 (Ch:55.0)(32b/XP) 			.
	SET NAMER=360 Extreme Explorer 11.0.2216 (Ch:69.0)(32b/XP) 	.
	REM SET PATHRBIN=%PATH_ROOT_CONTENT%\ChromeBrowsers\UCBrowser\Application\
	SET PATHRBIN=\360extremeb_w32\
	IF EXIST "%BROWSERPATH%%PATHRBIN%" (SET BinRExist=[%V_STR_YES%])  ELSE (SET BinRExist=[ ])
	
	SET NAMES=Google Chrome 48.0 (./Program Files/..)(32b) 	.
	SET PATHSBIN=C:\Program Files (x86)\Google\Chrome\Application\
	IF EXIST "%PATHSBIN%" (SET BinSExist=[%V_STR_YES%])  ELSE (SET BinSExist=[ ])
	
	SET NAMET=Microsoft Edge 78.0.276 (own profile) (64b/win7) 	.
	SET PATHTBIN=\EdgeBeta78_w7_64b\Application\
	rem default C:\Program Files (x86)\Microsoft\Edge Beta\Application\78.0.276.17
	REM exe (launcher??) is also in C:\Program Files (x86)\Microsoft\Edge Beta\Application
	IF EXIST "%BROWSERPATH%%PATHTBIN%" (SET BinTExist=[%V_STR_YES%])  ELSE (SET BinTExist=[ ])
	
	SET NAMEU=Microsoft Edge 79 (own profile) (64b/win7) 		.
	SET PATHUBIN=\EdgeBeta79_w7_64b\
	IF EXIST "%BROWSERPATH%%PATHUBIN%" (SET BinUExist=[%V_STR_YES%])  ELSE (SET BinUExist=[ ])
	
	SET NAMEV=Vivaldi 2.10.1745 (Ch:79.0.39) (64b) 		.
	SET PATHVBIN=\Vivaldi2.10.1745_x64\
	IF EXIST "%BROWSERPATH%%PATHVBIN%" (SET BinVExist=[%V_STR_YES%])  ELSE (SET BinVExist=[ ])
	
	IF NOT "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2
REM end Chromium		

rem  ----------------------------------------------------
rem        SUBSECTION2.2 - PRINT VARs Executable folders and filename 
rem  ----------------------------------------------------
:SECTION2.2
IF "%V_VERBOSELIST%"=="ALL" GOTO SECTION2.2_GROUP1
IF "%V_FAMILY%"=="FF52" GOTO SECTION2.2_GROUP1
IF "%V_FAMILY%"=="FF56" GOTO SECTION2.2_GROUP2
IF "%V_FAMILY%"=="FF27" GOTO SECTION2.2_GROUP3
IF "%V_FAMILY%"=="FF57" GOTO SECTION2.2_GROUP4
IF "%V_FAMILY%"=="00" GOTO SECTION2.2_GROUP5
IF "%V_FAMILY%"=="CH" GOTO SECTION2.2_GROUP6

REM Otherwise (and value ALL) display entries
REM V1.99 IF %V_FAMILY%==ALL GOTO SECTION2.2_GROUP1

rem optional lines -TO Remove
ECHO %V_FAMILY%   --Menu2 2nd IF - Family no recognized
PAUSE
rem optional lines -TO Remove
GOTO MAINMENU


:SECTION2.2_GROUP1
ECHO 1) %NAME1%  %Bin1Exist%
ECHO 2) %NAME2%  %Bin2Exist%
ECHO 3) %NAME3%  %Bin3Exist%
ECHO 4) %NAME4%  %Bin4Exist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE

:SECTION2.2_GROUP2
ECHO 5) %NAME5%  %Bin5Exist%
ECHO 6) %NAME6%  %Bin6Exist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP3
ECHO 7) %NAME7%  %Bin7Exist%
ECHO 8) %NAME8%  %Bin8Exist%
ECHO 9) %NAME9%  %Bin9Exist%
ECHO A) %NAMEA%  %BinAExist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP4
ECHO B) %NAMEB%  %BinBExist%
ECHO C) %NAMEC%  %BinCExist%
ECHO D) %NAMED%  %BinDExist%
ECHO E) %NAMEE%  %BinEExist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE
:SECTION2.2_GROUP5
ECHO F) %NAMEF%  %BinFExist%
ECHO G) %NAMEG%  %BinGExist%
ECHO I) %NAMEI%  %BinIExist%
ECHO J) %NAMEJ%  %BinJExist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE

:SECTION2.2_GROUP6
ECHO M) %NAMEM%  %BinMExist%
ECHO N) %NAMEN%  %BinNExist%
ECHO O) %NAMEO%  %BinOExist%
ECHO P) %NAMEP%  %BinPExist%
ECHO R) %NAMER%  %BinRExist%
ECHO S) %NAMES%  %BinSExist%
ECHO T) %NAMET%  %BinTExist%
ECHO U) %NAMEU%  %BinUExist%
ECHO V) %NAMEV%  %BinVExist%
IF NOT "%V_VERBOSELIST%"=="ALL" GOTO MENU2_CHOICE

:MENU2_CHOICE
 ECHO H/h) HELP/INFO
 ECHO X/x) Change List Mode: Full-All/Family
 ECHO Q/q) Quit/Exit
 ECHO/

REM ###### CHOICE OS VARIANTS MENU2 ######
IF %VAR_OS% == WIN7 ( 
	CHOICE.EXE /C 123456789ABCDEFGIJMNOPRSTUVHXQ /M "%V_STR_QUESTION1%"
	)
IF %VAR_OS% == REACTOS ( 	
	CHOICE.EXE /C:123456789ABCDEFGIJMNOPRSTUVHXQ  "Choose an option:"	
)
IF %VAR_OS% == WINXP_W2003 ( 	
	CHOICE.COM /C:123456789ABCDEFGIJMNOPRSTUVHXQ  "Choose an option:"	
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
IF %ERRORLEVEL% == 16 GOTO label_G
IF %ERRORLEVEL% == 17 GOTO label_I
IF %ERRORLEVEL% == 18 GOTO label_J
IF %ERRORLEVEL% == 19 GOTO label_M
IF %ERRORLEVEL% == 20 GOTO label_N
IF %ERRORLEVEL% == 21 GOTO label_O
IF %ERRORLEVEL% == 22 GOTO label_P
IF %ERRORLEVEL% == 23 GOTO label_R
IF %ERRORLEVEL% == 24 GOTO label_S
IF %ERRORLEVEL% == 25 GOTO label_T
IF %ERRORLEVEL% == 26 GOTO label_U
IF %ERRORLEVEL% == 27 GOTO label_V
IF %ERRORLEVEL% == 28 ( CLS & GOTO HELP )
IF %ERRORLEVEL% == 29 GOTO ChangeListMode_M2
IF %ERRORLEVEL% == 30 GOTO FIN
GOTO FIN

:WAIT_A_MIN
ECHO **********************************************************************
ECHO ********     Selected WebBrowser is being launched        ************
ECHO ********           Please Wait a Minute                  *************
ECHO ***************************************************** ****************
PAUSE
GOTO MAINMENU

REM *************** SECTION FF52_BASILISK *************** 
REM ***************************************************** 


:label_1
 rem basilisk
 REM basilisk_201909
 CD /D "%BROWSERPATH%%PATH1BIN%"
 CD
 CALL basilisk.exe -v |more
 START basilisk.exe -no-remote -profile "%PROFILEPATH%" 
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
 REM WF56 on quantum
 CD /D "%BROWSERPATH%%PATHBBIN%"
 CD
 CALL Waterfox.exe -v |more
 START Waterfox.exe -no-remote -profile "%PROFILEPATH%" 
 
 GOTO WAIT_A_MIN

:label_C
 REM Quantum32b
 CD /D "%BROWSERPATH%%PATHCBIN%"
 CD
 CALL firefox.exe -v |more
 START firefox.exe --allow-downgrade -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN 

:label_D
 REM QuantumDev_Edition
 CD /D "%BROWSERPATH%%PATHDBIN%"
 CD
 CALL firefox.exe -v |more
 START firefox.exe --allow-downgrade -no-remote -profile "%PROFILEPATH%"
 GOTO WAIT_A_MIN 
 
 :label_E
 rem WFCurrent(68)
 CD /D "%BROWSERPATH%%PATHEBIN%"
 CALL Waterfox.exe -v |more
 START Waterfox.exe --allow-downgrade -no-remote -profile "%PROFILEPATH%" 
 GOTO WAIT_A_MIN
 
REM *************** SECTION portables (own local profile) *************** 
REM ***************************************************** 
 

:label_F
 rem Firefox3
 CD /D "%PATHFBIN%"
 CALL FirefoxPortable36.exe -v |more
 START FirefoxPortable36.exe
 GOTO WAIT_A_MIN
 
:label_G
 rem Firefox12
 CD /D "%PATHEBIN%"
 CALL FirefoxPortable12.exe -v |more
 START FirefoxPortable12.exe
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
rem Default name through profiles.ini is associated to .\Profiles\la68p435.default\

:label_J
 rem Quantumportable
 CD /D "%PATHJBIN%"
 CALL FirefoxPortable.exe -v |more
 START FirefoxPortable.exe
 GOTO WAIT_A_MIN

REM *************** SECTION Chromium *************** 
REM ***************************************************** 
 
:label_M 
 CD /D %BROWSERPATH%%PATHMBIN%"
 ECHO Chromium 
 START chrome --user-data-dir="%PROFILEPATH%" --disable-machine-id --disable-encryption --disable-update
 REM --user-data-dir="C:\Users\dperezgo\AppData\Local\Chromium\User Data"
 GOTO WAIT_A_MIN
 
 :label_N 
 CD /D %BROWSERPATH%%PATHNBIN%"
 ECHO Chromium 
 START chrome --user-data-dir="%PROFILEPATH%" --disable-machine-id --disable-encryption --disable-update
 REM --user-data-dir="C:\Users\dperezgo\AppData\Local\Chromium\User Data"
 GOTO WAIT_A_MIN
 
 
 :label_O 
 CD /D %BROWSERPATH%%PATHOBIN%"
 ECHO Brave 
 START brave --user-data-dir="%PROFILEPATH%" --disable-machine-id --disable-encryption --disable-update 
 GOTO WAIT_A_MIN
 REM C:\Program Files (x86)\BraveSoftware\Brave-Browser\Application\brave.exe
 
 :label_P 
 CD /D %BROWSERPATH%%PATHPBIN%"
 ECHO opera
 REM Opera requires to specify the name of profile!!! 
 START opera.exe --user-data-dir="%PROFILEPATH%\Default" --disable-update --disable-machine-id --disable-encryption
 GOTO WAIT_A_MIN
 
 :label_R 
 CD /D %BROWSERPATH%%PATHRBIN%" 
START 360chrome.exe --user-data-dir="%PROFILEPATH%" --disable-update --disable-machine-id --disable-encryption  
REM START UCBrowser.exe --user-data-dir="%PROFILEPATH%" --disable-update --disable-machine-id --disable-encryption  
 GOTO WAIT_A_MIN

 :label_S
 rem note that is installed at C:\Program Files
 CD /D %PATHSBIN%" 
START chrome.exe --user-data-dir="%PROFILEPATH%" --disable-update --disable-machine-id --disable-encryption  
REM START UCBrowser.exe --user-data-dir="%PROFILEPATH%" --disable-update --disable-machine-id --disable-encryption  
 GOTO WAIT_A_MIN
 
 :label_T
 CD /D %BROWSERPATH%%PATHTBIN%" 
REM Edge add a Default after the path
REM not compatible with other chrome profiles
START msedge.exe --user-data-dir="%BROWSERPATH%\Profiles_edge"

REM old hardcoded "C:\Daniel\00_PortableBrowsers\ChromeBrowsers\Profiles_edge" --disable-update --disable-machine-id --disable-encryption 

rem --user-data-dir="C:\Daniel\Portables\ChromeBrowsers\Profiles_edge" --disable-update --disable-machine-id --disable-encryption  

REM hardocoded testing
rem msedge.exe --user-data-dir=C:\Daniel\Portables\ChromeBrowsers\Profiles_edge
rem extensions in C:\Daniel\Portables\ChromeBrowsers\Profiles_edge\Default\Extensions
REM  msedge.exe --user-data-dir="C:\Daniel\Portables\ChromeBrowsers\Profiles"
REM START UCBrowser.exe --user-data-dir="%PROFILEPATH%" --disable-update --disable-machine-id --disable-encryption  
 GOTO WAIT_A_MIN
 
  :label_U
 CD /D %BROWSERPATH%%PATHUBIN%" 
REM Edge add a Default after the path
REM not compatible with other chrome profiles
START msedge.exe --user-data-dir="%BROWSERPATH%\Profiles_edge"

 GOTO WAIT_A_MIN
 
  :label_V
 CD /D %BROWSERPATH%%PATHVBIN%" 
REM Edge add a Default after the path
REM not compatible with other chrome profiles
START Vivaldi.exe --user-data-dir="%PROFILEPATH%" --disable-machine-id --disable-encryption --disable-update

 GOTO WAIT_A_MIN 
 
REM **************************** EXIT OF SCRIPT ******************
 
:FIN				
ECHO You can close this window				
EXIT

REM **************************** EXIT OF SCRIPT ******************




:HELP		
    	
	ECHO "      __  __ ______ __     ____              ____ _   __ ______ ____     "
	ECHO "     / / / // ____// /    / __ \            /  _// | / // ____// __ \    "
	ECHO "    / /_/ // __/  / /    / /_/ /  ______    / / /  |/ // /_   / / / /    "
	ECHO "   / __  // /___ / /___ / ____/  /_____/  _/ / / /|  // __/  / /_/ /     "
	ECHO "  /_/ /_//_____//_____//_/               /___//_/ |_//_/     \____/      "
	ECHO **********************************************************************
	ECHO ***********    HELP0: for Firefox Legacy browsers       **************
	ECHO ***********         Command Line parameters             **************
	ECHO **********************************************************************
	ECHO/
	ECHO [Parameter/s]   :   Description
	ECHO ______________  :   ___________________________________
	ECHO -h, /?, /h, help 		: Help and Information (this page)
	ECHO -l es 			: Language: Spanish
	ECHO -v, v, version, about 	: Batch version and about  
	ECHO Debug 			: verbose output for testing 
	ECHO All, ListAll	: List all browsers (in 2nd Menu)
	ECHO Family 		: List only browsers associated to profile (in 2nd Menu)
	ECHO/
  PAUSE
	
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
  ECHO Compatible Chrome AddIns. Browsers: From 45 to 69
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
  ECHO #Download Chromium builds: https://chromium.woolyss.com/#browsers
  ECHO #Download Edge: https://www.microsoftedgeinsider.com/en-us/download
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
  ECHO Path7 %PATH7%  
  ECHO Profile7 %PROFILE7%    
  ECHO Path8 %PATH8%  
  ECHO Profile8 %PROFILE8%    
  
  ECHO/ 
 
  PAUSE
  CLS
  GOTO MAINMENU





:ABOUT
  ECHO/
  ECHO **********************************************************************
  ECHO ***********   	About / version:                        **************
  ECHO **********************************************************************
  ECHO/  
  ECHO Version: [ %VERSION% ] Running on: [ %VAR_OS% ]
  ECHO By Daniel Perez Gonzalez - License: GPL
  ECHO # For additional info, source code, latest version, collaborate or submit bugs:	
  ECHO https://github.com/dapgo/Menu_Launcher4multiple_FF  
  ECHO/
  ECHO Default Script settings values:
  ECHO ListAllBrowsers [ %V_VERBOSELIST% ], Mode Debug: [ %V_MODEDEBUG% ]  
  ECHO/
  PAUSE