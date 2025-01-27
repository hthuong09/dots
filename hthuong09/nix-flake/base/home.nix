{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.stateVersion = "22.05";

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
    python3
    docker-compose
    kubernetes-helm
    ripgrep
    fd
    jq
    unixtools.watch
    eza
    kubectl
    k9s
    kn
    ranger
    docker-client
    delta
    # postman
    # obsidian
    nodejs
    awscli2
    fzf
    fd
    bat
    fluxcd
    bun
    rm-improved
    gh
    zoxide
    # utilities
    # https://dev.to/lissy93/cli-tools-you-cant-live-without-57f6
    # thefuck - Auto-correct miss-typed commands - unable to find use case yet

    (writeShellScriptBin "sync-secrets" ''
      #!/usr/bin/env bash
      
      # Function to sync from 1Password to local file
      sync_from_1password() {
        echo "Syncing secrets from 1Password to local file..."
        op item get "Environment Variables" --format json | \
          jq -r '.fields[] | select(.label == "note").value' > ~/.secret-environments
        chmod 600 ~/.secret-environments
        echo "Secrets synced from 1Password successfully!"
      }

      # Function to sync from local file to 1Password
      sync_to_1password() {
        echo "Syncing secrets from local file to 1Password..."
        op item edit "Environment Variables" "note[text]=$(cat ~/.secret-environments)"
        echo "Secrets synced to 1Password successfully!"
      }

      # Parse command line arguments
      case "$1" in
        "from")
          sync_from_1password
          ;;
        "to")
          sync_to_1password
          ;;
        *)
          echo "Usage: sync-secrets [from|to]"
          echo "  from: sync from 1Password to local file"
          echo "  to: sync from local file to 1Password"
          exit 1
          ;;
      esac
    '')
  ];

  programs.starship = {
    enable = false;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.sessionVariables = {
    OP_ACCOUNT = "my";
  };
}
