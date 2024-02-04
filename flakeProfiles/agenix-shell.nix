{ inputs, self, ... }: {
  imports = [ inputs.agenix-shell.flakeModules.default ];
  agenix-shell = {
    identityPaths = [ "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_rsa" ];
    secrets = {
      GITHUB_TOKEN = {
        name = "GITHUB_TOKEN";
        file = "${self}/secrets/github-token.age";
        mode = "0400";
      };
    };
  };
  perSystem = { config, lib, pkgs, ... }: {
    agenix-shell = {
      package = pkgs.rage;

      # Script that exports secrets as variables. Meant to be used as hook in devShells.
      #installationScript = ''
      #'';
    };
  };
}
