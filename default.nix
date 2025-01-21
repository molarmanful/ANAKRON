{
  pname,
  version,
  cfg ? "",
  nerd ? false,
  P,

  lib,
  stdenvNoCC,
  ...
}:

stdenvNoCC.mkDerivation {
  inherit pname version;
  src = ./.;

  buildPhase = ''
    runHook preBuild
    rm -rf out
    ${P.bited-build}/bin/bited-build ${cfg} \
      ${lib.optionalString nerd "--nerd"}
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts
    cp -r out/. $out/share/fonts
    runHook postInstall
  '';
}
