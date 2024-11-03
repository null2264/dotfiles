# `null2264`'s Nix Setup

You need to install Nix before following this guide: `sh <(curl -L https://nixos.org/nix/install)` and symlink this dir to `~/.config/nix`

## Structure

```
├── flake.lock
├── flake.nix
├── lib                 # Self-explanatory, it contains helper functions
│   ├── mkCommon.nix
│   └── mkSystem.nix
├── modules             # Contains shared configuration across system, across user
│   └── home-manager
│       └── floorp.nix
├── systems             # Contains configurations depending on what type OS nix is being used in
│   ├── darwin          # macOS
│   │   ├── configuration.nix
│   │   └── default.nix
│   └── nix             # Linux-alike
│       ├── default.nix
│       └── potato
│           └── default.nix
└── users               # Contains configurations for multi-user setup
    ├── default.nix
    └── ziro
        ├── darwin.nix
        ├── default.nix
        └── linux.nix
```

## Setup

### macOS

> [!NOTE]
> If you're using Alfred, to make Applications installed via Nix to appear on Alfred:
> - Open Alfred Preferences
> - General > Default Results > Extras > Click `Advanced`
> - Add `com.apple.alias-file`

Nix in macOS is handled by [nix-darwin](https://github.com/LnL7/nix-darwin).

#### Initial

This is done because nix-darwin commands is not yet added to PATH, should be a one-time thing

```zsh
nix-env -iA nixpkgs.git
# Run `sudo chown $USER /nix/var/nix/profiles/per-user/$USER` if that returns error

nix build .#darwinConfigurations.<host>.system

./result/sw/bin/darwin-rebuild switch --flake .#<host>
# or
nix run nix-darwin -- switch --flake .#<host>
```

#### Rebuild

After initial setup, you should now be able to use the command directly:

```sh
darwin-rebuild build --flake .  # or you can specify the hostname with `--flake . #<hostname>`

# or if you're feeling lucky

darwin-rebuild switch --flake .
```

### Other

Nix in non-NixOS Linux is handled by [system-manager](https://github.com/numtide/system-manager).

#### Rebuild

Unfortunately, root access is required in order to use system-manager.

```sh
sudo -i nix run 'github:numtide/system-manager' --extra-experimental-features "nix-command flakes" -- switch --flake $PWD
```

### Home

This is for per-user setup. Instead of managing the entire system, you're
managing one user at a time. This is handled by
[home-manager](https://github.com/nix-community/home-manager)

#### Rebuild

```sh
home-manager build --flake .  # or you can specify the user with `--flake . #<username>@<hostname>`

# or if you're feeling lucky

home-manager switch --flake .
```
