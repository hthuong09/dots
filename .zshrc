if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi
# Check if .zsh dir exist
if [ ! -d ~/.zsh ]; then
    print ".zsh directory does not exist"
    return 1
fi

# Define list of module going to be used
ZSH_MODULES=(
    # starship
    prompt
    editor
    fzf
    fzf-tab
    completion
    history
    history-substring-search
    autosuggestions
    directory
    alias
    syntax-highlighting
    # z
    # tmux
    zoxide
    nvm
    gh
)
for module in $ZSH_MODULES; do
    # Check if module directory exist before loading *.zsh files
    if [ ! -d ~/.zsh/$module ]; then
        print "Cannot load module $module. Directory does not exist."
        continue
    fi
    # Modifier (.N) help ZSH to not return an error if no .zsh file is found
    for config in ~/.zsh/$module/*.zsh(.N); do source $config; done;
done
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

if [[ -n $CURSOR_TRACE_ID ]]; then
  PROMPT_EOL_MARK=""
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  precmd() { print -Pn "\e]133;D;%?\a" }
  preexec() { print -Pn "\e]133;C;\a" }
fi

