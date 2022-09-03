export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm_latest_release_tag() {
  echo $(builtin cd "$NVM_DIR" && git fetch --quiet --tags origin && git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
}

nvm_install () {
  echo "Installing nvm..."
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  $(builtin cd "$NVM_DIR" && git checkout --quiet "$(nvm_latest_release_tag)")
}
