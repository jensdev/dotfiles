# My Dotfiles

This repository contains my personal dotfiles, managed by [chezmoi](https://chezmoi.io/).

## Structure

- `.chezmoidata/packages.yaml`: Defines the packages to be installed on different systems.
- `.chezmoiscripts/`: Contains scripts that are run by chezmoi.
- `dot_...`: Files and directories that will be linked to the home directory.
- `private_...`: Files and directories that will be linked with the `private_` prefix removed.

## Usage

To apply these dotfiles on a new machine, you can use the following command:

```bash
chezmoi init --apply <your-repo-url>
```
