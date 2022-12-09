#!/bin/sh

echo "Installing apt packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-get install \
    curl \
    exa \
    llvm \
    neofetch \
    nmap \
    wget \
    xclip \
