# My Linux Dotfiles

My personal Archlinux configuration.
These are targeted for my use cases, but feel free to use any of them.

## Features

- **Alacritty** - GPU-accelerated terminal emulator <https://wiki.archlinux.org/title/alacritty>
- **Bash** - Bash specific configuration <https://wiki.archlinux.org/title/bash>
- **Dunst** - Lightweight notification daemon <https://wiki.archlinux.org/title/dunst>
- **Git** - Version control <https://wiki.archlinux.org/index.php/git>
- **GTK** - GTK+ theme <https://wiki.archlinux.org/index.php/gtk>
- **Krita** - Digital painting <https://https://krita.org/en>
- **Mime** - Default applications <https://wiki.archlinux.org/title/xdg_mime_applications>
- **NeoVim** - Text editor <https://wiki.archlinux.org/index.php/neovim>
- **Qt** - Qt theme <https://wiki.archlinux.org/title/qt>
- **Rofi** - Application launcher <https://wiki.archlinux.org/title/rofi>
- **Scripts** - Custom shell scripts and utilities
- **Shell** - POSIX shell configuration <https://wiki.archlinux.org/title/command-line_shell>
- **SSH** - SSH client configuration <https://wiki.archlinux.org/title/ssh_keys>
- **Sway** - Wayland compositor (i3 replacement) <https://swaywm.org>
- **Vibe** - Mistral Vibe coding agent <https://https://docs.mistral.ai/mistral-vibe>
- **VSCode** - Visual Studio Code IDE <https://code.visualstudio.com>
- **Yazi** - Terminal file manager <https://yazi-rs.github.io/docs/configuration/overview>
- **Zed** - Modern code editor <https://zed.dev>
- **Zsh** - Z shell configuration <https://wiki.archlinux.org/title/zsh>

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
