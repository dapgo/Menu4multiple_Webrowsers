#!/bin/bash
# Menu Launcher for multiple Firefox/webbrowsers
# https://github.com/dapgo/Menu_Launcher4multiple_FF
# specific for Unix script: Caps!!!, path slash....
clear
#screen -X title "Menu 4 Multiple Browsers"
echo -n -e "\033]0;Menu 4 Multiple Browsers\007"
Salir()
{
	echo "Quit/Salir"
    exit 1;
}

Inicio()
{
 echo "Inicio"

	VERSION="b02.103(bash)"
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
		echo var answer: $answer
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
		 V_STR_HEADER11="[Opcion] [ Navegador     - (Unidad, Carpeta)   ]  	   [Perfil disponible S/N]"
		 V_STR_HEADER20="SELECCIONAR un Navegador    version/variante"
		 V_STR_HEADER21="Disponible y compat. con perfil de navegador:"
		 V_STR_HEADER22="[Opcion] [ Navegador      Version      Desc ]   [Bin carpeta Si/No]"
		 V_STR_QUESTION1="Escoge una opcion:"
		 V_STR_YES="Si"
		fi

	if [ "$V_LANG" != "ES" ] 
	then    
		 V_STR_HEADER10="PROFILE - SELECT a PATH/DRIVE"
		 V_STR_HEADER11="[Option] [ BrowserName     - (Drive, folder)   ]      [Profile available Y/N]"
		 V_STR_HEADER20="SELECT a WebBrowser version/fork"
		 V_STR_HEADER21="Available and compat. with profile of browser:"
		 V_STR_HEADER22="[Option] [ BrowserName    Version      Desc ]   [Bin folder Y/N]"
		 V_STR_QUESTION1="Choose an option:"
		 V_STR_YES="Y"
	fi

	 NAME1="Chromium/Vivaldi 2.10(ch79) (Mac64b)(folder: ./ChromeBrowsers)     ."
	 PATH1="$PATH_ROOT_CONTENT/ChromeBrowsers"
	 PROFILE1="$PATH_ROOT_CONTENT/ChromeBrowsers/Profiles"
	 if [ -d "$PROFILE1" ] ; then Profile1Exist="[$V_STR_YES]"
	     else Profile1Exist="[ ]"
	 fi

	NAME2="FF52/Basilisk /Serpent 2019 (Mac64b)(folder: ./BasiliskBrowsers)   ."
	PATH2="$PATH_ROOT_CONTENT/BasiliskBrowsers"
	PROFILE2="$PATH_ROOT_CONTENT/BasiliskBrowsers/Profiles/5sq5azxp.default"
	 if [ -d "$PROFILE2" ] ; then Profile2Exist="[$V_STR_YES]"
	     else Profile2Exist="[ ]"
	 fi

	NAME3="FF28/Palemoon /NewMoon 28.8.0 (Mac64b)(folder: ./PalemoonBrowsers) ."
	PATH3="$PATH_ROOT_CONTENT/PalemoonBrowsers"
	PROFILE3="$PATH_ROOT_CONTENT/PalemoonBrowsers/Profiles/Default"
	 if [ -d "$PROFILE3" ] ; then Profile3Exist="[$V_STR_YES]"
	     else Profile3Exist="[ ]"
	 fi

	NAME4="FF28/Palemoon /NewMoon 28.7.0 (Mac64b)(folder: ./PalemoonBrowsers) ."
	PATH4="$PATH_ROOT_CONTENT/PalemoonBrowsers"
	PROFILE4="$PATH_ROOT_CONTENT/PalemoonBrowsers/Profiles/Default"
	 if [ -d "$PROFILE4" ] ; then Profile4Exist="[$V_STR_YES]"
	     else Profile4Exist="[ ]"
	 fi

	 NAME5="FF56/WaterfoxClassic 202001(Mac64b)(folder: ./Waterfox_browsers)   ."
	 PATH5="$PATH_ROOT_CONTENT/Waterfox_browsers"
	 PROFILE5="$PATH_ROOT_CONTENT/Waterfox_browsers/Profile"
	 if [ -d "$PROFILE5" ] ; then 	Profile5Exist="[$V_STR_YES]"
	     else Profile5Exist="[ ]"
	 fi


	 NAME6="FF57/FirefoxQuantum 70 (Mac64b)(folder: ./QuantumBrowsers)         ."
	 PATH6="$PATH_ROOT_CONTENT/QuantumBrowsers"
	 PROFILE6="$PATH_ROOT_CONTENT/QuantumBrowsers/Profiles/QuantumDefault"
	if [ -d "$PROFILE6" ] ; then 	Profile6Exist="[$V_STR_YES]"
	     else Profile6Exist="[ ]"
	 fi

} #end of Inicio 

