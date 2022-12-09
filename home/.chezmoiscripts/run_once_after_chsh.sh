#!/bin/bash

set -eufo pipefail

echo "Changing shell..."
sudo sh -c "echo \"$(brew --prefix)/bin/zsh\" >> /etc/shells"
sudo chsh -s "$(brew --prefix)/bin/zsh" $USER
