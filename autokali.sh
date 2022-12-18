#! /bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset
 
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

echo -e "${Green}Kali 2022.4${Color_Off}"
echo "${Green}Unzip rockyou${Color_Off}"
if test -f "/usr/share/wordlists/rockyou.txt.gz"; then
  sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

echo "${Green}Install Sublime text${Color_Off}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text

echo "${Green}Prepare Metasploit${Color_Off}"
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo msfdb init
sudo apt update
sudo apt install -y metasploit-framework

echo "${Green}Install Rclone${Color_Off}"
sudo apt install -y rclone

echo "${Green}Install Visual Studio Code${Color_Off}"
wget -O /tmp/vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install -y /tmp/vscode.deb

echo "${Green}Install golang${Color_Off}"
sudo apt install -y golang

echo "${Green}Install bloodhound${Color_Off}"
sudo apt install -y apt-transport-https
sudo apt install -y neo4j
wget -O /tmp/bloodhound.zip 'https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-linux-x64.zip'
sudo unzip /tmp/bloodhound.zip -d /opt
