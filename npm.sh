# Install nodejs and npm
cd ~
wget https://nodejs.org/dist/v10.15.3/node-v10.15.3-linux-x64.tar.xz
tar -xf node-v10.15.3-linux-x64.tar.xz
cd node-v10.15.3-linux-x64
cd bin
sudo cp node /usr/local/bin
node -v
cd ..
cd lib/node_modules/npm/scripts
sudo sh install.sh
npm -v
