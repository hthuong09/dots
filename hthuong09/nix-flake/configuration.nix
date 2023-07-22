{ pkgs, ... }:
{

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.zoxide
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  services.karabiner-elements.enable = true;
  programs.zsh.enable = true;
  homebrew.enable = true;
  homebrew.onActivation.upgrade = true;
  homebrew.global.autoUpdate = false;
  homebrew.taps = [ "wez/wezterm" ];
  homebrew.casks = [
    {
      name = "wez/wezterm/wezterm";
      greedy = true;
    }
    "slack"
    "hammerspoon"
    "raycast"
    "tableplus"
    "openkey"
  ];
  homebrew.masApps = {
    Messenger = 1480068668;
    RunCat = 1429033973;
  };
  # TODO: add fira code font
  # fonts.fontDir.enable = true;
  # fonts.fonts = [];
  security.pam.enableSudoTouchIdAuth = true;

  nix.package = pkgs.nix;
}
