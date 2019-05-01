#! /bin/bash
#
# Description:
#   Install all chromebook linux container apps
# Use:
#   ./install.sh

main(){

# Description:
#   Compile a full-featured Vim from source on Ubuntu/Debian distros. Based
#   entirely on
#   https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source

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
    lua5.1 \
    liblua5.1-dev \
    libperl-dev \
    git

	cd ~
	hg clone https://github.com/vim/vim.git
	cd vim
	./configure --with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp \
		--enable-python3interp \
		--with-python-config-dir=/usr/lib/python3.5/config \
		--enable-perlinterp \
		--enable-gui=gtk2 \
		--enable-cscope \
		--prefix=/usr/local
	make VIMRUNTIMEDIR=/usr/share/vim/vim81
	sudo make install
  sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  sudo update-alternatives --set editor /usr/local/bin/vim
  sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  sudo update-alternatives --set vi /usr/local/bin/vim
  vim --version
}

main
