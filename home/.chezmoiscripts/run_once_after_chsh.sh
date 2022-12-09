#!/bin/bash

set -eufo pipefail

echo "Changing shell..."
# Add the homebrew shell to list of allowed shells
sudo sh -c "echo \"$(brew --prefix)/bin/zsh\" >> /etc/shells"
# Change shell
sudo chsh -s "$(brew --prefix)/bin/zsh" $USER
# Symlink to the installed version
sudo ln -s "$(brew --prefix)/bin/zsh" /usr/bin/zsh
