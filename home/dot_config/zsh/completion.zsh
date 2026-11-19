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
    local args="$*"
    # Picker for resuming previous sessions from anywhere
    if [[ " $args " == *" "(--resume|-r)" "* ]]; then
        local claude_dir=${CLAUDE_CONFIG_DIR:-$HOME/.claude}
        local result session_id project titles
        # history.jsonl only holds prompts; session titles live in the
        # transcripts as ai-title / custom-title records (custom wins)
        titles=$(rg --no-filename --no-line-number -g '*.jsonl' \
                '"type":"(ai|custom)-title"' "$claude_dir/projects" 2>/dev/null \
            | jq -s 'reduce .[] as $r ({};
                    .[$r.sessionId] |= if $r.customTitle then {c: $r.customTitle} + . else . + {a: $r.aiTitle} end)
                | map_values(.c // .a)' 2>/dev/null)
        result=$(jq -r -s --argjson titles "${titles:-{\}}" '
            def pad($n): if length > $n then .[0:$n-1] + "…" else . + (" " * ($n - length)) end;
            group_by(.sessionId)
            | map(max_by(.timestamp))
            | sort_by(-.timestamp)
            | .[]
            | ($titles[.sessionId] // (.display // "" | gsub("\\s+"; " "))) as $title
            | (.project | sub("^" + env.HOME; "~")) as $proj
            | (.timestamp / 1000 | localtime | strftime("%Y-%m-%d %H:%M")) as $dt
            | [.sessionId, .project,
               "\($title | pad(60))  \u001b[34m\($proj | pad(40))\u001b[0m  \u001b[33m\($dt)\u001b[0m  \u001b[90m\(.sessionId[0:8])\u001b[0m"]
            | @tsv
        ' "$claude_dir/history.jsonl" | fzf --ansi --reverse \
            --header='Select session to resume' \
            --delimiter=$'\t' \
            --with-nth=3 \
            --preview="jq -r --arg s {1} 'select(.sessionId == \$s) | \"› \" + .display' ${(q)claude_dir}/history.jsonl | tail -n 50" \
            --preview-window=down:40%:wrap)
        [[ -z "$result" ]] && return
        session_id=${result%%$'\t'*}
        project=${${result#*$'\t'}%%$'\t'*}
        BUFFER="cd ${(q)project} && claude --resume ${session_id}"
        zle end-of-line
        zle reset-prompt
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}
