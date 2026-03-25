#!/bin/sh

if ! command -v claude >/dev/null 2>&1; then
  # Install claude code
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi

if ! command -v claude-agent-acp >/dev/null 2>&1; then
  echo "Installing Claude Agent ACP..."
  if ! command -v node >/dev/null 2>&1; then
    echo "[WARN] Node.js is required to install claude-agent-acp"
    echo "once installed, run:"
    echo "npm install -g @zed-industries/claude-agent-acp"
  else
    npm install -g @zed-industries/claude-agent-acp
  fi
fi
