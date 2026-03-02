# My Linux Dotfiles

My personal Archlinux configuration.
These are targeted for my use cases, but feel free to use any of them.

## Features

- [`Alacritty`](https://wiki.archlinux.org/title/alacritty) - GPU-accelerated terminal emulator
- [`Bash`](https://wiki.archlinux.org/title/bash) - Bash specific configuration
- [`Dunst`](https://wiki.archlinux.org/title/dunst) - Lightweight notification daemon
- [`Git`](https://wiki.archlinux.org/index.php/git) - Version control
- [`GTK`](https://wiki.archlinux.org/index.php/gtk) - GTK+ theme
- [`Krita`](https://krita.org/en) - Digital painting
- [`Mime`](https://wiki.archlinux.org/title/xdg_mime_applications) - Default applications
- [`NeoVim`](https://wiki.archlinux.org/index.php/neovim) - Text editor
- [`Qt`](https://wiki.archlinux.org/title/qt) - Qt theme
- [`Rofi`](https://wiki.archlinux.org/title/rofi) - Application launcher
- `Scripts` - Custom shell scripts and utilities
- [`Shell`](https://wiki.archlinux.org/title/command-line_shell) - POSIX shell configuration
- [`SSH`](https://wiki.archlinux.org/title/ssh_keys) - SSH client configuration
- [`Sway`](https://swaywm.org) - Wayland compositor (i3 replacement)
- [`Vibe`](https://docs.mistral.ai/mistral-vibe) - Mistral Vibe coding agent
- [`VSCode`](https://code.visualstudio.com) - Visual Studio Code IDE
- [`Yazi`](https://yazi-rs.github.io/docs/configuration/overview) - Terminal file manager
- [`Zed`](https://zed.dev) - Modern code editor
- [`Zsh`](https://wiki.archlinux.org/title/zsh) - Z shell configuration

## Installation

All the required packages are listed in the `pkglist_pacman.txt` file (Arch Linux).
To skip a package, comment the line with `#`.

I use GNU Stow to synchronize the settings.
Each package in the `src` folder is organized the same way it lives on the local computer.

```sh
# Install all packages
sudo ./exec_pacman.sh

# Create all symlinks
./exec_stow.sh

# Setup Neovim plugins
nvim # Then run :PlugInstall

# Install zsh oh-my-posh (AUR)
git clone https://aur.archlinux.org/oh-my-posh.git
cd oh-my-posh
cat PKGBUILD # Check if the URLs are correct (for security)
makepkg -sirc

# For Sway: set the backgrounds (replace your_bg_* with your files)
mkdir -p $HOME/.local/share/backgrounds
cp your_bg_home.jpg $HOME/.local/share/backgrounds/home.jpg
cp your_bg_lock.png $HOME/.local/share/backgrounds/lock.png

# Autostart the lemurs display manager
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
