final: prev:

{
  # Replace the icon with a much more low profile icon
  # REF: https://github.com/Vencord/Vesktop/pull/865
  vesktop = prev.vesktop.overrideAttrs (old: {
    preBuild =
      old.preBuild
      + ''
        cp -f ${../../include/vesktop/icon.icns} build/icon.icns
      '';
  });
}
