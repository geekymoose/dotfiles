# My Linux dotfiles

My personal Archlinux configuration.
They are targeted for my use-cases, but feel free to use any of them.

## Features

- Alacritty <https://wiki.archlinux.org/title/alacritty>
- Bash <https://wiki.archlinux.org/title/bash>
- Dunst <https://wiki.archlinux.org/title/dunst>
- Git <https://wiki.archlinux.org/index.php/git>
- GTK <https://wiki.achlinux.org/index.php/gtk>
- Mime <https://wiki.archlinux.org/title/xdg_mime_applications>
- NeoVim <https://wiki.archlinux.org/index.php/neovim>
- Qt <https://wiki.archlinux.org/title/qt>
- Rofi <https://wiki.archlinux.org/title/rofi>
- Shell <https://wiki.archlinux.org/title/command-line_shell>
- SSH <https://wiki.archlinux.org/title/ssh_keys>
- Sway <https://swaywm.org>
- Vscode <https://code.visualstudio.com>
- Yazi <https://yazi-rs.github.io/docs/configuration/overview>
- Zed <https://zed.dev>
- Zsh <https://wiki.archlinux.org/title/zsh>

## Install

All the required packages are listed in the `pkglist_pacman.txt` file (Archlinux).
To skip a package, comment the line with `#`.
I use GNU Stow to synchronize the settings.
Each package in the `src` folder is organized the same way it lives on the local computer.

```sh
# Install all packages
sudo ./exec_pacman.sh

# Create all symlinks
./exec_stow.sh

# Setup neovim plugins
nvim # Then run :PlugInstall

# Install zsh oh-my-posh
git clone https://aur.archlinux.org/oh-my-posh.git
cd oh-my-posh
cat PKGBUILD # Check if the URLs are correct (for security check)
makepkg -sirc

# For Sway: set the backgrounds (replace your_bg_home with your value)
mkdir $HOME/.local/share/backgrounds
cp your_bg_home.jpg $/home/.local/share/backgrounds/home.jpg
cp your_bg_lock.png $/home/.local/share/backgrounds/lock.png

# Autostart the lemurs DisplayManager
systemctl enable lemurs
```

## Resources

I saw other interesting techniques with git config. For further information, see these links:

- <https://www.reddit.com/r/linux/comments/afund1/manage_your_dotfiles_with_style_gnu_stow/>
- <https://www.gnu.org/software/stow/>
- <https://www.atlassian.com/git/tutorials/dotfiles>
- <https://github.com/kazhala/dotbare>
