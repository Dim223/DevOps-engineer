#!/bin/bash

#Запуск скрипта: sudo ./gitclon.sh

#установка docker
# Add Docker's official GPG key:
apt update
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#Проверка установки
echo " "
docker -v
echo " "
read -p "Убедитесь в установке docker. Продолжить? (y/n) " -n 1 -r; echo; [[ $REPLY =~ ^[Yy]$ ]] || exit 1

####################################################################################################

apt update && apt install -y git
mkdir /opt/gitclone
git clone https://github.com/Dim223/shvirtd-example-python.git /opt/gitclone
cd /opt/gitclone
docker compose up -d

