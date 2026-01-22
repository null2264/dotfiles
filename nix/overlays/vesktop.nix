final: prev:

# Replace the icon with a much more low profile icon
# REF: https://github.com/Vencord/Vesktop/pull/865
let
  vesktop = if prev.stdenv.isDarwin then
    # Use casks version because nodejs is pain
    prev.casks.vesktop
  else
    prev.vesktop;
in {
  inherit vesktop;
}
