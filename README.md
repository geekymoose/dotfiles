# My Linux dotfiles

My personal Archlinux configuration.
These are targeted for my usecase, but feel free to it.

## Features

- alacritty <https://wiki.archlinux.org/title/alacritty>
- bash <https://wiki.archlinux.org/title/bash>
- gtk <https://wiki.archlinux.org/index.php/gtk>
- git <https://wiki.archlinux.org/index.php/git>
- i3 <https://wiki.archlinux.org/index.php/i3>
- neovim <https://wiki.archlinux.org/index.php/neovim>
- ranger <https://wiki.archlinux.org/index.php/ranger>
- urxvt <https://wiki.archlinux.org/index.php/urxvt>
- zsh <https://wiki.archlinux.org/title/zsh>
- x11 <https://wiki.archlinux.org/title/xorg>

## Install

All the required packages are listed in the `pkglist_pacman.txt` file (Archlinux).
You can comment any package from the file to skip its install.

```bash
# Install all required packages using pacman (Archlinux)
./exec_pacman.sh
```

## Setup

I use GNU Stow to synchronize the settings.
Each package in the `src` folder is organized the same way it lives on the local computer.

```bash
# Apply all symlinks
./exec_stow.sh
```

## Resources

I saw other interesting techniques with git config. For further information, see these links:

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
- <https://github.com/kazhala/dotbare>
