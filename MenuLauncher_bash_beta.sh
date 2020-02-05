#!/bin/bash
# Menu Launcher for multiple Firefox/webbrowsers
# https://github.com/dapgo/Menu_Launcher4multiple_FF
# specific for Unix script: Caps!!!, path slash....

clear
VERSION="b02.10(bash)"
V_MODEDEBUG="N"
# Store the path were Menu.batch is located
PATH_MENUBIN="$(dirname "$0")"
#---ROOT PATH --- current chdir or a hardcoded path 
# PATH_ROOT_CONTENT=/Users/daniel/Documents/MyMacApps/portableMacBrowsers
PATH_ROOT_CONTENT="$(dirname "$0")"

if [ "$V_MODEDEBUG" = "Y" ] 
then 
	printf "uname:"
	uname
	printf "\n OStype: $OSTYPE \n"	
	echo "dirname: $PATH_MENUBIN"
	echo "pwd: `pwd`"
fi

cd $PATH_MENUBIN

PATH_MENUBIN=$PWD
# root folder for browser families


# ---ROOT PATH --- current chdir or a hardcoded path 
#  PATH_ROOT_CONTENT=D:\00_PortableBrowsers
PATH_ROOT_CONTENT=$PWD


V_LANG="EN"
# Values Y or something else

# ALL/Verbose output, Menu2 includes the full list of webbrowsers
 V_VERBOSELIST="N"
# V_VERBOSELIST="ALL"
# Values ALL or something else 




#  ----------------------------------------------------
#                SECTION 0 - Variables and Path Declaration
#  ----------------------------------------------------

# GO BACK TO PATH were batch menu is 
cd $PATH_MENUBIN

# LANGUAGE STRINGS ------------
# brackets requires double quotes
if [ "$V_LANG" = "ES" ]
	then  
	 V_STR_HEADER10="PERFIL - SELECCIONAR una UNIDAD"
	 V_STR_HEADER11="[Opcion] [ Navegador     - (Unidad, Carpeta)     ]    [Perfil disponible S/N]"
	 V_STR_HEADER20="SELECCIONAR un Navegador    version/variante"
	 V_STR_HEADER21="Disponible y compat. con perfil de navegador:"
	 V_STR_HEADER22="[Opcion] [ Navegador      Version      Desc ]   [Bin carpeta Si/No]"
	 V_STR_QUESTION1="Escoge una opcion:"
	 V_STR_YES="Si"
	fi

if [ "$V_LANG" != "ES" ] 
then    
	 V_STR_HEADER10="PROFILE - SELECT a PATH/DRIVE"
	 V_STR_HEADER11="[Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]"
	 V_STR_HEADER20="SELECT a WebBrowser version/fork"
	 V_STR_HEADER21="Available and compat. with profile of browser:"
	 V_STR_HEADER22="[Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]"
	 V_STR_QUESTION1="Choose an option:"
	 V_STR_YES="Y"
fi

 NAME1="Chrome/Chromium ( folder: ./ChromeBrowsers)		."
 PATH1="$PATH_ROOT_CONTENT/ChromeBrowsers"
 PROFILE1="$PATH_ROOT_CONTENT/ChromeBrowsers/Profiles"
 if [ -d "$PROFILE1" ] ; then Profile1Exist="[$V_STR_YES]"
     else Profile1Exist="[ ]"
 fi


 NAME5="FF56/Waterfox Classic( folder: ./Waterfox_browsers)	."
 PATH5="$PATH_ROOT_CONTENT/Waterfox_browsers"
 PROFILE5="$PATH_ROOT_CONTENT/Waterfox_browsers/Profile"
 if [ -d "$PROFILE5" ] ; then 	Profile5Exist="[$V_STR_YES]"
     else Profile5Exist="[ ]"
 fi


 NAME6="FF57/FirefoxQuantum ( folder: ./QuantumBrowsers)	."
 PATH6="$PATH_ROOT_CONTENT/QuantumBrowsers"
 PROFILE6="$PATH_ROOT_CONTENT/QuantumBrowsers/Profiles/QuantumDefault"
if [ -d "$PROFILE6" ] ; then 	Profile6Exist="[$V_STR_YES]"
     else Profile6Exist="[ ]"
 fi



ECHO "  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
ECHO " |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
ECHO "  __  __ _____ _   _ _   _           _____ ___ ____  _____ _____ _____  __ "
ECHO " |  \/  | ____| \ | | | | |         |  ___|_ _|  _ \| ____|  ___/ _ \ \/ / "
ECHO " | |\/| |  _| |  \| | | | |  _____  | |_   | || |_) |  _| | |_ | | | \  /  "
ECHO " | |  | | |___| |\  | |_| | |_____| |  _|  | ||  _ <| |___|  _|| |_| /  \  "
ECHO " |_|  |_|_____|_| \_|\___/          |_|   |___|_| \_|_____|_|   \___/_/\_\ "

printf " \n"
printf " _____	v $VERSION (by DaPGo) - Lang [$V_LANG] - FullList: [$V_VERBOSELIST] ____\n"
printf " _____  https://github.com/dapgo/Menu_Launcher4multiple_FF [GPL]  ____\n"
printf "     	     \n "


if [ "$V_MODEDEBUG" = "Y" ]  
then   ECHO "var: $VAR_OS   path: $PATH_MENUBIN"      
fi

#:SECTION1
#  ----------------------------------------------------
#                SECTION1 - Root folder and PROFILE folder
#  ----------------------------------------------------
# ECHO ********************************************************************
ECHO "_____   	Menu1: $V_STR_HEADER10   		_____"
ECHO "_____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ____"
ECHO ""
ECHO $V_STR_HEADER11
# to delete  ECHO [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
ECHO ""
# ECHO "______  ___________________________________     __________________"

ECHO "1) $NAME1  $Profile1Exist"
ECHO "5) $NAME5  $Profile5Exist"
ECHO "6) $NAME6  $Profile6Exist"
ECHO "L/l) Language/Lenguaje EN/ES"
ECHO "H/h) HELP (Includes info and predefined paths)"
ECHO "X/x) Change List Mode: Full-All/Family2"
ECHO "Q/q) Quit/Exit"
# ###### CHOICE OS VARIANTS MENU1 ######


read -n 1 -p "Choose an option: 1,2,3,.." answer
echo "/n"
# debug mode:  
if [ "$V_MODEDEBUG" = "Y" ]  
	then  set -x     
fi

case $answer in
  1) cd  "$PATH1/Vivaldi_Mac_2.10"
pwd
./Vivaldi.app/Contents/MacOS/Vivaldi --user-data-dir="$PROFILE1" --disable-machine-id --disable-encryption --disable-update
;;
  2) echo "You chose Option 2";;
  3) echo "You chose Option 3";;
  5) cd  "$PATH5/WaterfoxClassic_Mac_202001"
	pwd
	./Waterfox.app/Contents/MacOS/waterfox -v 
    ./Waterfox.app/Contents/MacOS/waterfox --no-remote --profile $PROFILE5 ;; 
  6) cd  "$PATH6/Firefox72Mac"
	pwd
	./Firefox72Mac.app/Contents/MacOS/firefox -v 
    ./Firefox72Mac.app/Contents/MacOS/firefox  --no-remote --profile $PROFILE6 ;; 

  q) echo "Exit"
     exit 1;;  
  *) echo "invalid option";;
esac
// 
