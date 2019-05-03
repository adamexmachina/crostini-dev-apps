ln -sf $PWD/vimrc $HOME/.vimrc

echo "y" | sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev ruby-dev git vim-gtk

echo "y" | sudo apt remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox

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

sudo printf '[Desktop Entry]\n Name=GVim\n GenericName=Text Editor\n Comment=Edit text files\n TryExec=gvim\n Exec=gvim -f %%F\n Terminal=fals%e Type=Application\n Icon=gvim\n Categories=Utility;TextEditor;\n StartupNotify=true\n MimeType=text/plain;' > $HOME/gvim.desktop

cd $HOME
sudo desktop-file-install gvim.desktop

gvim || return # Open vim to install plugins
