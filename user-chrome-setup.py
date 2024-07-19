#!/usr/bin/env python3
"""
Install userChrome.css to $BROWSER's folder.

Written in Python because I'm too lazy to deal with INI parser using bash.
"""

import configparser
import os
import pathlib
import sys
from subprocess import run

def bool_from_string(string: str | None, default: bool | None = None) -> bool:
    lowered = (string or "").lower()

    if lowered in ("yes", "y", "true", "t", "1", "enable", "on"):
        return True
    elif lowered in ("no", "n", "false", "f", "0", "disable", "off"):
        return False

    if default is not None:
        return default
    raise ValueError("Invalid Input")

def die(message: str | None = None) -> None:
    if message:
        print(message, file=sys.stderr)
    exit(1)

config = configparser.ConfigParser()
home = os.getenv("HOME")
browser = os.getenv("BROWSER")
dotfiles = os.getenv("ZI_DOTFILES")

if not dotfiles:
    die("Please run pre-bootstrap first!")

if not browser:
    die("$BROWSER is not set!")

tmp = run([browser, "--version"], capture_output=True, text=True)
if not tmp.stdout.startswith("Mozilla"):
    die("Chrome-based browser is not supported!")

if not "floorp" in tmp.stdout.lower():
    die("This script currently only support Floorp")

browser_path = f"{home}/.{browser}"

# Firefox doesn't support XDG path (yet?)
try:
    # Firefox doesn't support XDG path (yet?)
    config.read(f"{browser_path}/profiles.ini")
except:
    die("Unable to read profile list")

prompt = input("NOTE: Currently only support installing userChrome.css to default profile, continue anyway? [y/N] ")
if not bool_from_string(prompt, False):
    exit(0)

# profiles = [p for p in config.sections() if p.startswith("Profile")]
# default = next(config[p] for p in profiles if str(config[p].get("Default", "0")) == "1")

_install = [p for p in config.sections() if p.startswith("Install")]
default_paths = [config[p] for p in _install]
installed = 0
for default_path in default_paths:
    profile_path = f"{browser_path}/{default_path['Default']}"
    chrome_path = pathlib.Path(f"{profile_path}/chrome")
    chrome_path.mkdir(parents=True, exist_ok=True)
    user_chrome_path = chrome_path / "userChrome.css"
    target_path = f"{dotfiles}/.include/ff-chrome/userChrome.css"
    try:
        user_chrome_path.symlink_to(target_path)
        installed += 1
    except FileExistsError:
        prompt = input(f"[{default_path['Default']}] Overwrite existing userChrome.css? [y/N] ")
        if not bool_from_string(prompt, False):
            continue
        user_chrome_path.unlink()
        user_chrome_path.symlink_to(target_path)
        installed += 1
print(f"userChrome.css has successfully installed in {installed} out of {len(default_paths)} profile(s).")
