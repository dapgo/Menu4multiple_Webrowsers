#!/bin/bash
# Menu Launcher for multiple Firefox/webbrowsers
# https://github.com/dapgo/Menu_Launcher4multiple_FF
# specific for Unix script: Caps!!!, path slash....
# PEND
# nohup work on linux , to verify macOS
# profile path requires double quotes when has spaces

VERSION="1.1 SingleMenu"
clear
#naming the term window
echo -n -e "\033]0;SingleMenu 4 Multiple Browsers\007"

DeclareVars()
{
V_MODEDEBUG="N"
	# Store the path were Menu.batch is located
	PATH_MENUBIN="$(dirname "$0")"
	#---ROOT PATH --- current chdir or a hardcoded path 
	# PATH_ROOT_CONTENT=/Users/daniel/Documents/MyMacApps/portableMacBrowsers
	PATH_ROOT_CONTENT="$(dirname "$0")"
	V_LANG="EN"
	# Values Y or something else

	# ALL/Verbose output, Menu2 includes the full list of webbrowsers
	 V_VERBOSELIST="N"
	# V_VERBOSELIST="ALL"
	# Values ALL or something else 
}


Salir()
{
	echo "Quit/Salir"
    exit 1;
}

LoadLanguage()
{
# LANGUAGE STRINGS ------------
	# brackets requires double quotes
	if [ "$V_LANG" = "ES" ]
		then  
		 V_STR_HEADER10="Navegador  - SELECCIONAR una UNIDAD"
		 V_STR_HEADER11="[Opcion] [ Navegador   - (Unidad, Carpeta)  ]  [Ejec/perfil disponible S/N]"
		 V_STR_HEADER20="SELECCIONAR un Navegador    version/variante"
		 V_STR_HEADER21="Disponible y compat. con perfil de navegador:"
		 V_STR_HEADER22="[Opcion] [ Navegador    Version     Desc ]        [Bin carpeta S/N]"
		 V_STR_QUESTION1="Escoge una opcion:"
		 V_STR_YES="S"
		 V_STR_NO="N"
		fi

	if [ "$V_LANG" != "ES" ] 
	then    
		 V_STR_HEADER10="WebBrowser - SELECT a PATH/DRIVE"
		 V_STR_HEADER11="[Option] [ BrowserName   - (Drive, folder)  ]  [Exec/profile available Y/N]"
		 V_STR_HEADER20="SELECT a WebBrowser version/fork"
		 V_STR_HEADER21="Available and compat. with profile of browser:"
		 V_STR_HEADER22="[Option] [ BrowserName  Version     Desc ]        [Bin folder Y/N]"
		 V_STR_QUESTION1="Choose an option:"
		 V_STR_YES="Y"
		 V_STR_NO="N"
	fi
}

ChangeLanguage()
{ #ugly temp var required in DOS BATCH
#careful nix is case sensitive
 if  [ $V_LANG = "EN" ]
 	then TEMP_LANG="ES"
fi

 if  ! [ $V_LANG = "EN" ]
 	then TEMP_LANG="EN"
 fi 
 V_LANG=$TEMP_LANG

 LoadLanguage
}

ChangeListMode_M1()
{ #ugly temp var required in DOS BATCH
	if [ $V_VERBOSELIST = "ALL" ]
   then TEMP_MODE="NO"
  fi
 if ! [ $V_VERBOSELIST = "ALL" ]
  	then TEMP_MODE="ALL"
 fi
  V_VERBOSELIST=$TEMP_MODE
}

