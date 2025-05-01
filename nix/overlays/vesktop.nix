final: prev:

# Replace the icon with a much more low profile icon
# REF: https://github.com/Vencord/Vesktop/pull/865
let
  vesktop = if prev.stdenv.isDarwin then
    # Use casks version because nodejs is pain
    prev.casks.vesktop.overrideAttrs (old: {
      configurePhase =
        ''
          cp -f ${../../include/vesktop/icon.icns} Contents/Resources/icon.icns
        '';
    })
  else
    prev.vesktop.overrideAttrs (old: {
      preBuild =
        old.preBuild
        + ''
          cp -f ${../../include/vesktop/icon.icns} build/icon.icns
        '';
    });
in {
  inherit vesktop;
}
