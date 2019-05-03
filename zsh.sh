# Install Zsh
echo "y" | sudo apt install git-core zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# sudo usermod -s "$(command -v zsh)" "${USER}"
chsh -s "$(command -v zsh)" # Switch shell from bash to zsh

# Remove no longer required packages
echo "y" | sudo apt autoremove
