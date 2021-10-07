@ECHO OFF

SET VERSION=1


rem  ----------------------------------------------------
rem                SECTION Script Vars
rem  ----------------------------------------------------

:BEGINNING
REM Store the path were Menu.batch is located
SET V_STR_QUESTION1=Choose an option:


rem findstr using regexp not supported in Reactos
ver | findstr /i "5\.0\." >nul && ( SET VAR_OS_DESC=Windows2000 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "5\.1\." >nul && ( SET VAR_OS_DESC=WindowsXP32bit & SET VAR_OS=WINXP_W2003) 
ver | findstr /i "5\.2\." >nul && ( SET VAR_OS_DESC=WindowsXP64b/WinServer2003 & SET VAR_OS=WINXP_W2003)
ver | findstr /i "ReactOS" >nul && ( SET VAR_OS_DESC=ReactOS/Windows & SET VAR_OS=REACTOS)
ver | findstr /i "6\.0\." > nul && ( SET VAR_OS_DESC=Windows Vista/Server2008 & SET VAR_OS=WIN7)
ver | findstr /i "6.1." > nul && ( SET VAR_OS_DESC=win7/Server2008R2 & SET VAR_OS=WIN7 )
rem ver | findstr /i "6.1." > nul && ( SET VAR_OS=REACTOS )
rem ver | findstr /i "6\.1\." > nul && (echo Windows 7 / Server 2008R2 & GOTO :WIN7)
ver | findstr /i "6\.2\." > nul && ( SET VAR_OS_DESC=Windows8/Server2012 & SET VAR_OS=WIN7 )
ver | findstr /i "6\.3\." > nul && ( SET VAR_OS_DESC=Windows8.1/Server2012R2 & SET VAR_OS=WIN7 )
ver | findstr /i "10\.0\." > nul && ( SET VAR_OS_DESC=Windows10/Server2016 & SET VAR_OS=WIN7 )

rem ECHO %VAR_OS%
rem ECHO %VAR_OS_DESC%


rem  ----------------------------------------------------
rem                SECTION Browser Vars and input parameters
rem  ----------------------------------------------------


SET NAME1=WaterfoxClassic202109 (my custom path profile)
REM set the folder where the browser is located
SET PATH1="C:\Daniel\PortableWF\WaterfoxClassic202109"
REM setting you new folder will create a new empty profile 
REM copypaste the default wf folder to you prefered folder 
REM default WF profile C:\Users\..\AppData\Roaming\Waterfox\Profiles\6guxxhjg.default
SET PROFILE1=-profile "C:\Daniel\PortableWF\myprofile"
SET BIN1=waterfox.exe
SET PARAMS1=-no-remote

SET NAME2=WaterfoxClassic202109 (wf default path profile C:\Users\...)
SET PATH2="C:\Daniel\PortableWF\WaterfoxClassic202109"
SET PROFILE2=
SET BIN2=waterfox.exe
SET PARAMS2=

SET NAME3=WaterfoxClassic202109 help cli parameters
SET PATH3="C:\Daniel\PortableWF\WaterfoxClassic202109"
SET PROFILE3=
SET BIN3=waterfox.exe
SET PARAMS3=-h ^|more
rem firefox output requires |more and batch requires escaping the pipe


rem  ----------------------------------------------------
rem                SECTION MENU 
rem  ----------------------------------------------------

:MENU1
@ECHO OFF
ECHO _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
ECHO _____  	MENU with PreDefined PATHS and Parameters	v %VERSION%		_____

echo _____  	https://github.com/dapgo/Menu_Launcher4multiple_FF  [GPL]	_____
ECHO _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____



ECHO/
ECHO 1) %NAME1%  %PARAMS1%
ECHO 2) %NAME2%  %PARAMS2%
ECHO 3) %NAME3%  "%PARAMS3%"
 
 ECHO Q/q) Quit/Exit
 ECHO %V_STR_QUESTION1% 
REM ###### CHOICE OS VARIANTS MENU2 ######
IF %VAR_OS% == WIN7 ( 
	CHOICE.EXE /C 123Q
	)
IF %VAR_OS% == REACTOS ( 	   
	CHOICE /C:123Q
)
IF %VAR_OS% == WINXP_W2003 ( 	
	CHOICE.COM /C:123Q
)
ECHO/ 
IF %ERRORLEVEL% == 1 GOTO Path1
IF %ERRORLEVEL% == 2 GOTO Path2
IF %ERRORLEVEL% == 3 GOTO Path3
IF %ERRORLEVEL% == 4 GOTO QUIT
GOTO MENU1

rem  ----------------------------------------------------
rem                SECTION Launching browser
rem  ----------------------------------------------------

:Path1  
 CD /D "%PATH1%" 
 CALL %BIN2% -v |more
 START %BIN1% %PROFILE1% %PARAMS1%
 GOTO MENU1	
 
:Path2  
 CD /D "%PATH2%"  
 CALL %BIN2% -v |more
 START %BIN2%  %PROFILE2% %PARAMS2%
 GOTO MENU1		
 
:Path3  
 CD /D "%PATH3%" 
  CALL %BIN3% -v |more 
 START %BIN3% %PROFILE3% %PARAMS3%
 @ECHO OFF
GOTO MENU1	

 
 :QUIT
 EXIT