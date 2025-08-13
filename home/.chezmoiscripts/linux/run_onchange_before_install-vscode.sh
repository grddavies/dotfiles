#!/usr/bin/env bash

set -euo pipefail

VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
TEMP_DEB="/tmp/vscode.deb"

# Check if VS Code is already installed
if command -v code >/dev/null 2>&1; then
  echo "VS Code is already installed. Skipping installation."
  exit 0
fi

echo "VS Code not found. Downloading and installing..."

# Install the apt repository and signing key
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

# Download the .deb file only if it doesn't exist or is incomplete
if [[ ! -f "$TEMP_DEB" ]] || ! dpkg --info "$TEMP_DEB" >/dev/null 2>&1; then
  echo "Downloading VS Code..."
  curl -L "$VSCODE_URL" -o "$TEMP_DEB"
fi

# Install the .deb package
echo "Installing VS Code..."
sudo apt install "$TEMP_DEB"

# Clean up
rm -f "$TEMP_DEB"

echo "VS Code installation completed successfully!"
