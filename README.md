# My Linux Dotfiles

My personal Archlinux configuration.
These are targeted for my use cases, but feel free to use any of them.

## Project Structure

- `src/` - Configuration source files organized by application
- `build/setup-links.ps1` - Script to create configuration symlinks on Windows
- `build/exec_pacman.sh` - Script to install all Archlinux packages
- `build/exec_stow.sh` - Script to create configuration symlinks on Linux
- `build/pkglist_pacman.txt` - List of required Archlinux packages
- `LICENSE` - Project license information
- `README.md` - Project introduction for humans

## Features

- [`Alacritty`](./src/alacritty/.config/alacritty/) - GPU-accelerated terminal emulator
- [`Bash`](./src/bash/) - Bash specific configuration
- [`Dunst`](./src/dunst/.config/dunst/) - Lightweight notification daemon
- [`Git`](./src/git/.config/git/) - Version control
- [`GTK`](./src/gtk/.config/) - GTK+ theme
- [`Krita`](./src/krita/.config/) - Digital painting
- [`Mime`](./src/mime/.config/) - Default applications
- [`NeoVim`](./src/nvim/.config/nvim/) - Text editor
- [`OpenCode`](./src/opencode/.config/opencode/) - AI coding agent
- [`Qt`](./src/qt/.config/) - Qt theme
- [`Rofi`](./src/rofi/.config/rofi/) - Application launcher
- [`Scripts`](./src/scripts/.local/bin/) - Custom shell scripts and utilities
- [`Shell`](./src/sh/.config/sh/) - POSIX shell configuration
- [`SSH`](./src/ssh/.ssh/) - SSH client configuration
- [`Sway`](./src/sway/.config/sway/) - Wayland compositor (i3 replacement)
- [`VSCode`](./src/code/.config/Code/User/) - Visual Studio Code IDE
- [`Yazi`](./src/yazi/.config/yazi/) - Terminal file manager
- [`Zed`](./src/zed/.config/zed/) - Modern code editor
- [`Zsh`](./src/zsh/) - Z shell configuration

## Installation

All the required packages are listed in the `build/pkglist_pacman.txt` file.
To skip a package, comment the line with `#`.
This is targeted for Arch Linux, but can be adapted for other distributions.

I use GNU Stow to synchronize the settings.
Each package in `src` folder is organized the same way it lives on the local computer.

```sh
# Install all packages (Archlinux)
sudo ./bash/exec_pacman.sh

# Create all symlinks (any distributions)
./bash/exec_stow.sh

# Setup Neovim plugins (any distribution)
nvim # Then run :PlugInstall

# Install zsh oh-my-posh (Archlinux AUR)
git clone https://aur.archlinux.org/oh-my-posh.git
cd oh-my-posh
cat PKGBUILD # Check if the URLs are correct (for security)
makepkg -sirc

# Set background for Sway window manager (any distribution)
# Replace your_bg_* with your files
mkdir -p $HOME/.local/share/backgrounds
cp your_bg_home.jpg $HOME/.local/share/backgrounds/home.jpg
cp your_bg_lock.png $HOME/.local/share/backgrounds/lock.png

# Autostart the lemurs display manager (any distribution)
systemctl enable lemurs
```

## Fonts

> The fonts I use.
> On Archlinux, you can see the required packages in `pkglist_pacman.txt`.

- **CaskaydiaMono Nerd Font** - For code and terminal
- **NotoSans** - For system UI

## Resources

I saw other interesting techniques for managing dotfiles with Git.
For further information, see these links:

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
- <https://github.com/kazhala/dotbare>
