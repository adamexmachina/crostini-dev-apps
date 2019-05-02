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
sudo docker run hello-world

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

