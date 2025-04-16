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
install_scripts=1
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
            echo "  --scripts                     install custom scripts"
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
        --scripts)
            install_scripts=0
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
            install_scripts=0
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

check_bashrc() {
    RC_DIR="$USER_HOME/.bashrc.d"
    if ! [ -d $RC_DIR ]; then
        mkdir $RC_DIR
        chown "$REAL_USER:$REAL_USER" $RC_DIR
    fi
}

cp_bin() {
    target=$1
    dest=$2
    [ -n "$3" ] && user=$3 || user=$REAL_USER

    cp -fT $target $dest
    chmod 755 $dest
    chown "$user:$user" $dest
}

cp_dir() {
    target=$1
    dest=$2
    [ -n "$3" ] && user=$3 || user=$REAL_USER

    cp -rfT $target $dest
    chown -R "$user:$user" $dest
}

TMP_DIR="/tmp"
download() {
    url=$1
    filename=$(basename $url)

    # download the file
    file="$TMP_DIR/$filename"
    wget --quiet --output-document="$file" "$url"
    echo "$file"
}

extract_tar() {
    tar_file=$1
    filename=$(basename $tar_file)

    # create a temporary directory to extract to
    tmp_dir=$(mktemp --tmpdir="$TMP_DIR" --directory "tar_XXXXXX")

    # extract the archive given the compression used
    if echo "$filename" | grep -q ".tar.gz"; then
        tar --directory "$tmp_dir" -xzf "$tar_file"
    elif echo "$filename" | grep -q ".tar.xz"; then
        tar --directory "$tmp_dir" -xJf "$tar_file"
    else
        tar --directory "$tmp_dir" -xf "$tar_file"
    fi

    rm -f "$tar_file"
    echo "$tmp_dir"
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
    BIN_PATH="/usr/bin/lazygit"
    if ! [ -e "$BIN_PATH" ]; then
        release=$(download "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz")
        extract_dir=$(extract_tar $release)
        cp_bin "$extract_dir/lazygit" "$BIN_PATH" "root"
        rm -rf --preserve-root "$extract_dir"
    else
        echo "lazygit already installed!"
    fi
fi

if [ $install_scripts = 0 ]; then
    echo "Installing scripts..."

    DEV_SCRIPTS_DIR="/usr/bin/scripts"
    mkdir -p "$DEV_SCRIPTS_DIR"
    for script in ./scripts/*; do
        filename=$(basename "$script")
        cp_bin "$script" "$DEV_SCRIPTS_DIR/$filename" "root"
    done

    check_bashrc
    cp_bin "./.bashrc.d/scripts.sh" "$USER_HOME/.bashrc.d/scripts.sh"
fi

# install ghostty
if [ $install_ghostty = 0 ]; then
    echo "Installing ghostty..."

    GHOSTTY_VERSION="1.1.2"
    BIN_PATH="/usr/bin/ghostty"
    ICON_PATH="/usr/share/icons/hicolor/256x256/apps/ghostty.png"

    # install latest ghostty appimage, note: this is an unofficial build of ghostty
    release=$(download "https://github.com/psadi/ghostty-appimage/releases/download/v$GHOSTTY_VERSION/Ghostty-$GHOSTTY_VERSION-x86_64.AppImage")
    cp_bin "$release" "$BIN_PATH" "root"
    rm -f "$release"

    # download the ghostty icon for the desktop application
    icon=$(download "https://raw.githubusercontent.com/ghostty-org/ghostty/main/images/icons/icon_256.png")
    mv -f "$icon" "$ICON_PATH"

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
    cp_dir "./.config/ghostty" "$USER_HOME/.config/ghostty"
fi

# install neovim
if [ $install_nvim = 0 ]; then
    # install neovim appimage
    echo "Installing neovim..."

    # download AppImage, move and make executable
    BIN_PATH="/usr/bin/nvim"
    release=$(download "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage")
    cp_bin "$release" "$BIN_PATH" "root"
    rm -f "$release"
fi

if [ $install_nvim_config = 0 ]; then
    # install neovim config
    echo "Removing existing neovim config..."
    rm -rf "$USER_HOME/.config/nvim"

    echo "Installing neovim config..."
    cp_dir "./.config/nvim" "$USER_HOME/.config/nvim"

    # install neovim bash environment
    check_bashrc
    cp_bin "./.bashrc.d/nvim.sh" "$USER_HOME/.bashrc.d/nvim.sh"
fi

# install zellij
if [ $install_zellij = 0 ]; then
    echo "Installing zellij and plugins..."

    release=$(download "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz")
    extract_dir=$(extract_tar $release)
    cp_bin "$extract_dir/zellij" "/usr/bin/zellij" "root"
    rm -rf --preserve-root "$extract_dir"

    # create plugins directory
    PLUGIN_DIR="$USER_HOME/.config/zellij/plugins"
    if ! [ -e "$PLUGIN_DIR" ] || ! [ -d "$PLUGIN_DIR" ]; then
        mkdir -p "$PLUGIN_DIR"
        chown "$REAL_USER:$REAL_USER" "$PLUGIN_DIR"
    fi

    # install plugins
    while read -r url; do
        plugin=$(download "$url")
        file="$PLUGIN_DIR/$(basename $plugin)"
        cp_bin "$plugin" "$file"
        rm -f "$plugin"
    done << EOF
https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm
https://github.com/mostafaqanbaryan/zellij-switch/releases/latest/download/zellij-switch.wasm
EOF
fi

if [ $install_zellij_config = 0 ]; then
    # install zellij config, layouts and themes
    echo "Installing zellij config, layouts and themes..."
    cp_dir "./.config/zellij" "$USER_HOME/.config/zellij"

    # install zellij bash script
    check_bashrc
    cp_bin "./.bashrc.d/zellij.sh" "$USER_HOME/.bashrc.d/zellij.sh"
fi

if [ $install_starship = 0 ]; then
    # install latest starship release
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | \
        sh -s -- --bin-dir /usr/bin/ --force > /dev/null 2>&1

    # install bash script
    check_bashrc
    cp_bin "./.bashrc.d/starship.sh" "$USER_HOME/.bashrc.d/starship.sh"

    # install starship configs
    cp_dir "./.config/starship" "$USER_HOME/.config/starship"
fi

# install Hack nerd font
if [ $install_nerd_font = 0 ]; then
    if ! [ -d /usr/share/fonts/hack-nerd ]; then
        FONT_FOLDER="/usr/share/fonts/hack-nerd"
        file=$(download "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz")
        fonts=$(extract_tar $file)
        mkdir -p "$FONT_FOLDER"
        rm "$fonts"/*.md
        cp_dir "$fonts" "$FONT_FOLDER" "root"
        rm -rf --preserve-root "$fonts"
    else
        echo "Hack nerd font already installed!"
    fi
fi
