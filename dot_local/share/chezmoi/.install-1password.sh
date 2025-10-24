#!/bin/sh

# Exit immediately if 'op' (CLI) and '1password' (Desktop App) are already in $PATH
if type op >/dev/null 2>&1 && type 1password >/dev/null 2>&1; then
    exit 0
fi

# This script is intended for Fedora. We can add other Linux distros later.
if ! [ -f /etc/fedora-release ]; then
    echo "This script is intended for Fedora."
    exit 0 # Exit cleanly if not on Fedora, as this hook runs everywhere.
fi

echo "Installing 1Password CLI and Desktop App..."

# Add the GPG key, if not already added
if ! rpm -q gpg-pubkey-76d78fad-645b273b > /dev/null 2>&1; then
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
fi

# Add the repository, if not already added
if ! [ -f /etc/yum.repos.d/1password.repo ]; then
    sudo sh -c 'echo -e "[1password]\nname=1Password\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
fi

# Install the CLI and Desktop App
sudo dnf install -y 1password-cli 1password

echo "1Password CLI and Desktop App installed successfully."
