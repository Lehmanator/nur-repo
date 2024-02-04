{ config, pkgs, lib, ... }: {
  imports =
    [ ./agenix-shell.nix ./devshells.nix ./pre-commit.nix ./treefmt.nix ];
}
