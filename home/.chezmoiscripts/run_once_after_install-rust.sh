#!/bin/sh
if [ ! -d ~/.rustup ]; then
    # Get rustup installer
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
