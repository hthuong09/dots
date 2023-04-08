{ config, pkgs, lib, ... }:
{
  home.stateVersion = "22.05";

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
    wezterm
    postman
    vscode
    obsidian
    dbeaver
    slack
  ];
}

