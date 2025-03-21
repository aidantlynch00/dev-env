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
install_ghostty=1
install_ghostty_config=1
install_nvim=1
install_nvim_config=1
install_zellij=1
install_zellij_config=1
install_starship=1
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
            echo "  --ghostty                     install ghostty"
            echo "  --ghostty-config              install ghostty configurations and themes"
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
        --ghostty)
            install_ghostty=0
            ;;
        --ghostty-config)
            install_ghostty_config=0
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
        --starship)
            install_starship=0
            ;;
        --nerd-font)
            install_nerd_font=0
            ;;
        --all)
            install_packages=0
            install_ghostty=0
            install_ghostty_config=0
            install_nvim=0
            install_nvim_config=0
            install_zellij=0
            install_zellij_config=0
            install_starship=0
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
    wget --quiet --output-document="$tar_file" "$url"

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
    mv -f $target "$dest"

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
                        fastfetch \
                        ripgrep fzf \
                        sqlite sqlite-devel \
                        python pip \
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

# install ghostty
if [ $install_ghostty = 0 ]; then
    echo "Installing ghostty..."

    # install latest ghostty appimage, note: this is an unofficial build of ghostty
    GHOSTTY_VERSION="1.1.2"
    wget --quiet "https://github.com/psadi/ghostty-appimage/releases/download/v$GHOSTTY_VERSION/Ghostty-$GHOSTTY_VERSION-x86_64.AppImage"

    # move appimage to standard path and make executable
    BIN_PATH="/usr/bin/ghostty"
    mv "Ghostty-$GHOSTTY_VERSION-x86_64.AppImage" $BIN_PATH
    chmod 755 $BIN_PATH

    # download the ghostty icon for the desktop application
    ICON_PATH="/usr/share/icons/hicolor/256x256/apps/ghostty.png"
    wget --quiet "https://raw.githubusercontent.com/ghostty-org/ghostty/main/images/icons/icon_256.png" \
        --output-document=$ICON_PATH

    # create a .desktop file for ghostty
    cat > /usr/share/applications/ghostty.desktop << EOF
[Desktop Entry]
Type=Application

Name=Ghostty
Comment=Ghostty
Exec=$BIN_PATH
Icon=$ICON_PATH
EOF
fi

# install ghostty config and themes
if [ $install_ghostty_config = 0 ]; then
    echo "Installing ghostty config and themes..."

    # install ghostty config directory
    cp -r ./.config/ghostty $USER_HOME/.config/
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.config/ghostty
fi

# install neovim
if [ $install_nvim = 0 ]; then
    # install neovim appimage
    echo "Installing neovim..."
    wget --quiet "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
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
    # install zellij config, layouts, plugins and themes
    echo "Installing zellij config, layouts, plugins, and themes..."
    cp -r ./.config/zellij $USER_HOME/.config/
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.config/zellij

    # create plugins directory
    PLUGIN_DIR="$USER_HOME/.config/zellij/plugins"
    mkdir -p $PLUGIN_DIR

    # install plugins
    ZJSTATUS_FILE="$PLUGIN_DIR/zjstatus.wasm"
    wget --quiet "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" \
        --output-document=$ZJSTATUS_FILE
    chmod +x $ZJSTATUS_FILE

    # make sure plugins directory is owned by user
    chown -R "$REAL_USER:$REAL_USER" $PLUGIN_DIR

    # install zellij bash script
    mkdir -p $USER_HOME/.bashrc.d
    cp ./.bashrc.d/zellij.sh $USER_HOME/.bashrc.d/
    chmod +x $USER_HOME/.bashrc.d/zellij.sh
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.bashrc.d
fi

if [ $install_starship = 0 ]; then
    # install latest starship release
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | \
        sh -s -- --bin-dir /usr/bin/ --force > /dev/null 2>&1

    # install bash script
    cp ./.bashrc.d/starship.sh $USER_HOME/.bashrc.d/
    chmod +x $USER_HOME/.bashrc.d/starship.sh
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.bashrc.d

    # install starship configs
    cp -r ./.config/starship $USER_HOME/.config/
    chown -R "$REAL_USER:$REAL_USER" $USER_HOME/.config/starship
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
