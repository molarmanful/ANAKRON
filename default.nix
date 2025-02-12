{
  pname,
  version,
  cfg ? "",
  nerd ? false,
  release ? false,

  lib,
  stdenvNoCC,
  bited-build,
  bdf2psf,
  zip,
  ...
}:

stdenvNoCC.mkDerivation {
  inherit pname version;
  src = ./.;

  buildPhase = ''
    runHook preBuild
    rm -rf out
    ${bited-build}/bin/bited-build ${cfg} \
      ${lib.optionalString nerd "--nerd"}
    ${bdf2psf}/bin/bdf2psf --fb src/ANAKRON.bdf \
      ${bdf2psf}/share/bdf2psf/standard.equivalents \
      src/ANAKRON.set \
      512 out/ANAKRON.psfu
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts $out/share/consolefonts
    cp -r out/. $out/share/fonts
    cp out/*.psfu $out/share/consolefonts
    ${lib.optionalString release ''
      ${zip}/bin/zip -r $out/share/fonts/${pname}_${version}.zip $out/share/fonts
    ''}
    runHook postInstall
  '';
}