Inicio()
{
 	
	if [ "$V_MODEDEBUG" = "Y" ] 
	then 
		printf "uname:"
		uname
		printf "\n OStype: $OSTYPE \n"	
		bash -version |grep release
		echo "dirname: $PATH_MENUBIN"		
		echo "pwd: `pwd`"		
		sleep 5
	fi

	cd $PATH_MENUBIN

	PATH_MENUBIN=$PWD
	# root folder for browser families


	# ---ROOT PATH --- current chdir or a hardcoded path 
	#  PATH_ROOT_CONTENT=D:\00_PortableBrowsers
	PATH_ROOT_CONTENT=$PWD


    #Call to function language
    LoadLanguage


	#  ----------------------------------------------------
	#                SECTION 0 - Variables and Path Declaration
	#  ----------------------------------------------------

	# GO BACK TO PATH were batch menu is 
	cd $PATH_MENUBIN
	

	 NAME1="Chromium/Vivaldi 2.10(ch79) (Mac64b)(./ChromeBrowsers)     	."
	 #PATH1="$PATH_ROOT_CONTENT/ChromeBrowsers"	 
	 PROFILE1="$PATH_ROOT_CONTENT/ChromeBrowsers/Profiles"
	 PATH1="$PATH_ROOT_CONTENT/ChromeBrowsers/Vivaldi_Mac_2.10/Vivaldi.app/Contents/MacOS"
	 V_EXEC_BIN1="Vivaldi"
	if [ -d "$PATH1" ]  
     then
		 if [ -d "$PROFILE1" ] ; then 	Profile1Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile1Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile1Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	NAME2="FF52/Basilisk /Serpent 2019 (Mac64b)( ./BasiliskBrowsers)   	."
	PATH2="$PATH_ROOT_CONTENT/BasiliskBrowsers"
	PROFILE2="$PATH_ROOT_CONTENT/BasiliskBrowsers/Profiles/5sq5azxp.default"
	if [ -d "$PATH2" ]  
     then
		 if [ -d "$PROFILE2" ] ; then 	Profile2Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile2Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile2Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	NAME3="FF28/Palemoon /NewMoon 28.8.0 (Mac64b)( ./PalemoonBrowsers) 	."
	PATH3="$PATH_ROOT_CONTENT/PalemoonBrowsers/NewMoonMac"
	PROFILE3="$PATH_ROOT_CONTENT/PalemoonBrowsers/Profiles/Default"
	V_EXEC_BIN3="New Moon.app/Contents/MacOS/palemoon"
	 if [ -d "$PATH3" ]  
     then
		 if [ -d "$PROFILE3" ] ; then 	Profile3Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile3Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile3Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	NAME4="FF28/Palemoon  28.8.0 	(*nix64)( /usr/lib/palemoon/) 	."
	#PATH4="$PATH_ROOT_CONTENT/PalemoonBrowsers"
	PATH4="/usr/lib/palemoon"
	#PROFILE4="$PATH_ROOT_CONTENT/PalemoonBrowsers/Profiles/Default"
	PROFILE4="/home/dpg/.moonchild productions/pale moon/cr78tdr6.default"
	V_EXEC_BIN4="palemoon"
	if [ -d "$PATH4" ]  
     then
		 if [ -d "$PROFILE4" ] ; then 	Profile4Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile4Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile4Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	 NAME5="FF56/WaterfoxClassic 202001 (Mac64b)( ./Waterfox_browsers)   ."
	 PATH5="$PATH_ROOT_CONTENT/Waterfox_browsers/WaterfoxClassic_Mac_202001/Waterfox.app/Contents/MacOS"
	 PROFILE5="$PATH_ROOT_CONTENT/Waterfox_browsers/Profile"
	 V_EXEC_BIN5="waterfox"
	 if [ -d "$PATH5" ] ;    then	 if [ -d "$PROFILE5" ]  
	 										then 	Profile5Exist="[$V_STR_YES,$V_STR_YES]"
									     	else Profile5Exist="[$V_STR_YES,$V_STR_NO]"
		 								fi
							else	Profile5Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	NAME6="FF56/WaterfoxClassic 202001 (*nix64)( ./Waterfox_browsers)   ."	 
	PATH6="$PATH_ROOT_CONTENT/Waterfox_browsers/WaterfoxClassic_linux_202002"
	PROFILE6="$PATH_ROOT_CONTENT/Waterfox_browsers/Profile"
	V_EXEC_BIN6="waterfox-bin"	 		
     if [ -d "$PATH6" ]  
     then
		 if [ -d "$PROFILE6" ] ; then 	Profile6Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile6Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile6Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

	NAME7="FF52/Basilisk /Serpent 202002 (*nix64)( ./BasiliskBrowsers)  ."
	PATH7="$PATH_ROOT_CONTENT/BasiliskBrowsers/basilisk_nix_202002"
	PROFILE7="$PATH_ROOT_CONTENT/BasiliskBrowsers/Profiles/5sq5azxp.default"
	V_EXEC_BIN7="basilisk-bin" 		
	if [ -d "$PATH7" ]  
     then
		 if [ -d "$PROFILE7" ] ; then 	Profile7Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile7Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile7Exist="[$V_STR_NO,$V_STR_NO]" 
	fi


	 NAME9="FF57/FirefoxQuantum 70.x (Mac64b)( ./QuantumBrowsers)        ."
	 PATH9="$PATH_ROOT_CONTENT/QuantumBrowsers"
	 PROFILE9="$PATH_ROOT_CONTENT/QuantumBrowsers/Profiles/QuantumDefault"
	if [ -d "$PATH9" ]  
     then
		 if [ -d "$PROFILE9" ] ; then 	Profile9Exist="[$V_STR_YES,$V_STR_YES]"
		     else Profile9Exist="[$V_STR_YES,$V_STR_NO]"
		 fi
	else	Profile9Exist="[$V_STR_NO,$V_STR_NO]" 
	fi

} #end of Inicio 

