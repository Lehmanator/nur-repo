{
  description = "Lehmanator's NUR repository";
  inputs = {
    systems = {
      url = "github:nix-systems/default";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # --- packages ---
    # TODO: Install VSCodium wrapped with config
    # TODO: Install Neovim wrapped with config
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "github:nix-community/nixvim";

    # --- flake-parts ---
    flake-parts.url = "github:Hercules-CI/flake-parts";
    flake-root.url = "github:srid/flake-root";
    agenix-shell.url = "github:aciceri/agenix-shell";
    devshell.url = "github:numtide/devshell";
    mission-control.url = "github:Platonic-Systems/mission-control";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, systems, nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit self inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "riscv64-linux"
      ];
      imports = [
        inputs.flake-root.flakeModule
        ./flakeProfiles/agenix-shell.nix
        ./flakeProfiles/devshells.nix
        ./flakeProfiles/pre-commit.nix
        ./flakeProfiles/treefmt.nix
      ];
      perSystem = { config, lib, pkgs, ... }: {
        flake-root.projectRootFile = "flake.nix";
        #apps.default = {program = "${pkgs.nix}/bin/nix";};
        #checks = {};
        #debug = true;
        #legacyPackages = {};
        #overlayAttrs = {};
        #packages = {};
      };

      flake = {
        #apps.x86_64-linux.default = {
        #  program = "${nixpkgs.legacyPackages.x86_64-linux.nix}/bin/nix";
        #};
        #checks = {};
        #devShells = {};
        #flakeModule = self.flakeModules.default;
        #flakeModules = {};
        #overlays = {};
      };
    };
  nixConfig = {
    accept-flake-config = true;
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    fallback = true;
    extra-substituters = [ "https://lehmanator.cachix.org/" ];
    extra-trusted-public-keys = [
      "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU="
    ];
  };
}
