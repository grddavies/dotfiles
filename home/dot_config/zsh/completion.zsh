#!/usr/bin/env zsh

zmodload zsh/complist

# Add completions for brew pkgs
if [[ `command -v brew` ]]; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

fpath=(${ZDOTDIR}/completions $fpath)
fpath=(${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh-completions/src $fpath)

autoload -Uz compinit && compinit

# Set completers
zstyle ':completion:*' completer _extensions _complete _approximate

_fzf_complete_claude() {
    ARGS="$@"
    # Picker for resuming previous sessions from anywhere
    if [[ "$ARGS" == *"--resume"* ]]; then
        local result session_id project
        result=$(jq -r -s '
            group_by(.sessionId)
            | map(max_by(.timestamp))
            | sort_by(-.timestamp)
            | .[]
            | (.timestamp / 1000 | todate | .[0:16] | gsub("T"; " ")) as $dt
            | (.sessionId[0:8]) as $short
            | (.project | gsub(env.HOME; "~")) as $proj
            | (.display // "" | gsub("\n"; " ") | .[0:80]) as $prev
            | "\(.sessionId)\t\(.project)\t\($dt)  \($short)  \($proj)  \($prev)"
        ' ~/.claude/history.jsonl | fzf --ansi --reverse \
            --header='Select session to resume' \
            --delimiter=$'\t' \
            --with-nth=3 \
            --preview='echo {3}' \
            --preview-window=down:3:wrap)
        [[ -z "$result" ]] && return
        session_id=$(cut -f1 <<< "$result")
        project=$(cut -f2 <<< "$result")
        BUFFER="cd ${project} && claude --resume ${session_id}"
        zle end-of-line
        zle reset-prompt
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}
