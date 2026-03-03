#!/bin/sh

if ! command -v claude >/dev/null 2>&1; then
  # Install claude code
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi
