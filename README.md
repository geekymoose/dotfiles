# My Linux dotfiles

These are the common settings I use daily.
Feel free to use any of them.
(I use Archlinux as my main Linux distribution).

## Features

Each category has several dotfiles (see the category's README).

- Archlinux
- Archlinux_i3
- Console
- Programming
- Software

## Install

Open the folder you want to install.
All the required packages are listed in the `pkglist_pacman.txt` file (Archlinux).
You can comment any package from the file to skip its install.

```bash
# Install all required packages using pacman (Archlinux)
./exec_pacman.sh
```

## Setup

Open the folder you want to setup.
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