Menu1(){
    clear
	echo "  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
	echo " |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
	echo "  __  __ _____ _   _ _   _           _____ ___ ____  _____ _____ _____  __ "
	echo " |  \/  | ____| \ | | | | |         |  ___|_ _|  _ \| ____|  ___/ _ \ \/ / "
	echo " | |\/| |  _| |  \| | | | |  _____  | |_   | || |_) |  _| | |_ | | | \  /  "
	echo " | |  | | |___| |\  | |_| | |_____| |  _|  | ||  _ <| |___|  _|| |_| /  \  "
	echo " |_|  |_|_____|_| \_|\___/          |_|   |___|_| \_|_____|_|   \___/_/\_\ "

	printf " \n"
	printf "_____	v $VERSION (by DaPGo) - Lang [$V_LANG] - FullList: [$V_VERBOSELIST]    ____\n"
	printf "_____  https://github.com/dapgo/Menu_Launcher4multiple_FF [GPL]   ____\n"


	if [ "$V_MODEDEBUG" = "Y" ]  
	then   echo "var: $VAR_OS   path: $PATH_MENUBIN"      
	fi

	#:SECTION1
	#  ----------------------------------------------------
	#                SECTION1 - Root folder and PROFILE folder
	#  ----------------------------------------------------
	# echo ********************************************************************
	echo "_____   	  Menu1: $V_STR_HEADER10   	 _____"
	echo "_____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ____"
	echo ""
	printf "$V_STR_HEADER11"
	# to delete  echo [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
	echo ""
	# echo "______  ___________________________________     __________________"
    
    #double uote if space in content
	if [ "$Profile1Exist" =  "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "1) $NAME1  $Profile1Exist"
	fi
	if [ "$Profile2Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "2) $NAME2  $Profile2Exist"
	fi	
	if [ "$Profile3Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "3) $NAME3  $Profile3Exist"
	fi	
    if [ "$Profile4Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "4) $NAME4  $Profile4Exist"
	fi	 	
	if [ "$Profile5Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "5) $NAME5  $Profile5Exist"
	fi
    if [ "$Profile6Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "6) $NAME6  $Profile6Exist"
	fi
	if [ "$Profile7Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "7) $NAME7  $Profile7Exist"
	fi

	if [ "$Profile9Exist" = "[$V_STR_YES,$V_STR_YES]" ] || [ $V_VERBOSELIST = "ALL" ]
		then echo "9) $NAME9  $Profile9Exist"
	fi
	
	echo "L/l) Language/Lenguaje EN/ES"
	echo "H/h) HELP (Includes info and predefined paths)"
	echo "X/x) Change List Mode: Full-All/Family2"
	echo "Q/q) Quit/Exit"
	# ###### CHOICE OS VARIANTS MENU1 ######


	read -n 1 -p "Choose an option: 1,2,3,.L,H,Q: " answer
	echo ""

	# debug mode:  
	if [ "$V_MODEDEBUG" = "Y" ]
	then  echo "debugging" set -x     
	fi


} #end Menu1
Launcher(){
	case $answer in
	  1) 
       cd  "$PATH1"
	   pwd
	   #./Vivaldi.app/Contents/MacOS/Vivaldi --user-data-dir="$PROFILE1" --disable-machine-id --disable-encryption --disable-update &>/dev/null &
       ./$V_EXEC_BIN1 --user-data-dir="$PROFILE1" --disable-machine-id --disable-encryption --disable-update &>/dev/null &
	   disown
	   ;;
	  2) cd  "$PATH2/Serpent_Mac_201910"
		pwd
		#space require escaping
		./Serpent.app/Contents/MacOS/basilisk -v
	    ./Serpent.app/Contents/MacOS/basilisk  --no-remote --profile $PROFILE2 &>/dev/null &
	    disown
	    ;; 
	  3) cd  "$PATH3"
		pwd
		#space require escaping
		#/NewMoonMac
		#./New\ Moon.app/Contents/MacOS/palemoon -v
		./"$V_EXEC_BIN3" -v
		#./NewMoon.app/Contents/MacOS/palemoon -v 	
	    #./New\ Moon.app/Contents/MacOS/palemoon --no-remote --profile $PROFILE3 &>/dev/null &
	    nohup ./"$V_EXEC_BIN3" --no-remote --profile "$PROFILE3" &>/dev/null &
	    ;; 

	4) 
        cd "$PATH4"
        pwd
        ./$V_EXEC_BIN4 -v
		nohup ./$V_EXEC_BIN4 --no-remote --profile "$PROFILE4" &>/dev/null &        
	    sleep 2
	    ;; 

	  5) 
	    cd  "$PATH5"
		pwd		
		./$V_EXEC_BIN5 -v
		#./Waterfox.app/Contents/MacOS/waterfox -v 		
	    # ./Waterfox.app/Contents/MacOS/waterfox --no-remote --profile $PROFILE5 &>/dev/null &
	    nohup ./$V_EXEC_BIN5 --no-remote --profile $PROFILE5 &>/dev/null &
	    disown
	    ;; 


	  6) 
        cd "$PATH6"
        pwd
        ./$V_EXEC_BIN6 -v
		nohup ./$V_EXEC_BIN6 --no-remote --profile $PROFILE6 &>/dev/null &
        #cd  "$PATH5/WaterfoxClassic_linux_202002"	 
		#pwd
		#./waterfox-bin -v
		#nohup ./waterfox-bin --no-remote --profile $PROFILE5 &>/dev/null &
	    #disown -h
	    sleep 2
	    ;; 
      7) 
        cd "$PATH7"
        pwd
        nohup ./$V_EXEC_BIN7 -v
		nohup ./$V_EXEC_BIN7 --no-remote --profile $PROFILE7 &>/dev/null &
       ;;

	  9) cd  "$PATH6/Firefox72Mac"
		pwd
		./Firefox72Mac.app/Contents/MacOS/firefox -v 
	    ./Firefox72Mac.app/Contents/MacOS/firefox  --no-remote --profile $PROFILE6 &>/dev/null &
	    disown
	    ;; 

	  h) Help
         Sleep 10
         Inicio
         ;;
	  l) #echo "Language - "	     
	     ChangeLanguage
	     Menu1
	     ;;

	  q) echo "Exit/Quiting"
	     sleep 1
	     Salir;;  
	  x) #echo "Change List Mode"
	     #sleep 1
	     ChangeListMode_M1
	     Menu1;;
	  *) echo "invalid option!, going back to menu"
	     sleep 1
	     Inicio;;
	esac
}




