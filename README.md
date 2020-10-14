# My personal settings

These are the common settings I use daily.
Feel free to use any of them.

## Features

- Console
    - Alacritty
    - Terminator (but I mostly use urxvt)
    - Urxvt
    - Zsh
    - Bash (but I mostly use zsh)
    - X11
- Programming
    - Vscode
    - Neovim
    - Git
    - Pip
- WM
    - i3
    - GTK
    - Mime
    - Picom
    - Ranger

## Sync

I use GNU Stow to synchronize the settings.
Each package in `src` is organized the same way it lives on the local computer.
(I saw other interesting techniques with git config. see link).

```bash
# Apply all symlinks
./exec_stow.sh
```

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
