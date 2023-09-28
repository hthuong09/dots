fpath=("${0:h}/themes" "${0:h}/pure" $fpath)
# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

PURE_PROMPT_SYMBOL='─── ─'
PURE_PROMPT_VICMD_SYMBOL='─ ───'
RPROMPT=''
zstyle :prompt:pure:prompt:success color 008
zstyle :prompt:pure:path color 008

# Load the prompt theme.
prompt "pure"

