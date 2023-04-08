nix build ".#darwinConfigurations.tyson-macbook-pro.system"
./result/sw/bin/darwin-rebuild switch --flake .