Menu(){

	ECHO "  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
	ECHO " |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
	ECHO "  __  __ _____ _   _ _   _           _____ ___ ____  _____ _____ _____  __ "
	ECHO " |  \/  | ____| \ | | | | |         |  ___|_ _|  _ \| ____|  ___/ _ \ \/ / "
	ECHO " | |\/| |  _| |  \| | | | |  _____  | |_   | || |_) |  _| | |_ | | | \  /  "
	ECHO " | |  | | |___| |\  | |_| | |_____| |  _|  | ||  _ <| |___|  _|| |_| /  \  "
	ECHO " |_|  |_|_____|_| \_|\___/          |_|   |___|_| \_|_____|_|   \___/_/\_\ "

	printf " \n"
	printf "_____	v $VERSION (by DaPGo) - Lang [$V_LANG] - FullList: [$V_VERBOSELIST]    ____\n"
	printf "_____  https://github.com/dapgo/Menu_Launcher4multiple_FF [GPL]   ____\n"


	if [ "$V_MODEDEBUG" = "Y" ]  
	then   ECHO "var: $VAR_OS   path: $PATH_MENUBIN"      
	fi

	#:SECTION1
	#  ----------------------------------------------------
	#                SECTION1 - Root folder and PROFILE folder
	#  ----------------------------------------------------
	# ECHO ********************************************************************
	ECHO "_____   	  Menu1: $V_STR_HEADER10   	 _____"
	ECHO "_____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ____"
	ECHO ""
	printf "$V_STR_HEADER11"
	# to delete  ECHO [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
	ECHO ""
	# ECHO "______  ___________________________________     __________________"

	ECHO "1) $NAME1  $Profile1Exist"
	ECHO "2) $NAME2  $Profile2Exist"
	ECHO "3) $NAME3  $Profile3Exist"
	ECHO "4) $NAME4  $Profile4Exist"
	ECHO "5) $NAME5  $Profile5Exist"
	ECHO "6) $NAME6  $Profile6Exist"
	ECHO "L/l) Language/Lenguaje EN/ES"
	ECHO "H/h) HELP (Includes info and predefined paths)"
	ECHO "X/x) Change List Mode: Full-All/Family2"
	ECHO "Q/q) Quit/Exit"
	# ###### CHOICE OS VARIANTS MENU1 ######


	read -n 1 -p "Choose an option: 1,2,3,.L,H,Q: " answer
	ECHO ""

	# debug mode:  
	if [ "$V_MODEDEBUG" = "Y" ]
	then  Echo "debugging" set -x     
	fi

} #end Menu


Launcher(){
	case $answer in
	  1) cd  "$PATH1/Vivaldi_Mac_2.10"
	pwd
	./Vivaldi.app/Contents/MacOS/Vivaldi --user-data-dir="$PROFILE1" --disable-machine-id --disable-encryption --disable-update &>/dev/null &
	disown
	;;
	  2) cd  "$PATH2/Serpent_Mac_201910"
		pwd
		#space require escaping
		./Serpent.app/Contents/MacOS/basilisk -v
	    ./Serpent.app/Contents/MacOS/basilisk  --no-remote --profile $PROFILE2 &>/dev/null &
	    disown
	    ;; 
	  3) cd  "$PATH3/NewMoonMac"
		pwd
		#space require escaping
		./New\ Moon.app/Contents/MacOS/palemoon -v
		#./NewMoon.app/Contents/MacOS/palemoon -v 	
	    ./New\ Moon.app/Contents/MacOS/palemoon --no-remote --profile $PROFILE3 &>/dev/null &
	    disown
	    ;; 


	  5) cd  "$PATH5/WaterfoxClassic_Mac_202001"
		pwd
		./Waterfox.app/Contents/MacOS/waterfox -v 
	    ./Waterfox.app/Contents/MacOS/waterfox --no-remote --profile $PROFILE5 &>/dev/null &
	    disown
	    ;; 
	  6) cd  "$PATH6/Firefox72Mac"
		pwd
		./Firefox72Mac.app/Contents/MacOS/firefox -v 
	    ./Firefox72Mac.app/Contents/MacOS/firefox  --no-remote --profile $PROFILE6 &>/dev/null &
	    disown
	    ;; 

	  h) Help
         Sleep 10
         Inicio
         ;;
	  l) echo "Language -  !! pending to implement"
	     sleep 1
	     Inicio;;

	  q) echo "Exit/Quiting"
	     sleep 1
	     Salir;;  
	  *) echo "invalid option, going back to menu"
	     sleep 1
	     Inicio;;
	esac
}

Help()  {	
    clear	
	ECHO "      __  __ ______ __     ____              ____ _   __ ______ ____     "
	ECHO "     / / / // ____// /    / __ \            /  _// | / // ____// __ \    "
	ECHO "    / /_/ // __/  / /    / /_/ /  ______    / / /  |/ // /_   / / / /    "
	ECHO "   / __  // /___ / /___ / ____/  /_____/  _/ / / /|  // __/  / /_/ /     "
	ECHO "  /_/ /_//_____//_____//_/               /___//_/ |_//_/     \____/      "
	ECHO "**********************************************************************"
	ECHO "***********    HELP0: for Firefox Legacy browsers       **************"
	ECHO "***********         Command Line parameters             **************"
	ECHO "**********************************************************************"
	
	ECHO "[Parameter/s]   :   Description"
	ECHO "______________  :   ___________________________________"
	ECHO "-h, /?, /h, help 		: Help and Information (this page)"
	ECHO "-l es 			: Language: Spanish"
	ECHO "-v, v, version, about 	: Batch version and about"  
	ECHO "Debug 			: verbose output for testing "
	ECHO "All, ListAll	: List all browsers (in 2nd Menu)"
	ECHO "Family 		: List only browsers associated to profile (in 2nd Menu)"
}


# MAIN program, call to functions
while true;
do
	Inicio
	Menu
	Launcher
done
