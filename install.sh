#! /bin/bash
#
# Description:
#   Installs web development tools in the Chromebook linux container.
# Use:
#   sudo ./install.sh

main(){

# Description:
#   Compile a full-featured Vim from source on Ubuntu/Debian distros. Based
#   entirely on
#   https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

sudo apt update
echo "y" | sudo apt upgrade

echo "y" | sudo apt-get remove \
  vim \
  vim-runtime \
  gvim \
  vim-tiny \
  vim-common \
  vim-gui-common

echo "y" | sudo apt install \
  libncurses5-dev \
  libgnome2-dev \
  libgnomeui-dev \
  libgtk2.0-dev \
  libatk1.0-dev \
  libbonoboui2-dev \
  libcairo2-dev \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  python-dev \
  python3-dev \
  ruby-dev \
  libperl-dev \
  git

cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-python3interp \
  --with-python-config-dir=/usr/lib/python3.5/config \
  --enable-perlinterp \
  --enable-gui=auto \
  --enable-cscope \
  --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/share/vim/vim81
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
vim --version


# Install Powerline Fonts
sudo apt-get install fonts-powerline

# Add vimrc
cd ~ 
wget https://raw.githubusercontent.com/adamexmachina/dotfiles/master/vimrc
mv ~/vimrc ~/.vimrc

# Install Chromium
echo "y" | sudo apt install chromium

# Install Firefox
echo "y" | sudo apt install firefox-esr

# Install Filezilla
wget https://dl1.cdn.filezilla-project.org/client/FileZilla_3.41.2_x86_64-linux-gnu.tar.bz2?h=BFj_PnBcG8St2Y9mlX-XSQ&x=1556747020
tar -xjvf https://dl1.cdn.filezilla-project.org/client/FileZilla_3.41.2_x86_64-linux-gnu.tar.bz2
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
sudo apt install gnome-terminal

# Install Apache
sudo apt install apache2 apache2-utils
sudo systemctl enable apache2
sudo apache2 -v

# Install MariaDB
sudo apt install mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo mysql_secure_installation

# Install PHP
sudo apt install php7.0 nano libapache2-mod-php7.0 php7.0-mysql php-common php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readlin
sudo a2enmod php7.0
sudo systemctl restart apache2

# Install Exuberant Ctags for YouCompleteMe
sudo apt install exuberant-ctags

# Open vim to install plugins
vim || return

# Run YouCompleteMe installation process
sudo apt install build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --ts-completer

# Install Zsh
sudo apt install git-core zsh

# Remove no longer required packages
sudo apt autoremove

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo usermod -s "$(command -v zsh)" "${USER}"
chsh -s "$(command -v zsh)" # Switch shell from bash to zsh
}

main
