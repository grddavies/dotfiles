eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude Library"

_FZF_PREVIEW_DIR="eza --tree --level 1 --color=always {} | head -200"
_FZF_PREVIEW_FILE="bat -n --color=always --line-range :500 {}"
_FZF_PREVIEW_CONDITIONAL="([ -d {} ] && $_FZF_PREVIEW_DIR) || (head -c 1024 {} | rg -q $'\0' && file -b {}) || ([ -f {} ] && $_FZF_PREVIEW_FILE)"

# Use fd to list path completion candidates
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}

# Use fd to list dir completion candidates
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CONDITIONAL'"

# cd with alt+c
# Needs export for use in transform subshell script below
export _FD_DIR_BASE_CMD="fd --type d --follow --exclude Library"
export FZF_ALT_C_COMMAND="$_FD_DIR_BASE_CMD"
export FZF_ALT_C_OPTS="
  --preview '$_FZF_PREVIEW_DIR'
  --header 'alt-h: toggle hidden | alt-i: toggle ignored'
  --bind 'alt-h:transform:zsh ${ZDOTDIR}/funcs/_fzf_alt_c_transform hidden'
  --bind 'alt-i:transform:zsh ${ZDOTDIR}/funcs/_fzf_alt_c_transform ignored'
"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "$_FZF_PREVIEW_DIR" "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    git)
                  if [[ $LBUFFER == *"git switch"* ]]; then
                    (git branch --format='%(refname:short)' --sort=-committerdate) | \
                      rg -v "^$(git branch --show-current 2>/dev/null)$" | \
                      fzf --preview 'git log --oneline --graph --date=short {}' "$@"
                  fi
                  ;;
    *)            fzf --preview "$_FZF_PREVIEW_CONDITIONAL" "$@" ;;
  esac
}

