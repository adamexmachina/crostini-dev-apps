#!/bin/bash
#
# Description:
#   Build and install all web development tools needed for the Chromebook Linux container
# Use:
#   bash install.sh
#
set -x #echo on

# Update and Upgrade
echo "y" | sudo apt update && sudo apt upgrade

#Install Git
echo "y" | sudo apt install git

# Install Powerline Fonts
echo "y" | sudo apt-get install fonts-powerline

# Install Chromium
echo "y" | sudo apt install chromium
sudo printf '[Desktop Entry]\nName=Chromium\nComment=Web Browser\nGenericName=Web Browser\nTryExec=chromium\nVersion=1.0\nExec=chromium\nMimeType=text/plain\nCategories=Browser;\nTerminal=false\nType=Application\nIcon=chromium\nStartupNotify=true\n' > $HOME/.local/share/applications/chromium.desktop

# Install Firefox
echo "y" | sudo apt install firefox-esr

# Install Filezilla
echo "y" | sudo apt install filezilla

# Install GitKraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
echo "y" | sudo apt --fix-broken install

# Install DBeaver
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
echo "y" | sudo apt --fix-broken install

#Install Kitty Terminal Emulator
echo "y" | sudo apt install kitty

# Install Zsh
echo "y" | sudo apt install git-core zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# sudo usermod -s "$(command -v zsh)" "${USER}"
chsh -s "$(command -v zsh)" # Switch shell from bash to zsh

#Install Vim
echo "y" | sudo apt install vim

# Install Docker
sudo apt remove docker docker-engine docker.io containerd runc
echo "y" | sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
echo "y" | sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#Install Homebrew Linux
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

#Install DDEV Local
brew tap drud/ddev && brew install ddev

# Remove no longer required packages
echo "y" | sudo apt autoremove


