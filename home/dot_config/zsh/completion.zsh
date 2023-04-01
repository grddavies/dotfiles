#!/usr/bin/env zsh

zmodload zsh/complist

# Add completions for brew pkgs
if [[ `command -v brew` ]]; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit; compinit

# Set completers
zstyle ':completion:*' completer _extensions _complete _approximate

