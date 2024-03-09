# My Linux dotfiles

My personal Archlinux configuration.
These are targeted for my usecase, but feel free to it.

## Features

- Alacritty <https://wiki.archlinux.org/title/Alacritty>
- Bash <https://wiki.archlinux.org/title/Bash>
- Git <https://wiki.archlinux.org/index.php/Git>
- Neovim <https://wiki.archlinux.org/index.php/Neovim>
- Ranger <https://wiki.archlinux.org/index.php/Ranger>
- Urxvt <https://wiki.archlinux.org/index.php/Urxvt?redirect=no>
- Zsh <https://wiki.archlinux.org/title/zsh>

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
