#!/bin/sh

echo "Installing apt apps..."

sudo apt-get update -qq && sudo apt-get upgrade -qq

sudo apt-get install -qq \
  flameshot
