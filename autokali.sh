#! /bin/bash

echo "Kali 2022.4"
echo "Unzip rockyou"
gunzip /usr/share/wordlists/rockyou.txt.gz

echo "Install Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text

echo "Prepare Metasploit"
systemctl start postgresql
systemctl enable postgresql
msfdb init
apt update
apt install metasploit-framework

echo "Install Rclone"
apt install rclone

echo "Install Visual Studio Code"
wget -O /tmp/vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
apt install /tmp/vscode.deb

echo "Install golang"
apt install golang

echo "Install bloodhound"
apt install apt-transport-https
apt install neo4j
wget -O /tmp/bloodhound.zip 'https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-linux-x64.zip'
unzip /tmp/bloodhound.zip -d /opt
