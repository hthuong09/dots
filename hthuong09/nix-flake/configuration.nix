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

  # services.yabai = {
  #   enable = true;
  # };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;
  programs.zsh.enable = true;
  homebrew.enable = true;
  homebrew.onActivation.upgrade = true;
  homebrew.global.autoUpdate = true;
  homebrew.brews = [ "txn2/tap/kubefwd" "koekeishiya/formulae/yabai"];
  homebrew.taps = [ "wez/wezterm" ];
  homebrew.casks = [
    {
      name = "wez/wezterm/wezterm";
      greedy = true;
    }
    "spaceman"
    "slack"
    "hammerspoon"
    "raycast"
    "tableplus"
    "openkey"
    "spaceman"
    "karabiner-elements"
    "arc"
    "dbeaver-community"
    "another-redis-desktop-manager"
    "visual-studio-code"
    "contexts"
    "muzzle"
    "orbstack"
    "cloudflare-warp"
    # "whatpulse/whatpulse/whatpulse"
  ];
  homebrew.masApps = {
    Messenger = 1480068668;
    RunCat = 1429033973;
  };
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
    };
    finder = {
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      "com.apple.swipescrolldirection" = false;
    };
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      "com.apple.mouse.scaling" = 1.5;
    };
    "com.apple.finder" = {
      # When performing a search, search the current folder by default
      FXDefaultSearchScope = "SCcf";
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.screensaver" = {
      # Require password immediately after sleep or screen saver begins
      askForPassword = 1;
      askForPasswordDelay = 0;
    };
    "com.apple.dock" = {
      # Disable rearrange spaces automatically
      "mru-spaces" = false;
      # Enable displays have separate Spaces
      "spans-displays" = false;
      # Reduce size of dock
      tilesize = 16;
    };
  };

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when applies defaults
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # fonts = {
  #   fontDir = { enable = true; };
  #   fonts = with pkgs; [
  #     (nerdfonts.override { fonts = [ "OperatorMono" ]; })
  #     fira-code
  #   ];
  # };

  nix.package = pkgs.nix;
}
