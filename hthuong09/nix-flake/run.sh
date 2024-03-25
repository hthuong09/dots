#!/usr/bin/env bash
nix build ".#darwinConfigurations.tyson-macbook.local"
./result/bin/darwin-rebuild switch --flake .
