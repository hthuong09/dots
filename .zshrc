# Check if .zsh dir exist
if [ ! -d ~/.zsh ]; then
    print ".zsh directory does not exist"
    return 1
fi

# Define list of module going to be used
ZSH_MODULES=(
    editor
    completion
    history
    history-substring-search
    autosuggestions
    directory
    prompt
    alias
    syntax-highlighting
    z
#    tmux
#    nvm
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
export PATH="$HOME/.shopbash/bin:$PATH"
eval "$(shopbash init -)"
