#!/bin/bash
# Menu Launcher for multiple Firefox/webbrowsers
# https://github.com/dapgo/Menu_Launcher4multiple_FF
# specific for Unix script: Caps!!!, path slash....
# profile path requires double quotes when has spaces
# USB Fat32
# only for win and mac portables
# PEND 
# display clasification arrays
# reduce hardcoding with dynamic variables


VERSION="1.48 Basic"
clear
#naming the term window
echo -n -e "\033]0;SingleMenu 4 Multiple Browsers\007"

# -A associative array MUST be in main
 # Careful  associative are local scope by default
 declare -A array_enabled_browsers

ObtainRealPath(){
	# Begin obtain the realpath even if called from a symlink 
	#to be teste in MacOSX
	# print log only in debugmode
	V_SOURCE="${BASH_SOURCE[0]}"
	while [ -h "$V_SOURCE" ]; do # resolve $V_SOURCE until the file is no longer a symlink
	  TARGET="$(readlink "$V_SOURCE")"
	  if [[ $V_SOURCE == /* ]]; then
	    # echo " absolute symlink: '$V_SOURCE' to physical '$TARGET'"
	    V_SOURCE="$TARGET"
	  else
	    DIR="$( dirname "$V_SOURCE" )"
	    # echo "relative symlink: '$V_SOURCE' to '$TARGET' (relative to '$DIR')"
	    V_SOURCE="$DIR/$TARGET" # if $V_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	  fi
	done
	#echo "V_SOURCE is '$V_SOURCE'"
	RDIR="$( dirname "$V_SOURCE" )"
	DIR="$( cd -P "$( dirname "$V_SOURCE" )" && pwd )"
	#if [ "$DIR" != "$RDIR" ]; then
	# echo "DIR '$RDIR' resolves to '$DIR'"
	#fi

	#OUTPUT (PATH) from function
	echo $DIR

	# End obtain the realpath 
}


DeclareVars()
{
   #if Menu is failing set Debug  to Y to find the cause
	V_MODEDEBUG="N"
	# Store the path were Menu.batch is located
	V_CONFIGFILE=config_menu.conf.txt
	#file containing config, paths, strings....


	
    #PATH_MENU_xx can be predefined or dynamic
	# !doesn't work when launched from a symlink
	#PATH_MENUBIN="$(dirname "$0")"
   
    PATH_MENUBIN=$(ObtainRealPath)
    #or PATH_MENUBIN=`ObtainRealPath`

	#---ROOT PATH --- current chdir or a hardcoded path 
	# PATH_ROOT_CONTENT=/Users/daniel/Documents/MyMacApps/portableMacBrowsers
	# !doesn't work when launched from a symlink
	#PATH_ROOT_CONTENT="$(dirname "$0")"

	PATH_ROOT_CONTENT=$(ObtainRealPath)
	V_LANG="EN"
	# Values Y or something else

	# ALL/Verbose output, Menu2 includes the full list of webbrowsers
	 V_VERBOSELIST="N"
	# V_VERBOSELIST="ALL"
	# Values ALL or something else 
	V_DISPLAY_TAGS="Y"
	
	# Reserved, to avoid h,l,x,q
	V_STR_OPT="123456789abcdefgijkmnoprst"
	V_STR_CAPS_OPT="123456789ABCDEFGIJKMNOPRST"
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
		 V_STR_HEADER11="[Opcion] [Navegador (Unidad, Carpeta)] [etiqueta] [Ejec/perfil disponible]"
		 V_STR_HEADER20="SELECCIONAR un Navegador    version/variante"
		 V_STR_HEADER21="Disponible y compat. con perfil de navegador:"
		 V_STR_HEADER22="[Opcion] [ Navegador    Version     Desc ]        [Bin carpeta S/N]"
		 V_STR_QUESTION1="Escoge una opcion:"
		 V_STR_PAUSE="Pausa : Pulsa para continuar:"
		 #due comparation when displaying PEND to fix
		 V_STR_YES="Y"  
		 V_STR_NO="N"
		fi

	if [ "$V_LANG" != "ES" ] 
	then    
		 V_STR_HEADER10="WebBrowser - SELECT a PATH/DRIVE"
		 V_STR_HEADER11="[Option] [BrowserName (Drive, folder)] [tags]  [Bin/profile available]"
		 V_STR_HEADER20="SELECT a WebBrowser version/fork"
		 V_STR_HEADER21="Available and compat. with profile of browser:"
		 V_STR_HEADER22="[Option] [ BrowserName  Version     Desc ]        [Bin folder Y/N]"
		 V_STR_QUESTION1="Choose an option:"
		 V_STR_PAUSE="Pause : Type to continue:"
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

ChangeVerboseMode()
{ #ugly temp var required in DOS BATCH
  # TESTING 
  if [ $V_DISPLAY_TAGS = "Y" ]
   then TEMP_MODE="NO"
  fi
 if ! [ $V_DISPLAY_TAGS = "Y" ]
  	then TEMP_MODE="Y"
 fi
  V_DISPLAY_TAGS=$TEMP_MODE 
}


DebugStart()
{   printf "\n______________________________________________ \n"
	printf "Debug mode enabled\n"
	printf "uname: `uname` \n"
	printf "OStype: $OSTYPE \n"	
	bash -version |grep release
	printf "______________________________________________ \n"	
	printf "PATH_MENUBIN: $PATH_MENUBIN \n"
	printf "PATH_ROOT_CONTENT: $PATH_ROOT_CONTENT \n"
    printf "______________________________________________ \n"	
	printf "Config file $V_CONFIGFILE \n"
	printf "Last item: $c_citems-1 Not existing: $v_array_string \n"	
	printf "______________________________________________ \n"
	read -n 1 -p ${V_STR_PAUSE} kcontinue	 
#sleep 1
}

LoadBrowserConfiguration()
{ 
  # pend to call jutt once
  #LOAD CONFIGFILE can overwrite vars on script	 
	 #-s exists AND has a size > 0
		         
	 if [ -s "$V_CONFIGFILE" ] 
	   then	
			source ${V_CONFIGFILE} 	
			if [ "$V_MODEDEBUG" = "Y" ] ; then echo "File Exists and loaded: $V_CONFIGFILE "; fi		
	   else             	   
			echo "$V_CONFIGFILE Doesnt Exist"&&exit;
	 fi	 
	 
   # Variables with Browser configuration content can be here
   # Otherwise content will be read from config file (above)
}

ObtainTotalConfigItems()
{
 # input var: V_STR_CAPS_OPT
 # output var: c_citems
 # Count/Detect nbr of configuration items 1..9A..C
 #  -z detect vars not defined 1=exist/set   (void =exist)
 #  -n detect a var non void value 1=void
 
 #FOR until Break
 for ((c_citems=1;1==1;c_citems++)) 
 do 
   #variable with VarSuffix aka option char 
   # no need anymore v_opt_chrCap=${V_STR_CAPS_OPT:c_citems-1:1}
   #v_array_string="NAME$v_opt_chrCap"   
   v_array_string="NAME$c_citems"   
    	   
   #+x parameter expansion evaluates to nothing if var is unset, and substitutes the string x otherwise.
   if [ -z ${!v_array_string+x} ] ; then 
         #if [ "$V_MODEDEBUG" = "Y" ] ; then echo "Last: $c_citems-1 Not existing: $v_array_string"; fi		
		#if unset break the FOR loop 
		break
	else if [ "${!v_array_string}" == ""  ] ; then 					
		#if void value break the FOR loop 
		break				
			# else  echo "OK, has value" ${!v_array_string} "on: $v_array_string"				
	 fi
   fi   
 done
  c_citems=$((c_citems-1))  
  #if [ "$V_MODEDEBUG" = "Y" ] ;	then echo "Nbr of items : $c_citems "&&sleep 1;
  #fi  
}


Inicio()
{

    
	cd $PATH_MENUBIN
	PATH_MENUBIN=$PWD
	# root folder for browser families
	# ---ROOT PATH --- current chdir or a hardcoded path 
	#  PATH_ROOT_CONTENT=D:\00_PortableBrowsers
	PATH_ROOT_CONTENT=$PWD
	
	#  ----------------------------------------------------
	#                SECTION 0 - Variables and Path Declaration
	#  ----------------------------------------------------
	
	# GO BACK TO PATH were batch menu is 
	cd $PATH_MENUBIN
	
    #  ------- Call to function language -------
    LoadLanguage

} #end of Inicio 

Menu1(){
 # input var: c_citems
 
  
 c_array_i=0
 mystring="" 
 #unset to remove values from a previous menu
 unset array_enabled_browsers
 
 
    clear
	echo "  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____  "
	echo " |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____| "
	echo "  __  __ _____ _   _ _   _           _____ ___ ____  _____ _____ _____  __ "
	echo " |  \/  | ____| \ | | | | |         |  ___|_ _|  _ \| ____|  ___/ _ \ \/ / "
	echo " | |\/| |  _| |  \| | | | |  _____  | |_   | || |_) |  _| | |_ | | | \  /  "
	echo " | |  | | |___| |\  | |_| | |_____| |  _|  | ||  _ <| |___|  _|| |_| /  \  "
	echo " |_|  |_|_____|_| \_|\___/          |_|   |___|_| \_|_____|_|   \___/_/\_\ "

	printf " \n"
	printf "_____	v $VERSION - Lang [$V_LANG] - FullList: [$V_VERBOSELIST]  		  ____\n"
	printf "_____  https://github.com/dapgo/Menu_Launcher4multiple_FF [GPL]   ____\n"


	#:SECTION1
	#  ----------------------------------------------------
	#                SECTION1 - Root folder and PROFILE folder
	#  ----------------------------------------------------
	# echo ********************************************************************
	printf "_____   	  Menu1: $V_STR_HEADER10   	 _____\n"
	
    if [ "$V_MODEDEBUG" = "Y" ] 
		then printf "_____  Modes: Debug: $V_MODEDEBUG Verbose: $V_DISPLAY_TAGS List: $V_VERBOSELIST  _____\n"			
    fi	
	
	printf "_____ _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ____\n"
	echo ""
	printf "$V_STR_HEADER11"
	# to delete  echo [Option] [ BrowserName     - (Drive, folder)     ]    [Profile available Y/N]
	echo ""
	# echo "______  ___________________________________     __________________"
    
    #double uote if space in content
	
	for ((c_a=1;c_a<=c_citems;c_a++)) 
	do 
	 
		 #v_opt_chr=${V_STR_OPT:c_a-1:1}
		 #v_opt_chrCap=${V_STR_CAPS_OPT:c_a-1:1}
		 #v_dyn_var1="NAME$v_opt_chrCap"	
		 #v_dyn_var2="A_CLASIF$v_opt_chrCap[1]"	
		 #v_dyn_var3="PATH$v_opt_chrCap"	
		 #v_dyn_var4="PROFILE$v_opt_chrCap"	
		 v_dyn_var1="NAME$c_a"	
		 v_dyn_var2="A_CLASIF$c_a[1]"	
		 v_dyn_var3="PATH$c_a"	
		 v_dyn_var4="PROFILE$c_a"							
		 v_dyn_disabled="V_DISABLED$c_a"	
		 
		 #v_dyn_var3="A_CLASIF$c_a[]"	
		 #echo "Value  (substituted var):::  " ${!v_dyn_var1}    
		 #tab/columns printing, if space then quote variable
		 
		 #TEMP
		
		if [ -d "${!v_dyn_var3}" ]  
		# ok if [ -d ${!v_dyn_var3} ]  
			then 
			     PathExist="Y"
				 #if [ -d ${!v_dyn_var4} ] ; then ProfileExist="[$V_STR_YES,$V_STR_YES]"
				 if [ -d "${!v_dyn_var4}" ] ; then ProfileExist="Y"
				    #ProfileExist="[$V_STR_YES,$V_STR_YES]"
					 else ProfileExist="N"
					 #ProfileExist="[$V_STR_YES,$V_STR_NO]"
				 fi
			else PathExist="N"&&ProfileExist="N"
			#ProfileExist="[$V_STR_NO,$V_STR_NO]" 
			fi		 


		
		#Display not disabled entries, All or Existing/detected
		# debuggin errors echo "Disabled:" ${!v_dyn_disabled}		
		if [ "${!v_dyn_disabled}" =  "N" ];then
			if [ "$PathExist" =  "Y" ] || [ $V_VERBOSELIST = "ALL" ]
			  then
				#options that will work in the anwser case 
				
				v_opt_chrCap=${V_STR_CAPS_OPT:c_array_i:1}	
				v_opt_chr=${V_STR_OPT:c_array_i:1}
				
				#associative array, defined in main			
				array_enabled_browsers[$v_opt_chrCap]=$c_a
				
				if (( "$c_array_i">"8" )); then array_enabled_browsers[$v_opt_chr]=$c_a;fi	
				
				#delete testing  echo "all content" ${array_enabled_browsers[*]}
				#delete testing echo "all index" ${!array_enabled_browsers[@]}
				
							
				#create string with all options for case
				#also works [ "$c_array_i" -eq "0" ]
				if (( "$c_array_i"=="0" )); then mystring="${v_opt_chrCap}"                         
				   else if (( "$c_array_i"<"8" )); then mystring="${mystring}""|""${v_opt_chrCap}"
					else if (( "$c_array_i">"8" )); then mystring="${mystring}""|""${v_opt_chrCap}""|""${v_opt_chr}";fi
				   fi
				fi  
				#create string options for case
				
				printf "%2s %1s %-48s %5s %3s %3s\n" "${v_opt_chrCap}" ")" "${!v_dyn_var1}" "${!v_dyn_var2}" "${PathExist}" "${ProfileExist}"
				 #"${ProfileExist}"
				 
							
				v_array_string="A_CLASIF$c_a"	
				# or just for print:  eval echo \${#$v_array_string[@]}	
				# Total items of  array1: ${#array[@]} ${#array[*]}
				eval v_array_length=\${#$v_array_string[@]}
				 
				
				
				#TAG info only if selected		
				if  [ "$V_DISPLAY_TAGS" = "Y" ] 
					then
					#Print info TAGS multiple array content	 
					 for ((c_b=0;c_b<=${v_array_length-1};c_b++)) 
					 do         
						 #requires assign to a var and later !substitution		
						 v_array_string="A_CLASIF$c_a[$c_b]"			 			 
						 #echo "--Logging Value (substituted var):::  " ${!v_array_string}				 
						if (( $c_b == 0)) || (( $c_b == 4))
							then colpos=10
						 else  colpos=6		
						 fi  
						 # tabulated print
						 printf "%${colpos}s" ${!v_array_string}
					 done
					 printf "\n"
				fi 
			 #read -n 1 -p ${V_STR_PAUSE} kcontinue
			#increase enabled counter 
			((c_array_i=c_array_i+1))		
			fi	
			#END of IF display when all or ProfileExist
		fi #END of DISABLED check
	
	done	#END of FOR c_a<=c_citems
	
	
 
	echo "L/l) Language/Lenguaje EN/ES"
	echo "H/h) HELP (Includes info and predefined paths)"
	echo "X/x) Change List Mode: Full-All/Family"
	echo "V/v) Change Verbose Mode: Display/hide info"
	echo "Q/q) Quit/Exit"
	
	# ###### CHOICE OS VARIANTS MENU1 ######
	
	read -n 1 -p "$V_STR_QUESTION1 from $mystring  or H,Q: " answer
	echo ""

	# debug mode:  
	#if [ "$V_MODEDEBUG" = "Y" ]
	#then  echo "debugging" set -x     
	#fi


#if [ "$V_MODEDEBUG" = "Y" ] 
#		then echo "chossen: "${answer} "(index):" ${!array_enabled_browsers[@]} "(values):" ${array_enabled_browsers[*]}		
#fi		

} #end Menu1


Launcher(){

if [ "$V_MODEDEBUG" = "Y" ] 
		then echo "chossen: "${answer} "(index):" ${!array_enabled_browsers[@]} "(values):" ${array_enabled_browsers[*]}			
fi	


# If prompt has a enabled value, then translate to Configuration var suffix i.e A=10
if [[ $mystring == *"$answer"* ]]; then
    v_config_suffix=${array_enabled_browsers["$answer"]}
	echo "Suffix of Choseen Browser:"  ${v_config_suffix}
	#echo "Choseen Browser:"  ${array_enabled_browsers["$answer"]}

	  #echo "It's there!"
	v_final_var1="NAME$v_config_suffix"	
	v_inter_var3="V_FAMILY$v_config_suffix"	
	v_final_var3=${!v_inter_var3}	
	v_final_var4="PATH$v_config_suffix"	
    v_final_bin="V_EXEC_BIN$v_config_suffix"	
	v_final_profile="PROFILE$v_config_suffix"
	
	
	echo "Choseen nameBrowser:"  ${!v_final_var1}     
	echo "family:" ${v_final_var3}  
	
	cd "${!v_final_var4}"	
	pwd
	
	
	#bad (("${!v_final_var3}" == "CH" ))
	
    #compared var requires an adittional step with var subtitution 	
	if [ "${v_final_var3}" == "CH" ]
	     then
			echo " ______________Chrome______________"            			
			./${!v_final_bin} --user-data-dir="${!v_final_profile}" --disable-machine-id --disable-encryption --disable-update &>/dev/null &
			disown
			#wildcard requires double braquet
		else if [[ "${v_final_var3}" == "FF"* ]]
				then 
				echo " ______________Generic Firefox ______________"				
		        ./${!v_final_bin} -v
				nohup ./${!v_final_bin} --no-remote --profile "${!v_final_profile}" &>/dev/null &   
				# ?? disown	
				
		#	else if [ "${v_final_var3}" == "FF56" ]
		#			then  echo " ______________Firefox 56______________"	
		#			./${!v_final_bin} -v
		#			nohup ./${!v_final_bin} --no-remote --profile "${!v_final_profile}" &>/dev/null	&				
		#			
		#	else if [ "${v_final_var3}" == "FF52" ]
		#		then  echo " ______________Firefox 52______________"	
		#		./${!v_final_bin} -v
		#		nohup ./${!v_final_bin} --no-remote --profile "${!v_final_profile}" &>/dev/null &					
		
				else echo "______________family not recognized______________"
		#		fi
		#	fi
		fi
	fi
	echo " **********************************************************************"
    echo " ********     Selected WebBrowser is being launched        ************"
	echo " ********           Please Wait a Minute                  *************"
	echo " ***************************************************** ****************"
	read -n 1 -p "$V_STR_PAUSE" kcontinue
	#sleep 2
  
  else
   echo "else   $answer"
   case "$answer" in
   
	  H|h) Help                  
         ;;
	  L|l) #echo "Language - "	     
	     ChangeLanguage	     
	     ;;

	  Q|q) echo "Exit/Quiting"
	     sleep 0
	     Salir;;  
	  X|x) #echo "Change List Mode"
	     #sleep 1
	     ChangeListMode_M1	     
		 ;;
	  V|v) #echo "Change List Mode"
	     #sleep 1
	     ChangeVerboseMode	     
		 ;;
	  *) 
	      echo " Option $answer not recognized "	   	
		  sleep 1
	     ;;
	esac   
  
  
  fi #end of IF mystring == $answer"	  

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
	
	read -n 1 -p "$V_STR_PAUSE" kcontinue
}


# MAIN program, call to functions
DeclareVars
	
#  ------- Call to function BrowsersCOnfiguration -------
LoadBrowserConfiguration	
#  ------- Call to function TotalConfigItems loaded -------
ObtainTotalConfigItems	
if [ "$V_MODEDEBUG" = "Y" ] ; then DebugStart ; fi		

while true;
do	
	Inicio
	Menu1
	#variables declared inside a previous function are not available to below functions
	Launcher
done
