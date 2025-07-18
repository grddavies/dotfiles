#!/bin/sh

echo "Installing apt packages..."

sudo apt-get update -qq && sudo apt-get upgrade -qq

sudo apt-get install -qq \
  curl \
  jq \
  llvm \
  neofetch \
  nmap \
  wget \
  xclip
