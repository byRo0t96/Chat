#!/bin/bash
# v.0.0.1
# Chat
# Coded by: Ro0t-96
# Github: https://github.com/byRo0t96
#!/bin/bash
printf '\033]2;Chat\a'
#########################resize terminal window
resize -s 35 76 > /dev/null

#########################Colors
cyan='\e[0;36m'
lightcyan='\e[96m'
green='\e[0;32m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
Escape="\033";
white="${Escape}[0m";
RedF="${Escape}[31m";
GreenF="${Escape}[32m";
LighGreenF="${Escape}[92m"
YellowF="${Escape}[33m";
BlueF="${Escape}[34m";
CyanF="${Escape}[36m";
Reset="${Escape}[0m";
trap 'printf "\n";stop;exit 1' 2

#########################logo
logo() {
clear
printf "\e[1;32m"
printf " ▄████████    ▄█    █▄ 0.0.1▄████████     ███     \n"
printf "███    ███   ███    ███     ███    ███ ▀█████████▄ \n"
printf "███    █▀    ███    ███     ███    ███    ▀███▀▀██ \n"
printf "███         ▄███▄▄▄▄███▄▄   ███    ███     ███   ▀ \n"
printf "███        ▀▀███▀▀▀▀███▀  ▀███████████     ███     \n"
printf "███    █▄    ███    ███     ███    ███     ███     \n"
printf "███    ███   ███    ███     ███    ███     ███     \n"
printf "████████▀    ███    █▀      ███    █▀     ▄████▀   \n"
printf "             https://github.com/byRo0t96           \n"
printf "\033"
printf "\n"

}
#########################list
list() {
printf "\e[1;32m[\e[1;31m01\e[1;32m] \e[1;33mlocalhost \e[1;34m(just in this computer)\033\n"
printf "\e[1;32m[\e[1;31m02\e[1;32m] \e[1;33mlocal Network \e[1;34m(for the people in the same wifi or cable)\033\n"
printf "\e[1;32m[\e[1;31m03\e[1;32m] \e[1;33mOnline \e[1;34m(anyone can enter to this chat by using ngrok)\033\n"
printf "\n"
printf "\e[1;32m[\e[1;31m00\e[1;32m] \e[1;33mStart all\033\n"
printf "\e[1;32m[\e[1;31mQQ\e[1;32m] \e[1;33mExit\033\n"
printf "\033"
}
#########################option
option() {
read -p $'\e[1;37mRo0t-96>' option

if [[ $option == q || $option == qq || $option == Q || $option == QQ ]]; then
exit 1

elif [[ $option == 1 || $option == 01 ]]; then
server="server"
localhost="y"
start
option

elif [[ $option == 2 || $option == 02 ]]; then
server="server"
localhost="y"
localnetwork="y"
start
option

elif [[ $option == 3 || $option == 03 ]]; then
server="server"
localhost="y"
start_ngrok="y"
start
option

elif [[ $option == 0 || $option == 00 ]]; then
server="server"
localhost="y"
localnetwork="y"
start_ngrok="y"
start
option

else
printf "\e[1;31m [!] Invalid option!\n"
sleep 1
option
fi
}
########################down
down(){
cd downloads
git clone https://github.com/byRo0t96/$name.git
cd ..
}
########################all
all(){
cd downloads

cd ..
}
#########################start
start() {
downloads
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
if [[ $localhost == y || $localhost == yy || $localhost == Y || $localhost == YY ]]; then
printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n"
cd $server && php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
fi
if [[ $localnetwork == y || $localnetwork == yy || $localnetwork == Y || $localnetwork == YY ]]; then
default_ip=$(hostname -I)
printf "\e[1;92m[\e[0m*\e[1;92m] Put your local IP (Default %s): " $default_ip
read ip
ip="${ip:-${default_ip}}"
sudo php -t "$server" -S "$ip:80" > /dev/null 2>&1 & 
sleep 2
fi
if [[ $start_ngrok == y || $start_ngrok == yy || $start_ngrok == Y || $start_ngrok == YY ]]; then
downloadngrok
printf "\e[1;92m[\e[0m*\e[1;92m] Starting ngrok server...\n"
downloads/ngrok http 3333 > /dev/null 2>&1 &
sleep 10
fi
if [[ $localhost == y || $localhost == yy || $localhost == Y || $localhost == YY ]]; then
link_h="http://127.0.0.1:3333"
printf "\e[1;92m[\e[0m*\e[1;92m] localhost:\e[0m\e[1;77m %s\e[0m\n" $link_h
fi
if [[ $localnetwork == y || $localnetwork == yy || $localnetwork == Y || $localnetwork == YY ]]; then
printf "\e[1;92m[\e[0m*\e[1;92m] local network:\e[0m\e[1;77m http://%s\e[0m\n" $ip
fi
if [[ $start_ngrok == y || $start_ngrok == yy || $start_ngrok == Y || $start_ngrok == YY ]]; then
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] ngrok.io:\e[0m\e[1;77m %s\e[0m\n" $link
fi
c_stop
}
#########################c_stop
c_stop(){
read -p $'\e[1;37mtype Y to Stop:' phpstopo
if [[ $phpstopo == y || $phpstopo == Y ]]; then
stop
else
printf "\e[1;31m [!] Invalid option!\n"
sleep 1
c_stop
fi
}
#########################
stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
}
#########################download
downloadngrok(){
downloads
cd downloads
if [[ -e ngrok ]]; then
echo ""
else
unzipwget
printf "\e[1;92m[\e[0m*\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi
cd ..
}
#########################downloads
downloads() {
if [[ -e downloads ]]; then
echo 
else
mkdir downloads
fi
}
#########################dependencies
dependencies() {
command -v php > /dev/null 2>&1 || { echo >&2 "php it's not installed. Install it..."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "curl it's not installed. Install it..."; exit 1; }
}
#########################unzipwget
unzipwget(){
command -v unzip > /dev/null 2>&1 || { echo >&2 "unzip it's not installed. Install it..."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "wget it's not installed. Install it..."; exit 1; }
}
dependencies
unzipwget
logo
list
option



