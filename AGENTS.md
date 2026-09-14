# Dotfiles

Personal Arch Linux and Windows configuration files managed with GNU Stow.
This repository contains system, shell, editor, and other configs.

## Project Tools

- GNU Stow - Symlink farm manager for dotfiles
- Pacman - Archlinux package manager
- Bash/Shell scripting
- Git version control
- Platform support: Archlinux (primary), Windows (secondary)

## Guidelines

- Use US English for all documentation and code
- Modify only what is necessary
- Apply changes directly to the file
- Insert a line break after each sentence in markdown and comments
- Respect the stow directory structure (each package mirrors its install location)
- Do not use the following special chars: ‘ ’ “ ” —
- Do not commit or stage changes (perform file edits only)

## Platform Notes

- Linux configurations use GNU Stow for symlink management (`exec_stow.sh`)
- Windows configurations use PowerShell script (`setup-links.ps1`)
- Some applications have cross-platform configs
- Sway, Dunst, Rofi are Linux-only (Wayland)
- PowerShell, AutoHotkey are Windows-only
