{
  description = "My darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager }:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
      };
    in
    {
      darwinConfigurations."tyson-macbook-pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."tyson.nguyen" = import ./home.nix;
            users.users."tyson.nguyen".home = /Users/tyson.nguyen;
          }
          ./configuration.nix
        ];
      };
    };
}
