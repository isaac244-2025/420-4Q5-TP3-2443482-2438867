#!/bin/bash

set -e

echo "MaJ apt"
sudo apt update && sudo apt upgrade -y

echo "DÉPENDANCES"
sudo apt install -y \
    ca-certificates \
    curl \
    git \
    rsync \
    openssh-server

echo "Clé GPG Docker"
sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL \
https://download.docker.com/linux/ubuntu/gpg \
-o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Dépôt Docker"

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "Installation Docker"

sudo apt update

sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin


sudo systemctl enable docker
sudo systemctl start docker


sudo usermod -aG docker $USER



docker --version
docker compose version