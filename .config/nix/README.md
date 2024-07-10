# `null2264`'s Nix Setup

You need to install Nix before following this guide: `sh <(curl -L https://nixos.org/nix/install)` and symlink this dir to `~/.config/nix`

## Setup

### Initial

This is done because nix-darwin commands is not yet added to PATH, should be a one-time thing

```zsh
nix-env -iA nixpkgs.git
# Run `sudo chown $USER /nix/var/nix/profiles/per-user/$USER` if that returns error

nix build .#darwinConfigurations.<host>.system

./result/sw/bin/darwin-rebuild switch --flake .#<host>
# or
nix run nix-darwin -- switch --flake .#<host>
```

### Rebuild

After initial setup, you should now be able to use the command directly:

```
darwin-rebuild switch --flake .#<host>
```
