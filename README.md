# My Linux dotfiles

These are the common settings I use daily.
Feel free to use any of them.
(I use Archlinux as my main Linux distribution).

## Features

- Console
  - Alacritty <https://wiki.archlinux.org/index.php/Alacritty>
  - Urxvt <https://wiki.archlinux.org/index.php/Urxvt?redirect=no>
  - Zsh
  - Bash
  - X11
- Programming
  - Vscode <https://wiki.archlinux.org/index.php/Visual_Studio_Code>
  - Neovim <https://wiki.archlinux.org/index.php/Neovim>
  - Git <https://wiki.archlinux.org/index.php/Git>
  - Pip <https://wiki.archlinux.org/index.php/Python>
- Window Manager
  - Autorandr <https://github.com/phillipberndt/autorandr>
  - i3 <https://wiki.archlinux.org/index.php/I3>
  - GTK <https://wiki.archlinux.org/index.php/GTK>
  - Mime <https://wiki.archlinux.org/index.php/XDG_MIME_Applications>
  - Notification Daemon <https://wiki.archlinux.org/index.php/Desktop_notifications>
  - Pam <https://wiki.archlinux.org/index.php/PAM>
  - Ranger <https://wiki.archlinux.org/index.php/Ranger>
  - SSH agent <https://wiki.archlinux.org/index.php/SSH_keys>

## Install

All the required packages are listed in the `pkglist.txt` file (archlinux).
You can comment any package from the file to skip its install.

```bash
# Install all required archlinux packages
./exec_pacman.sh
```

## Sync

I use GNU Stow to synchronize the settings.
Each package in `src` is organized the same way it lives on the local computer.
(I saw other interesting techniques with git config. see links).

```bash
# Apply all symlinks
./exec_stow.sh
```

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
