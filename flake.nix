{
  description = "A thicc retrofuturistic bitmap font made for the modern screen";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    systems.url = "systems";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    bited-utils.url = "github:molarmanful/bited-utils";
  };

  outputs =
    inputs@{ systems, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
        inputs.bited-utils.flakeModule
      ];
      systems = import systems;
      perSystem =
        { config, pkgs, ... }:
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

          devshells.default = {

            commands = with pkgs; [
              {
                package = nil;
                category = "lsp";
              }
              {
                package = nixd;
                category = "lsp";
              }
              {
                package = nixfmt-rfc-style;
                category = "formatter";
              }
              {
                package = statix;
                category = "linter";
              }
              {
                package = deadnix;
                category = "linter";
              }
              { package = taplo; }
              {
                package = marksman;
                category = "lsp";
              }
              {
                package = mdformat;
                category = "formatter";
              }
              { package = config.bited-utils.bited-clr; }
            ];

            packages = with pkgs; [
              python313Packages.mdformat-gfm
              python313Packages.mdformat-gfm-alerts
            ];
          };
        };
    };
}
