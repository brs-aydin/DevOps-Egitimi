#!/bin/bash
sudo apt-get update
sudo ufw disable
	sudo apt-get install \
	ca-certificates \
	curl \
	gnupg \
	lsb-release -y	
#docker ve docker-compose kurulumu	
echo "docker ve docker-compose kurulumu yapılıyor"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose


#Hostname değişikliği
echo "Hostname değişikliği yapılıyor"
sudo hostnamectl set-hostname technowl-docker

# sshd_config dosyası değişikliği
echo "sshd_config dosyası tekrar yapılandırılıyor."
sudo sed -i 's^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl reload sshd

#Araçların kurulumu
echo "Araçlar yükleniyor"
sudo apt update
sudo apt install net-tools curl wget -y
sudo apt install ufw fail2ban htop nmap -y
sudo apt install openssh-server -y

#Docker imajını çalıştırma
echo "rd-helloworld imajı çalıştırılıyor"
docker run -d -p 7000:7000 onuromertunc/rd-helloworld:671