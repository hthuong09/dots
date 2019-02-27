# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
# Modified by Thuong Nguyen <thuongnguyen.net@gmail.com> for personal use
#

# Source module files.
source "${0:h}/external/zsh-autosuggestions.zsh" || return 1

#
# Highlighting
#

# Set highlight color, default 'fg=8'.
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

#
# Key bindings
#

# Control + Space to accept suggestion
bindkey '^ ' autosuggest-accept
