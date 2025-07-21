#!/bin/bash

set -euo pipefail

echo "Changing shell..."
# Add the homebrew shell to list of allowed shells
sudo sh -c "echo \"$(brew --prefix)/bin/zsh\" >> /etc/shells"
# Change shell
sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"
# Try symlink to the installed version
if [[ ! -f /usr/bin/zsh ]]; then
  sudo ln -s "$(brew --prefix)/bin/zsh" /usr/bin/zsh || echo "Could not link homebrew zsh to /usr/bin/zsh"
fi
