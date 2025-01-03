{ config, pkgs, ... }:
{
  # Import base configuration
  imports = [ ../../base/configuration.nix ];

  environment.systemPackages = [ pkgs.nixfmt-rfc-style ];
  homebrew.casks = [ "ghostty" ];
}
