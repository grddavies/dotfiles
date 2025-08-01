#!/bin/bash

set -euo pipefail

if [[ $(command -v kitty) ]]; then
  exit 0
fi

# Kitty terminal installer
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Add desktop file (https://sw.kovidgoyal.net/kitty/binary/#desktop-integration-on-linux)
# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/

# Copy the icon to the icons directory
cp ~/.config/kitty/kitty.app.png /usr/share/icons/hicolor/256x256/apps/kitty.png

# Update the paths to kitty binary and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/usr/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/kitty.app/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/kitty.app/share/applications/kitty*.desktop
# Install the kitty desktop file
sudo desktop-file-install ~/.local/kitty.app/share/applications/kitty.desktop
# # If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
# # sudo desktop-file-install ~/.local/kitty.app/share/applications/kitty-open.desktop
