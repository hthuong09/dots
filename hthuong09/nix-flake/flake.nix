{
  description = "My darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
    }:
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      # Work configuration (Tyson's MacBook Pro)
      darwinConfigurations."tyson-macbook-pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."tyson.nguyen" = {
              imports = [ ./hosts/work/home.nix ];
            };
            users.users."tyson.nguyen".home = /Users/tyson.nguyen;
          }
          ./hosts/work/configuration.nix
        ];
      };

      # Personal configuration (Thuong's Mac Mini)
      darwinConfigurations."Thuongs-Mac-mini" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."aichan" = {
              imports = [ ./hosts/personal/home.nix ];
            };
            users.users."aichan".home = /Users/aichan;
          }
          ./hosts/personal/configuration.nix
        ];
      };
    };
}
