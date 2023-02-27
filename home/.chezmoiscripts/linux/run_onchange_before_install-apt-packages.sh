#!/bin/sh

echo "Installing apt packages..."

# Notion-Enhanced source
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list

sudo apt-get update -qq && sudo apt-get upgrade -qq

sudo apt-get install -qq \
    curl \
    exa \
    llvm \
    neofetch \
    nmap \
    jq \
    wget \
    xclip \
    notion-app \

