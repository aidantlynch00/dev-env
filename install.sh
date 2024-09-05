#!/bin/sh

# include the setup script as a step in .bashrc
[ -f ~/.setup.sh ] || cp setup.sh ~/.setup.sh

setup_step="source ~/.setup.sh"
if ! grep -q -x "$setup_step" ~/.bashrc; then
    echo "$setup_step" >> ~/.bashrc
fi

# install packages, depending on the package manager in use
if [ -n "$(which dnf)" ]; then
    dnf install ripgrep
fi

# install neovim
if [ -n "$(which nvim)" ] && ! [ -e /usr/bin/nvim ]; then
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    mv nvim.appimage /usr/bin/nvim
    chmod 755 /usr/bin/nvim
fi
