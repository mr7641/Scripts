#! /bin/bash

LGREEN='\033[1;32m'

echo -e "${LGREEN}Kali 2022.4"
echo "${LGREEN}Unzip rockyou"
if test -f "/usr/share/wordlists/rockyou.txt.gz"; then
  sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

echo "${LGREEN}Install Sublime text"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text

echo "${LGREEN}Prepare Metasploit"
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo msfdb init
sudo apt update
sudo apt install -y metasploit-framework

echo "${LGREEN}Install Rclone"
sudo apt install -y rclone

echo "${LGREEN}Install Visual Studio Code"
wget -O /tmp/vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install -y /tmp/vscode.deb

echo "${LGREEN}Install golang"
sudo apt install -y golang

echo "${LGREEN}Install bloodhound"
sudo apt install -y apt-transport-https
sudo apt install -y neo4j
wget -O /tmp/bloodhound.zip 'https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-linux-x64.zip'
sudo unzip /tmp/bloodhound.zip -d /opt
