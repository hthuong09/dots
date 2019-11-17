export NVM_DIR="$HOME/.nvm"
if [[ -f "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
else
    echo "NVM does not exist, do you want to setup nvm?"
fi
