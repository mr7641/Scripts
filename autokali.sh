#! /bin/bash

# to run the script
# sudo bash autokali.sh <dropbox token>

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
echo -e "${Green}===Unzip rockyou wordlists===${Color_Off}"
if test -f "/usr/share/wordlists/rockyou.txt.gz"; then
  gunzip /usr/share/wordlists/rockyou.txt.gz
fi

echo -e "${Green}===Install Sublime text===${Color_Off}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt -qq update
apt -qq install -y sublime-text

echo -e "${Green}===Prepare Metasploit===${Color_Off}"
systemctl start postgresql
systemctl enable postgresql
msfdb init
apt -qq update
apt -qq install -y metasploit-framework

echo -e "${Green}===Install Visual Studio Code===${Color_Off}"
wget -qO /tmp/vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
apt -qq install -y /tmp/vscode.deb

echo -e "${Green}===Install golang===${Color_Off}"
apt -qq install -y golang

echo -e "${Green}===Install and setup samba===${Color_Off}"
apt -qq install -y samba
cp /etc/samba/smb.conf /etc/samba/smb.conf.old
cat <<EOF > /etc/samba/smb.conf
[osep]
path = /home/kali/Workspaces/OSEP
browseable = yes
read only = no
EOF
(echo "kali"; echo "kali") | smbpasswd -s -a kali
systemctl start smbd nmbd

echo -e "${Green}===Install Chisel===${Color_Off}"
cd /opt; git clone https://github.com/jpillora/chisel.git
cd /opt/chisel; go build; env GOOS=windows GOARCH=amd64 go build -o chisel.exe -ldflags "-s -w"

echo -e "${Green}===Clone go shellcode===${Color_Off}"
cd /opt; git clone -q https://github.com/Ne0nd0g/go-shellcode.git

echo -e "${Green}===Clone dirsearcher===${Color_Off}"
cd /opt; git clone -q https://github.com/maurosoria/dirsearch.git

echo -e "${Green}===Install mono for compiling C# project===${Color_Off}"
apt -qq install -y mono-complete

echo -e "${Green}===Install Kerberos client ===${Color_Off}"
DEBIAN_FRONTEND=noninteractive apt -qq install -y krb5-user

echo -e "${Green}Install bloodhound${Color_Off}"
# install neo4j
apt -qq install -y apt-transport-https
apt -qq install -y neo4j
# set initial password for neo4j
/usr/share/neo4j/bin/neo4j-admin set-initial-password 123abc
# install bloodhound
wget -qO /tmp/bloodhound.zip 'https://github.com/BloodHoundAD/BloodHound/releases/download/4.2.0/BloodHound-linux-x64.zip'
unzip -qq /tmp/bloodhound.zip -d /opt
# configure bloodhound
mkdir -p /home/kali/.config/bloodhound
cat <<EOF > /home/kali/.config/bloodhound/config.json
{
	"performance": {
		"edge": 5,
		"lowGraphics": false,
		"nodeLabels": 0,
		"edgeLabels": 0,
		"darkMode": true
	},
	"edgeincluded": {
		"MemberOf": true,
		"HasSession": true,
		"AdminTo": true,
		"AllExtendedRights": true,
		"AddMember": true,
		"ForceChangePassword": true,
		"GenericAll": true,
		"GenericWrite": true,
		"Owns": true,
		"WriteDacl": true,
		"WriteOwner": true,
		"CanRDP": true,
		"ExecuteDCOM": true,
		"AllowedToDelegate": true,
		"ReadLAPSPassword": true,
		"Contains": true,
		"GPLink": true,
		"AddAllowedToAct": true,
		"AllowedToAct": true,
		"SQLAdmin": true,
		"ReadGMSAPassword": true,
		"HasSIDHistory": true,
		"CanPSRemote": true,
		"SyncLAPSPassword": true,
		"AZAddMembers": true,
		"AZAddSecret": true,
		"AZAvereContributor": true,
		"AZContains": true,
		"AZContributor": true,
		"AZExecuteCommand": true,
		"AZGetCertificates": true,
		"AZGetKeys": true,
		"AZGetSecrets": true,
		"AZGlobalAdmin": true,
		"AZGrant": true,
		"AZGrantSelf": true,
		"AZHasRole": true,
		"AZMemberOf": true,
		"AZOwner": true,
		"AZOwns": true,
		"AZPrivilegedRoleAdmin": true,
		"AZResetPassword": true,
		"AZUserAccessAdministrator": true,
		"AZAppAdmin": true,
		"AZCloudAppAdmin": true,
		"AZRunsAs": true,
		"AZKeyVaultContributor": true,
		"AZVMAdminLogin": true,
		"AddSelf": true,
		"WriteSPN": true,
		"AddKeyCredentialLink": true
	},
	"databaseInfo": {
		"url": "bolt://localhost:7687",
		"user": "neo4j",
		"password": "123abc"
	}
}
EOF
chown -R kali:kali /home/kali/.config/bloodhound
chmod 700 /home/kali/.config/bloodhound
chmod 644 /home/kali/.config/bloodhound/config.json

# Install rclone
echo -e "${Green}===Install rclone===${Color_Off}"
apt -qq install -y rclone
# Configure rclone for root
mkdir -p /root/.config/rclone
cat <<EOF > /root/.config/rclone/rclone.conf
[dropbox]
type = dropbox
token = {"access_token":"$1","token_type":"bearer","expiry":"0001-01-01T00:00:00Z"}
EOF
# configure rclone for user
mkdir -p /home/kali/.config/rclone
cat <<EOF > /home/kali/.config/rclone/rclone.conf
[dropbox]
type = dropbox
token = {"access_token":"$1","token_type":"bearer","expiry":"0001-01-01T00:00:00Z"}
EOF
# Create Workspaces directory
mkdir /home/kali/Workspaces
# Create .mozilla directory
mkdir /home/kali/.mozilla
# sync from dropbox mr7641
# sync /var/www/html
rclone sync dropbox:/kali/html /var/www/html
# sync /home/kali/Workspaces
rclone sync dropbox:/kali/Workspaces /home/kali/Workspaces
# sync firefox
rclone sync dropbox:/kali/mozilla /home/kali/.mozilla
# change owner of Workspaces
chown -R kali:kali /home/kali/Workspaces
# change owner of .mozilla
chown -R kali:kali /home/kali/.mozilla
# copy and configure impacket script MyDomainRecon.py
cp /home/kali/Workspaces/OSEP/OSEP-Code/Reconnaissance/MyDomainRecon.py /usr/share/doc/python3-impacket/examples/MyDomainRecon.py
chmod 755 /usr/share/doc/python3-impacket/examples/MyDomainRecon.py
ln -s ../share/impacket/script /usr/bin/impacket-MyDomainRecon
# copy and config bloodhound custom queries
cp /home/kali/Workspaces/OSEP/OSEP-Code/Reconnaissance/BloodHound/customqueries.json /home/kali/.config/bloodhound/customqueries.json
chown kali:kali /home/kali/.config/bloodhound/customqueries.json
chmod 644 /home/kali/.config/bloodhound/customqueries.json
# copy configuration file
cp /home/kali/Workspaces/configfile/krb5.conf /etc/krb5.conf
cp /home/kali/Workspaces/configfile/hosts /etc/hosts
cp /home/kali/Workspaces/proxychains4.conf /etc/proxychains4.conf
