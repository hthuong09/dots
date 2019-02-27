fpath=("${0:h}/themes" $fpath)
# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
prompt "minimal"

