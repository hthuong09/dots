{ pkgs, ... }:
{

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  programs.zsh.enable = true;
  homebrew.enable = true;
  homebrew.global.autoUpdate = false;
  homebrew.taps = [ "wez/wezterm" ];
  homebrew.casks = [ "wez/wezterm/wezterm" ];

  nix.package = pkgs.nix;
}