Help()  {	
    clear	
	echo "      __  __ ______ __     ____              ____ _   __ ______ ____     "
	echo "     / / / // ____// /    / __ \            /  _// | / // ____// __ \    "
	echo "    / /_/ // __/  / /    / /_/ /  ______    / / /  |/ // /_   / / / /    "
	echo "   / __  // /___ / /___ / ____/  /_____/  _/ / / /|  // __/  / /_/ /     "
	echo "  /_/ /_//_____//_____//_/               /___//_/ |_//_/     \____/      "
	echo "**********************************************************************"
	echo "***********    HELP0: for Firefox Legacy browsers       **************"
	echo "***********         Command Line parameters             **************"
	echo "**********************************************************************"
	
	echo "[Parameter/s]   :   Description"
	echo "______________  :   ___________________________________"
	echo "-h, /?, /h, help 		: Help and Information (this page)"
	echo "-l es 			: Language: Spanish"
	echo "-v, v, version, about 	: Batch version and about"  
	echo "Debug 			: verbose output for testing "
	echo "All, ListAll	: List all browsers (in 2nd Menu)"
	echo "Family 		: List only browsers associated to profile (in 2nd Menu)"
}


# MAIN program, call to functions
DeclareVars
while true;
do	
	Inicio
	Menu1
	Launcher
done
