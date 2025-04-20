{
  description = "A thicc retrofuturistic bitmap font made for the modern screen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    bited-utils = {
      url = "github:molarmanful/bited-utils";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs =
    inputs@{ systems, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.bited-utils.flakeModule ];
      systems = import systems;
      perSystem =
        {
          config,
          pkgs,
          self',
          ...
        }:
        {

          bited-utils = {
            name = "ANAKRON";
            version = builtins.readFile ./VERSION;
            src = ./.;
            nerd = true;
            buildTransformer =
              build:
              build.overrideAttrs {
                postBuild = ''
                  ${pkgs.bdf2psf}/bin/bdf2psf --fb src/ANAKRON.bdf \
                    ${pkgs.bdf2psf}/share/bdf2psf/standard.equivalents \
                    src/ANAKRON.set \
                    512 out/ANAKRON.psfu
                '';
                postInstall = ''
                  install -Dm644 out/*.psfu -t $out/share/consolefonts
                '';
              };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              config.bited-utils.bited-clr
              taplo
              # lsps
              nil
              nixd
              marksman
              # formatters
              nixfmt-rfc-style
              mdformat
              python3Packages.mdformat-gfm
              python3Packages.mdformat-gfm-alerts
              # linters
              statix
              deadnix
            ];
          };

          formatter = pkgs.writeShellApplication {
            name = "linter";
            runtimeInputs = self'.devShells.default.nativeBuildInputs;
            text = ''
              find . -iname '*.nix' -exec nixfmt {} \; -exec deadnix -e {} \; -exec statix fix {} \;
              find . -iname '*.toml' -exec taplo fmt {} \;
              find . -iname '*.md' -exec mdformat {} \;
            '';
          };
        };
    };
}
