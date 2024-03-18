#!/usr/bin/env bash
nix build ".#darwinConfigurations.tyson-macbook.local"
./result/sw/bin/darwin-rebuild switch --flake .
