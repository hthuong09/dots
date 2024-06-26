{ config, pkgs, lib, ... }:
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
    postman
    obsidian
    nodejs
    awscli2
    fzf
    fd
    bat
    fluxcd
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
}

