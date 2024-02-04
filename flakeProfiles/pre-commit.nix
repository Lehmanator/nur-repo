{ inputs, self, config, ... }: {
  imports = [ inputs.pre-commit-hooks-nix.flakeModule ];
  perSystem = { config, lib, pkgs, ... }: {
    pre-commit = {
      check.enable = true;
      #devShell = null;
      #installationScript = ''
      #'';
      settings = {
        # https://pre-commit.com/#confining-hooks-to-run-at-certain-shttps://pre-commit.com/#confining-hooks-to-run-at-certain-stagestages
        # commit-msg, pre-commit, post-commit, prepare-commit-msg, pre-merge-commit,
        # post-checkout, post-merge, post-rewrite, pre-push, pre-rebase
        default_stages = [ "commit" ];
        excludes = [ ];

        hooks = {
          actionlint = { enable = false; };
          annex.enable = false;
          ansible-lint.enable = false;
          bats.enable = false;
          cargo-check.enable = false;
          clippy.enable = false;
          commitizen.enable = false;
          conform.enable = false;
          #deadnix = {
          #  edit = false; # Remove unused code and write to source file.
          #  exclude = [];
          #  hidden = false;
          #  noLambdaArg = config.treefmt.programs.deadnix.no-lambda-arg;
          #  noLambdaPatternNames = config.treefmt.programs.deadnix.no-lambda-pattern-names;
          #  noUnderscore = config.treefmt.programs.deadnix.no-underscore;
          #  quiet = false;
          #};
          editorconfig-checker.enable = false;
          gptcommit.enable = false;
          mix-format.enable = false;
          mix-test.enable = false;
          nil.enable = false;
          #nixfmt.enable = config.treefmt.programs.nixfmt.enable;
          #nixpkgs-fmt.enable = config.treefmt.programs.nixpkgs-fmt.enable;
          #shellcheck.enable = config.treefmt.programs.shellcheck.enable;
          #shfmt.enable = config.treefmt.programs.shfmt.enable;
          tagref.enable = false; # Check references & tags.
          topiary.enable =
            false; # Universal formatter engine w/i treesitter ecosystem. Supports many langs.
          treefmt = {
            enable = true;
            #entry = "${config.treefmt.build.wrapper} --config-file ${config.treefmt.build.configFile}";
          };
          typos.enable = false;
          #<name> = {
          #  enable = true;
          #  always_run = false; # If true, hook will run even if there are no matching files.
          #  description = "";
          #  entry = "autopep8 -i";
          #  excludes = [];
          #  fail_fast = false; # If true, pre-commit will stop running hooks if this hook fails
          #  files = ""; # Pattern of files to run on.
          #  language = "system"; # Language of the hook. Tells pre-commit how to install the hook.
          #  name = "";
          #  pass_filenames = true; # Whether to pass filenames as args to the entrypoint.
          #  raw = {}; # Raw fields of a pre-commit hook. Mostly for internal use.
          #  require_serial = false; # If true, hook will execute using single process instead of parallel.
          #  stages = default_stages; # Confines hook to run at particular stage
          #  types = ["file"]; # List of file types to run on. See: https://pre-commit.com/#plugins
          #  types_or = []; # List of file types to run on, where only single type needs to match
          #  verbose = false;
          #};
        };
        package = pkgs.pre-commit;
        settings = {
          treefmt.package = config.treefmt.build.wrapper;

          #typos = {
          #  color = "auto";
          #  config = ''
          #    [files]
          #    ignore-dot = true
          #
          #    [default]
          #    binary = false
          #
          #    [type.py]
          #    extend-glob = [];
          #  '';
          #  #configPath = "./typos.toml";
          #};
        };
      };
    };
  };
}
