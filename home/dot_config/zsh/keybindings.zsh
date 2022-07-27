# Jump fwd/backward words
# alt+arrows
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3A" beginning-of-line
bindkey "^[[1;3B" end-of-line

# Remove alt+l defaults to make way for kitty keybind to toggle font ligatures
bindkey -r "^[l"
bindkey -r "^[L"
