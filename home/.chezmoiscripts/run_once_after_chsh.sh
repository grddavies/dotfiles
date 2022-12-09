#!/bin/sh

set -eufo pipefail

echo "Changing shell..."
sudo sh -c "echo \"$(brew --prefix)/bin/zsh\" >> /etc/shells"
chsh -s "$(brew --prefix)/bin/zsh"
