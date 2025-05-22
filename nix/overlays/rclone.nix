# FIXME: Remove later
final: prev:

{
  rclone = prev.rclone.overrideAttrs (old: {
    patches = [
      ./rclone-purego-update.patch
    ];

    vendorHash = "sha256-HtwGNySjRzWH7e9rO+Ixwc3L3tHQP2z5QQuTFO6pdUc=";
  });
}
