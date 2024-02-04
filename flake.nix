{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:Hercules-CI/flake-parts";
  };

  outputs = {self, ...} @ inputs: let
    systems = [
      "x86_64-linux"
      "i686-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "armv6l-linux"
      "armv7l-linux"
      "riscv64-linux"
    ];
    forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems (system: f system);
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];
      inherit systems;
      #perInput = {};
      perSystem = {
        config,
        lib,
        pkgs,
        inputs',
        self',
        system, # getSystem,
        #moduleWithSystem,
        #withSystem,
        ...
      }: {
        #apps = {};
        #checks = {};
        #debug = false;
        #devShells = {};
        #formatter = null;
        #legacyPackages = {};
        #overlayAttrs = {};
        #packages = {};
      };
      flake = {
        #apps = {};
        #checks = {};
        #devShells = {};
        #flakeModule = self.flakeModules.default;
        #flakeModules = {};
        #formatter = {};
        legacyPackages = forAllSystems (system:
          import ./default.nix {
            pkgs = import inputs.nixpkgs {inherit system;};
          });
        #nixosConfiguratoins = {};
        #nixosModules = {};
        #overlays = {};
        packages = forAllSystems (system:
          inputs.nixpkgs.lib.filterAttrs
          (_: v: inputs.nixpkgs.lib.isDerivation v)
          self.legacyPackages.${system});
      };
    };
  description = "Lehmanator's NUR repository";
  nixConfig = {
    accept-flake-config = true;
    experimental-features = ["nix-command" "flakes" "repl-flake"];
    fallback = true;
    extra-substituters = ["https://lehmanator.cachix.org/"];
    extra-trusted-public-keys = [
      "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU="
    ];
  };
}
