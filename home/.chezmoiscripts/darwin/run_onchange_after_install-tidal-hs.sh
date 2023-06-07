#!/bin/bash

echo "Installing tidal..."
cabal update
cabal v1-install tidal
