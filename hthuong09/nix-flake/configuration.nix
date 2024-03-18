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
  # services.karabiner-elements.enable = true;
  programs.zsh.enable = true;
  homebrew.enable = true;
  homebrew.onActivation.upgrade = true;
  homebrew.global.autoUpdate = true;
  homebrew.taps = [ "wez/wezterm" "koekeishiya/formulae" ];
  homebrew.casks = [
    {
      name = "wez/wezterm/wezterm";
      greedy = true;
    }
    {
      # move to yabai service: https://github.com/LnL7/nix-darwin/blob/master/modules/services/yabai/default.nix
      name = "koekeishiya/formulae/yabai";
      greedy = true;
    }
    "slack"
    "hammerspoon"
    "raycast"
    "tableplus"
    "openkey"
    "spaceman"
    "karabiner-elements"
    "arc"
    "postman"
    "obsidian"
    "dbeaver-community"
    "visual-studio-code"
    "gpg-suite-no-mail"
    "contexts"
    "cloudflare-warp"
    "postman"
    "txn2/tap/kubefwd"
  ];
  homebrew.masApps = {
    Messenger = 1480068668;
    RunCat = 1429033973;
  };
  # TODO: add fira code font
  # fonts.fontDir.enable = true;
  # fonts.fonts = [];
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
    };
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = true;
    };
  };

  nix.package = pkgs.nix;
}
