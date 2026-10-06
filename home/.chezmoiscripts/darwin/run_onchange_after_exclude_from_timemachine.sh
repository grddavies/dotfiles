#!/usr/bin/env bash
set -euo pipefail

# Ignore paths from Time Machine backups

paths=(
  "$HOME/.cache"
  "$HOME/.ghcup"
  "$HOME/.stack"
  "$HOME/.cabal"
  "$HOME/.cargo"
  "$HOME/.rustup"
  "$HOME/.npm"
  "$HOME/.ollama"
)

for p in "${paths[@]}"; do
  if [[ -e "$p" ]]; then
    tmutil addexclusion "$p"
  fi
done
