rm $HOME/.vimrc
ln -s $PWD/vimrc $HOME/.vimrc

echo "y" | sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev ruby-dev git build-dep vim-gtk

sudo apt remove vi vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox

cd $HOME

git clone https://github.com/vim/vim.git

cd $HOME/vim

./configure --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib/python3.5/config \
  --enable-perlinterp=yes \
  --enable-gui=gtk2 \
  --enable-cscope \
  --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

cd $HOME/vim
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

mkdir -p $HOME/.local/share/applications/
mkdir -p $HOME/.local/share/icons/

sudo printf '[Desktop Entry]\nName=Gvim\nComment=Edit text files\nGenericName=Text Editor\nTryExec=gvim\nVersion=1.0\nExec=gvim -f %%F\nMimeType=text/plain\nCategories=Utility;TextEditor\nTerminal=false\nType=Application\nIcon=~/.local/share/icons/gvim.png\nStartupNotify=true\n' > $HOME/.local/share/applications/gvim.desktop

vim --version
