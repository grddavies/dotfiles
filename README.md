# dotfiles

Selected dotfiles, managed with [chezmoi](https://www.chezmoi.io/)

## Supports OSs

- macOS
- linux

## Chezmoi

Secrets are stored in Bitwarden. Config uses
[rbw](https://github.com/doy/rbw) to read secrets from Bitwarden vault

### Features

- Manages [zsh packages](./home/.chezmoiexternal.toml.tmpl)
- Styles zsh prompt with [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Installs developer tooling for:

  - TypeScript/JavaScript
  - Python
  - Rust
  - Haskell

- Installs & configures programming tools:

  - Kitty Terminal
  - NeoVim
  - VSCode

- Installs Programming Fonts (Optional)
- Installs and configures [TidalCycles](https://tidalcycles.org/) LiveCoding Environment (Optional):
  - Installs and defines [MI-Ugens](https://github.com/v7b1/mi-UGens/)
  - Adds executable `startdirt` for starting SuperCollider server with custom config

## NeoVim Config

- Customised [LazyVim](https://www.lazyvim.org/) config
- See [here](./home/dot_config/nvim)
