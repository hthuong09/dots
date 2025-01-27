#!/usr/bin/env bash

# Mac OS preparation
prepare_macos() {
    # Exit if not macOS
    [[ "$OSTYPE" != "darwin"* ]] && return

    # Check if Xcode Command Line Tools are installed
    if ! xcode-select -p &> /dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install
        # Wait for installation to complete
        until xcode-select -p &> /dev/null; do
            sleep 5
        done
        echo "Xcode Command Line Tools installation completed"
    else
        echo "Xcode Command Line Tools already installed"
    fi

    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installation completed"
    else
        echo "Homebrew already installed"
    fi
}
install_yabai_indicator() {
  # Exit if not macOS
  [[ "$OSTYPE" != "darwin"* ]] && return

  # Download file to /tmp
  URL="https://github.com/xiamaz/YabaiIndicator/releases/download/0.3.4/YabaiIndicator-0.3.4.zip"
  TMP_DIR="/tmp"
  FILE_NAME="YabaiIndicator-0.3.4.zip"
  EXTRACT_DIR="$TMP_DIR/YabaiIndicator-0.3.4"
  DEST_DIR="/Applications"

  # check if application is already installed
  if [ -d "$DEST_DIR/YabaiIndicator.app" ]; then
    echo "YabaiIndicator is already installed!"
  else
    # Download the file
    curl -L $URL -o $TMP_DIR/$FILE_NAME

    # Check if download was successful
    if [ $? -ne 0 ]; then
      echo "Download failed!"
      exit 1
    fi

    # Extract the file
    unzip $TMP_DIR/$FILE_NAME -d $TMP_DIR

    # Check if extraction was successful
    if [ $? -ne 0 ]; then
      echo "Extraction failed!"
      exit 1
    fi

    # Copy the extracted contents to /Applications
    cp -R $EXTRACT_DIR/YabaiIndicator.app $DEST_DIR

    # Check if copy was successful
    if [ $? -ne 0 ]; then
      echo "Copy failed!"
      exit 1
    fi

    # Cleanup
    rm $TMP_DIR/$FILE_NAME
    rm -rf $EXTRACT_DIR
  fi
}
sync_secrets() {
  read -p "Do you want to sync secrets? (y/N) " answer
  if [[ $answer =~ ^[Yy]$ ]]; then
    sync-secrets from
  fi
}
prepare_dotfiles() {
  # Check if dotfiles are already installed
  if [ -d "$HOME/.gdots" ]; then
    echo "Dotfiles are already installed!"
  else
    echo "Installing dotfiles..."
    
    # Clone dotfiles repository
    git clone --recursive --separate-git-dir=$HOME/.gdots https://github.com/hthuong09/dots /tmp/dots
    
    # Sync files to home directory
    # -r, --recursive             recurse into directories
    # -v, --verbose               increase verbosity
    # -l, --links                 When symlinks are encountered, recreate the symlink on the destination.
    rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
    
    # Cleanup temp files
    rm -rf /tmp/dots
    
    # Initialize submodules
    git --git-dir=$HOME/.gdots/ --work-tree=$HOME submodule update --init --recursive $HOME/

    # Reverse to using ssh
    git --git-dir=$HOME/.gdots/ --work-tree=$HOME remote set-url origin git@github.com:hthuong09/dots.git
    
    echo "Dotfiles installation complete! Please restart your terminal to use the new dotfiles."
  fi
}

prepare_nix() {
    # Check if Nix is installed
    if ! command -v nix &> /dev/null; then
        echo "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install)
        echo "Nix installation completed. Please restart your terminal to start using Nix."
        exit 0
    else
        echo "Nix already installed"
    fi
}

prepare_macos
prepare_dotfiles
prepare_nix
install_yabai_indicator
nix run nix-darwin -- switch --flake ~/hthuong09/nix-flake
sync_secrets
