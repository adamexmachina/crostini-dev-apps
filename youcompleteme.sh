#!/bin/bash

# Run YouCompleteMe installation process
# bash youcompleteme.sh
echo "y" | sudo apt install build-essential cmake python3-dev
cd ~
cd .vim/bundle/YouCompleteMe
sudo ./install.py --clang-completer --ts-completer
