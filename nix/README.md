# `null2264`'s Nix Setup

## Structure

```
├── flake.lock
├── flake.nix
├── lib/                        # Self-explanatory, it contains helper functions
│   ├── mkCommon.nix
│   └── mkSystem.nix
├── modules/                    # Contains shared configuration across system, across user
│   └── home-manager
│       └── floorp.nix
├── overlays/                   # Nix overlays, self-explanatory
├── systems/                    # Contains configurations depending on what type OS nix is being used in
│   ├── darwin/                 # - macOS
│   │   ├── configuration.nix   # -- There supposed supposed to be a split here just like `nix/`, but I got lazy
│   │   ├── default.nix         # -- Where you register your Mac (based on hostname)
│   ├── nix/                    # - non-NixOS (Linux/BSD/etc..)
│   │   ├── default.nix         # -- Where you register your PC (based on hostname)
│   │   └── <hostname>/
│   │       └── default.nix
│   └── nixos/                  # - NixOS
└── users/                      # Contains configurations for multi-user setup
    ├── default.nix             # - Where you register the user(s)
    └── <user>/                 # - Recommended to split it to several nix files depending on the OS type you're planning to use
        ├── darwin.nix          # -- macOS
        ├── default.nix         # -- Common (works on all OS type)
        └── linux.nix           # -- Linux
```

## Setup

### Nix

It is recommended to install nix using [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) or [Nix's Official Installer](https://nixos.org/download/) (with `--daemon` flag, aka Multi-user installation) instead of whatever provided by your OS' package manager to avoid potential incompatibility.

### macOS

> [!NOTE]
> If you're using Alfred, to make Applications installed via Nix to appear on Alfred:
> - Open Alfred Preferences
> - General > Default Results > Extras > Click `Advanced`
> - Add `com.apple.alias-file`

> [!CAUTION]
> This setup is NOT compatible with homebrew, it is designed to completely replaces homebrew.
> Uninstall homebrew before proceeding.

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
