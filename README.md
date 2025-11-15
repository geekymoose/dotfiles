# My Linux dotfiles

My personal Archlinux configuration (I use i3 window manager).
These are targeted for my use-cases, but I hope they can be useful for you.

## Features

- alacritty <https://wiki.archlinux.org/title/alacritty>
- bash <https://wiki.archlinux.org/title/bash>
- dunst <https://wiki.archlinux.org/title/dunst>
- git <https://wiki.archlinux.org/index.php/git>
- gtk <https://wiki.achlinux.org/index.php/gtk>
- i3 <https://wiki.archlinux.org/index.php/i3>
- mime <https://wiki.archlinux.org/title/xdg_mime_applications>
- neovim <https://wiki.archlinux.org/index.php/neovim>
- qt <https://wiki.archlinux.org/title/qt>
- rofi <https://wiki.archlinux.org/title/rofi>
- ssh <https://wiki.archlinux.org/title/ssh_keys>
- vscode <https://code.visualstudio.com/>
- zsh <https://wiki.archlinux.org/title/zsh>
- yazi <https://yazi-rs.github.io/docs/configuration/overview/>
- zed <https://zed.dev/>

## Install

All the required packages are listed in the `pkglist_pacman.txt` file (Archlinux).
To skip a package, comment its entry with `#`.

```bash
# Install all required packages using pacman (sudo is required)
sudo ./exec_pacman.sh
```

## Setup

I use GNU Stow to synchronize the settings.
Each package in the `src` folder is organized the same way it lives on the local computer.

```bash
# Create all symlinks with stow
./exec_stow.sh
```

## Resources

I saw other interesting techniques with git config. For further information, see these links:

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
- <https://github.com/kazhala/dotbare>
