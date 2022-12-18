#! /bin/bash

echo "Kali 2022.4"
echo "Unzip rockyou"
if test -f "/usr/share/wordlists/rockyou.txt.gz"; then
  sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

echo "Install Sublime text"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text

echo "Prepare Metasploit"
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo msfdb init
sudo apt update
sudo apt install metasploit-framework

echo "Install Rclone"
sudo apt install rclone

echo "Install Visual Studio Code"
wget -O /tmp/vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install /tmp/vscode.deb

echo "Install golang"
sudo apt install golang

echo "Install bloodhound"
sudo apt install apt-transport-https
sudo apt install neo4j
wget -O /tmp/bloodhound.zip 'https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-linux-x64.zip'
sudo unzip /tmp/bloodhound.zip -d /opt
