eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

_FZF_PREVIEW_DIR="eza --tree --color=always {} | head -200"
_FZF_PREVIEW_FILE="bat -n --color=always --line-range :500 {}"
_FZF_PREVIEW_CONDITIONAL="[ -d {} ] && $_FZF_PREVIEW_DIR || $_FZF_PREVIEW_FILE"

# Use fd to list path completion candidates
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}

# Use fd to list dir completion candidates
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CONDITIONAL'"
export FZF_ALT_C_OPTS="--preview '$_FZF_PREVIEW_DIR'"

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
    *)            fzf --preview "$_FZF_PREVIEW_CONDITIONAL" "$@" ;;
  esac
}
