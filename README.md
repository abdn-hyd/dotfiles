# Dotfiles

Personal macOS dotfiles managed with GNU Stow.

## Managed Configs

- `tmux`: terminal multiplexer configuration
- `zsh`: shell configuration
- `lazyvim`: Neovim configuration based on LazyVim
- `aerospace`: AeroSpace window manager configuration
- `kitty`: Kitty terminal configuration

## Usage

Run Stow from the repository root. Package names should match the actual top-level
directory names in this repository.

```sh
stow tmux
stow zsh
stow lazyvim
stow aerospace
stow kitty
```

Remove a package with:

```sh
stow -D <package>
```
