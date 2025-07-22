#!/bin/bash
# install rclone without brew, as it cannot use mount command with brew

if ! command -v rclone >/dev/null 2>&1; then
	echo "Installing rclone..."
	sudo -v
	curl https://rclone.org/install.sh | sudo bash
fi
