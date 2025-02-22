#!/bin/sh

# get info about the calling user
if [ "$(id -u)" = 0 ]; then
    REAL_USER="$SUDO_USER"
    USER_HOME=$(eval echo ~$SUDO_USER)
else
    REAL_USER="$USER"
    USER_HOME="$HOME"
fi

# flags for installation options
install_packages=1
install_nvim=1
install_nvim_config=1
install_zellij=1
install_zellij_config=1
install_nerd_font=1

# other options
get_package_manager=1
got_package_manager=1
package_manager=""

while [ "$#" -gt 0 ]; do
    case $1 in
        --help)
            echo "install.sh [OPTIONS]"
            echo "  --help                        show this message"
            echo "  --packages [package manager]  install dev packages uses the provided package manager (currently only dnf is supported)"
            echo "  --nvim                        install neovim"
            echo "  --nvim-config                 install neovim configurations"
            echo "  --zellij                      install zellij"
            echo "  --zellij-config               install zellij configurations, layouts, and themes"
            echo "  --nerd-font                   install the Hack nerd font"
            echo "  --all [package manager]       install everything"
            exit
            ;;
        --packages)
            install_packages=0
            get_package_manager=0
            ;;
        --nvim)
            install_nvim=0
            ;;
        --nvim-config)
            install_nvim_config=0
            ;;
        --zellij)
            install_zellij=0
            ;;
        --zellij-config)
            install_zellij_config=0
            ;;
        --nerd-font)
            install_nerd_font=0
            ;;
        --all)
            install_packages=0
            install_nvim=0
            install_nvim_config=0
            install_zellij=0
            install_zellij_config=0
            install_nerd_font=0
            get_package_manager=0
            ;;
    esac

    if [ $get_package_manager = 0 ] && ! [ $got_package_manager = 0 ]; then
        get_package_manager=1
        
        if [ "$#" -gt 1 ]; then
            shift
            package_manager=$1
            got_package_manager=0
        fi
    fi

    shift
done

# install files from a downloaded tar archive file
install_tar () {
    url=$1
    target=$2
    dest=$3
    tar_file=$(basename $url)

    # create a temp directory to download to
    mkdir -p /tmp/install_tar
    pushd /tmp/install_tar > /dev/null

    # download the tar file
    wget -O "$tar_file" "$url"

    # extract the archive given the compression used
    if echo "$tar_file" | grep -q ".tar.gz"; then
        tar -xzf "$tar_file"
    elif echo "$tar_file" | grep -q ".tar.xz"; then
        tar -xJf "$tar_file"
    else
        tar -xf "$tar_file"
    fi

    # install the target file to the destination
    mkdir -p "$dest"
    mv $target "$dest"

    # remove the temp directory
    popd > /dev/null
    rm -rf /tmp/install_tar
}

# install packages based on the package manager passed in
if [ $install_packages = 0 ]; then
    if [ -n "$package_manager" ]; then
        if [ -n "$(which $package_manager)" ]; then
            case $package_manager in
                dnf)
                    dnf --best install \
                        ripgrep fzf \
                        sqlite sqlite-devel \
                        -y
                    ;;
            esac
        else
            echo "$package_manager not executable!"
        fi
    else
        echo "Must pass in a package manager!"
    fi

    # install lazygit from precompiled binary
    if ! [ -e /usr/bin/lazygit ]; then
        install_tar \
            "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz" \
            "lazygit" \
            "/usr/bin/"
    else
        echo "lazygit already installed!"
    fi
fi

# install neovim
if [ $install_nvim = 0 ]; then
    # install neovim appimage
    echo "Installing neovim..."
    wget "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
    mv nvim.appimage /usr/bin/nvim
    chmod 755 /usr/bin/nvim
fi

if [ $install_nvim_config = 0 ]; then
    # install neovim config
    echo "Removing existing neovim config..."
    rm -rf $USER_HOME/.config/nvim
    echo "Installing neovim config..."
    cp -r ./.config/nvim $USER_HOME/.config/
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.config/nvim

    # install neovim bash environment
    mkdir -p $USER_HOME/.bashrc.d
    cp ./.bashrc.d/nvim.sh $USER_HOME/.bashrc.d/
    chmod +x $USER_HOME/.bashrc.d/nvim.sh
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.bashrc.d
fi

# install zellij
if [ $install_zellij = 0 ]; then
    echo "Installing zellij..."
    install_tar \
        "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" \
        "zellij" \
        "/usr/bin/"
fi

if [ $install_zellij_config = 0 ]; then
    # install zellij config, layouts, and themes
    echo "Installing zellij config, layouts, and themes..."
    cp -r ./.config/zellij $USER_HOME/.config/
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.config/zellij

    # install zellij bash script
    mkdir -p $USER_HOME/.bashrc.d
    cp ./.bashrc.d/zellij.sh $USER_HOME/.bashrc.d/
    chmod +x $USER_HOME/.bashrc.d/zellij.sh
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.bashrc.d
fi

# install Hack nerd font
if [ $install_nerd_font = 0 ]; then
    if ! [ -d /usr/share/fonts/hack-nerd ]; then
        install_tar \
            "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz" \
            "*.ttf" \
            "/usr/share/fonts/hack-nerd"
    else
        echo "Hack nerd font already installed!"
    fi
fi
