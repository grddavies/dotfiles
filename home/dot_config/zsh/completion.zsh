#!/usr/bin/env zsh

zmodload zsh/complist

# Add completions for brew pkgs
if [[ `command -v brew` ]]; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

fpath=(${ASDF_DIR}/completions $fpath)
fpath=(${ZDOTDIR}/completions $fpath)
fpath=(${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh-completions/src $fpath)

autoload -Uz compinit && compinit

# Set completers
zstyle ':completion:*' completer _extensions _complete _approximate

