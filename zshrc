bindkey -v
bindkey -M viins '^?' backward-delete-char

export KEYTIMEOUT=1
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[3 q'
  fi
}
zle -N zle-keymap-select

preexec() {
  echo -ne '\e[2 q'
}

zle-line-init() { echo -ne '\e[3 q'; }
zle -N zle-line-init

export TMUX_STATUS_BG_COLOR="magenta"
export TMUX_STATUS_FG_COLOR="white"
export TMUX_ACTIVE_BG_COLOR="cyan"
export TMUX_ACTIVE_FG_COLOR="black"

# Fast git branch/commit for prompt (avoids slow vcs_info)
_git_prompt() {
    local ref
    ref=$(git symbolic-ref --short HEAD 2>/dev/null) || \
        ref=$(git rev-parse --short HEAD 2>/dev/null) || return
    echo " %F{yellow}($ref)%f"
}

setopt PROMPT_SUBST
PROMPT='[%D{%H:%M}] 🏠 %F{magenta}%f %F{blue}%~%f$(_git_prompt) $ '
