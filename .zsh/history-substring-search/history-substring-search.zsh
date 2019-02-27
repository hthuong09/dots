#
# Integrates history-substring-search into Prezto.
#
# Authors:
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
# Modified by Thuong Nguyen <thuongnguyen.net@gmail.com> for personal use
#

# Source module files.
source "${0:h}/external/zsh-history-substring-search.zsh" || return 1

#
# Styles
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
# for case sensitive
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i//ii'

#
# Key Bindings
#

# The terminal must be in application mode when ZLE is active for $terminfo
# values to be valid.
if (( $+terminfo[smkx] )); then
  # Enable terminal application mode.
  echoti smkx
fi

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
