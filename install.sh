#!/bin/bash
#
# Description:
#   Build and install all web development tools needed for the Chromebook Linux container
# Use:
#   bash install.sh
#
set -x #echo on

# Install Vim
. vim.sh

# Install nodejs, npm, docker, docker-compose
. docker.sh

# Install Powerline Fonts
sudo apt-get install fonts-powerline

# Install Chromium
echo "y" | sudo apt install chromium

# Install Firefox
echo "y" | sudo apt install firefox-esr

# Install Filezilla
wget https://dl1.cdn.filezilla-project.org/client/FileZilla_3.41.2_x86_64-linux-gnu.tar.bz2?h=BFj_PnBcG8St2Y9mlX-XSQ&x=1556747020
tar -xjvf FileZilla_3.41.2_x86_64-linux-gnu.tar.bz2
sudo rm -rf /opt/filezilla*
sudo mv ./**FileZilla** /opt/**filezilla3**
sudo ln -sf /opt/**filezilla3**/bin/filezilla /usr/bin/filezilla

# Install GitKraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo dpkg -i gitkraken-amd64.deb
echo "y" | sudo apt --fix-broken install

# Install DBeaver
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
echo "y" | sudo apt --fix-broken install

# Install Gnome Terminal
echo "y" | sudo apt install gnome-terminal
sudo printf '[Desktop Entry]\nName=Gnome Terminal\nComment=Terminal Emulator\nGenericName=Terminal Emulator\nTryExec=gnome-terminal\nVersion=1.0\nExec=gnome-terminal\nMimeType=text/plain\nCategories=Utility;\nTerminal=false\nType=Application\nIcon=terminal\nStartupNotify=true\n' > $HOME/.local/share/applications/gnome-terminal.desktop

# Install Apache
echo "y" | sudo apt install apache2 apache2-utils
sudo systemctl enable apache2
sudo apache2 -v

# Install MariaDB
echo "y" | sudo apt install mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo mysql_secure_installation

# Install PHP
echo "y" | sudo apt install php7.0 nano libapache2-mod-php7.0 php7.0-mysql php-common php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readlin
sudo a2enmod php7.0
sudo systemctl restart apache2

# Install Zsh
echo "y" | sudo apt install git-core zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo usermod -s "$(command -v zsh)" "${USER}"
# chsh -s "$(command -v zsh)" # Switch shell from bash to zsh

# Remove no longer required packages
echo "y" | sudo apt autoremove
