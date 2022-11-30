#!/bin/sh
if [ ! -d ~/.ghcup ]; then
    # Get ghcup installer
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi
