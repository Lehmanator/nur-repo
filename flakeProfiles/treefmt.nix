{ config, lib, pkgs, inputs, self, ... }: {
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem = { config, lib, pkgs, ... }: {
    #formatter = config.perSystem.treefmt.build.wrapper;
    treefmt = rec {
      inherit (config.flake-root) projectRootFile;
      flakeCheck = true;
      flakeFormatter = true;
      projectRoot = self;
      programs = {
        deadnix.enable = false;
        nixfmt.enable = true;
        nixpkgs-fmt.enable = true;
        statix.enable = false;

        rustfmt.enable = true;
      };
      settings = {
        global.excludes = [ "${projectRoot}/**/node_modules/" ];
        formatter = {
          nixpkgs-fmt = {
            includes = [ "${projectRoot}/pkgs/**.nix" ];
            excludes = [ "*.nix" ];
          };
          nixfmt = {
            #includes = [ "${projectRoot}/**.nix" ];
            excludes = [ "${projectRoot}/pkgs/**.nix" ];
          };
          rustfmt.includes = [ "${projectRoot}/pkgs/*/src/**.rs" ];
        };
      };

      #build = {
      #  check = true;
      #  configFile = <path>;
      #  devShell = null;
      #  #programs = {};
      #  #wrapper = <pkg>;
      #};

      #programs = {
      #  # --- Nix ---
      #  alejandra.enable = false;
      #  deadnix = {
      #    enable = false;
      #    no-lambda-arg = false;
      #    no-lambda-pattern-names = false;
      #    no-underscore = false;
      #  };
      #  nixfmt.enable = true;
      #  nixpkgs-fmt.enable = true;
      #  statix = {
      #    enable = false;
      #    disabled-lints = ["empty_pattern"];
      #  };
      #
      #  # --- Golang ---
      #  # --- Haskell ---
      #  # --- Java ---
      #  # --- Javascript ---
      #  # --- Jsonnet ---
      #  # --- Kotlin ---
      #  # --- Markdown ---
      #  # --- Nickel ---
      #  # --- OCaml ---
      #  # --- Python ---
      #  # --- Rust ---
      #  rustfmt.enable = true;
      #  # --- Shell ---
      #  beautysh.enable = false;
      #  shellcheck.enable = false;
      #  shfmt.enable = false;
      #};
    };

    #devShells.default = {
    #  commands = [
    #    {
    #      name = "welcome";
    #      category = "info";
    #      command = "Welcome to Lehmanator's NUR repo!";
    #    }
    #    {
    #      name = "format-nixpkgs";
    #      command = "nix fmt ./packages";
    #    }
    #  ];
    #
    #  devshell = {
    #    name = "lehmanator-nur-repo";
    #    load_profiles = true;
    #    meta.description = "Development shell for Lehmanator's NUR repo!";
    #    motd = ''
    #      {202}🔨 Welcome to Lehmanator's NUR repo devshell{reset}
    #      $(type -p menu &>/dev/null && menu)
    #    '';
    #    prj_root_fallback = {eval = "$(git rev-parse --show-toplevel)";};
    #    startup = {
    #      deps = [];
    #      text = ''
    #        {202}🔨 Welcome to Lehmanator's NUR repo devshell{reset}
    #        $(type -p menu &>/dev/null && menu)
    #      '';
    #    };
    #  };
    #  packages = [
    #    config.treefmt.build.wrapper
    #    pkgs.alejandra
    #    pkgs.deadnix
    #    pkgs.nixfmt
    #    pkgs.nixpkgs-fmt
    #    pkgs.statix
    #  ];
    #};
    #formatter = null;
  };
}
