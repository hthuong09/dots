# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${0:h}/external/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${0:h}/external/shell/key-bindings.zsh" || return 1

# export FZF_DEFAULT_OPTS="--layout=reverse"
