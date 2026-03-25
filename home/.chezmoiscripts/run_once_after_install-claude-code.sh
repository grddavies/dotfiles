#!/bin/sh

safe_source() {
  if [ -f "$1" ]; then
    # shellcheck source=/dev/null
    . "$1"
  else
    echo "File '$1' not found, skipping."
  fi
}

safe_source "$HOME/.profile"

if ! command -v claude >/dev/null 2>&1; then
  # Install claude code
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi
