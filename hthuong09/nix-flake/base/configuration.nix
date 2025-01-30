{ pkgs, ... }:
{

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

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
  homebrew.brews = [
    "yabai"
  ];
  homebrew.taps = [
    "wez/wezterm"
    "thatsjustcheesy/tap"
    "koekeishiya/formulae"
  ];
  homebrew.casks = [
    {
      name = "wezterm@nightly";
      greedy = true;
    }
    "defaults-edit"
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
    "cursor"
    "gpg-suite-no-mail"
    # "whatpulse/whatpulse/whatpulse"
  ];
  homebrew.masApps = {
    Messenger = 1480068668;
    RunCat = 1429033973;
    Equinox = 1591510203;
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
    "com.apple.controlcenter" = {
      "NSStatusItem Visible WiFi" = false;
      "NSStatusItem Visible Sound" = false;
      "NSStatusItem Visible NowPlaying" = false;
    };
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # 118 to 126 is the hot key for cmd + N to switch to a specific space using Mission Control shortcuts
        "118" = {
          enabled = true;
          value = {
            parameters = [
              49
              18
              524288
            ];
            type = "standard";
          };
        };

        "119" = {
          enabled = true;
          value = {
            parameters = [
              50
              19
              524288
            ];
            type = "standard";
          };
        };

        "120" = {
          enabled = true;
          value = {
            parameters = [
              51
              20
              524288
            ];
            type = "standard";
          };
        };

        "121" = {
          enabled = true;
          value = {
            parameters = [
              52
              21
              524288
            ];
            type = "standard";
          };
        };

        "122" = {
          enabled = true;
          value = {
            parameters = [
              53
              23
              524288
            ];
            type = "standard";
          };
        };

        "123" = {
          enabled = true;
          value = {
            parameters = [
              54
              22
              524288
            ];
            type = "standard";
          };
        };

        "124" = {
          enabled = true;
          value = {
            parameters = [
              55
              26
              524288
            ];
            type = "standard";
          };
        };

        "125" = {
          enabled = true;
          value = {
            parameters = [
              56
              28
              524288
            ];
            type = "standard";
          };
        };

        "126" = {
          enabled = true;
          value = {
            parameters = [
              57
              25
              524288
            ];
            type = "standard";
          };
        };

        ## Disable spotlight
        "64" = {
          enabled = false;
          value = {
            parameters = [
              32
              49
              1.048
              0.576
            ];
            type = "standard";
          };
        };
        "65" = {
          enabled = false;
          value = {
            parameters = [
              32
              49
              1.572
              0.864
            ];
            type = "standard";
          };
        };
      };
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
