{ config, lib, pkgs, inputs, self, system, ... }: {
  imports = [ inputs.devshell.flakeModule ];
  perSystem = let
    age-identities = config.agenix-shell.identityPaths;
    age-github-token = config.agenix-shell.secrets.GITHUB_TOKEN.file;
  in { config, lib, pkgs, ... }: {
    #inherit age-identities age-github-token;
    devshells.default = {
      devshell = {
        name = "lehmanator-nur-repo";
        load_profiles = true;
        meta = {
          description = "Development shell for Lehmanator's NUR repo!";
        };
        motd = ''
          {202}🔨 Welcome to Lehmanator's NUR repo devshell{reset}
          $(type -p menu &>/dev/null && menu)
        '';
        packages = [
          config.treefmt.build.wrapper
          config.agenix-shell.package
          pkgs.nix-init
        ];
        packagesFrom = [ ];
        prj_root_fallback = { eval = "$(git rev-parse --show-toplevel)"; };
        startup = {
          # TODO: Extra script to set env vars based on AGENIX_<envVar>
          agenix-install = {
            deps = [ "agenix-setup-github" ];
            text = ''
              source ${lib.getExe config.agenix-shell.installationScript}
              export GITHUB_TOKEN="$AGENIX_GITHUB_TOKEN"
            '';
          };
          agenix-setup-github = {
            deps = [ ]; # ["agenix-setup"];
            text = let
              #-R ~/.ssh/id_ed25519.pub -R ~/.ssh/id_rsa.pub $github-token-file > ${age-github-token}
              #age-github-token="${self}/secrets/github-token.age"
              ageBin = "${lib.getExe config.agenix-shell.package}";
              ageArgs = lib.strings.concatMapStringsSep " " (id: "-R ${id}.pub")
                age-identities;
            in ''
              if [[ ! -f "${age-github-token}" ]]; then
                echo "[setup] Requires GITHUB_TOKEN env var."
                echo "[setup] Generate a GitHub personal access token by clicking the following link:"
                echo "[setup]"
                echo "[setup] https://github.com/settings/personal-access-tokens/new"
                echo "[setup]"
                echo "[setup] Paste your token here, then hit [ENTER] to continue."
                export github-token-file="$(mktemp)"
                read token
                echo "[setup] Writing token to temporary file: $github-token-file ..."
                echo "$github-token" > $github-token-file
                echo "[setup] Encrypting file with SSH keys ..."
                ${ageBin} ${ageArgs} $github-token-file > ${age-github-token}
                echo "[setup] Encrypted to: ${age-github-token}"
                echo "[setup] Deleting temporary file: $github-token-file ..."
                rm -f $github-token-file
                echo "[setup] Done."
              fi
            '';
          };
          #welcome = {
          #  deps = [];
          #  text = ''
          #    {202}🔨 Welcome to Lehmanator's NUR repo devshell{reset}
          #    $(type -p menu &>/dev/null && menu)
          #  '';
          #};
          #agenix-setup = {
          #  deps = ["welcome"];
          #  text = ''
          #    source ${lib.getExe config.agenix-shell.installationScript}
          #  '';
          #};
        };
        #interactive.nix-init = {
        #  #deps = [pkgs.nix-init];
        #  text = ''
        #    nix-init
        #  '';
        #};
      };
      # See files in: ~/.config/nixos/hm/profiles/nix/utils/*.nix
      commands = [
        {
          name = "format";
          category = "format";
          command = "nix fmt";
          help = "Format this flake repo with treefmt-nix";
        }
        {
          command = "nixos-generate";
          category = "generators";
          package = pkgs.nixos-generators;
        }
        {
          name = "install-agenix-shell";
          category = "setup";
          package = config.agenix-shell.installationScript;
        }
        {
          #name = "nix-init";
          command = "nix-init";
          category = "new-package";
          package = pkgs.nix-init;
        }
        {
          # TODO: Split into niv {add,update,drop,init,show,modify}
          command = "niv";
          category = "new-package";
          package = pkgs.niv;
        }
        {
          command = "nix-update";
          category = "updaters";
          package = pkgs.nix-update;
        }
        {
          command = "nix-update-source";
          category = "updaters";
          package = pkgs.nix-update-source;
        }
      ];
      env = [
        #{ name=""; eval=""; prefix=""; unset=false; value=""; }
      ];
      serviceGroups = { };
    };
  };
}
