#!/bin/sh

# flags for installation options
install_scripts=1
install_nerd_font=1

# other options
while [ "$#" -gt 0 ]; do
    case $1 in
        --help)
            echo "install.sh [OPTIONS]"
            echo "  --help                        show this message"
            echo "  --scripts                     install custom scripts"
            echo "  --nerd-font                   install nerd font"
            echo "  --all                         install everything"
            exit
            ;;
        --scripts)
            install_scripts=0
            ;;
        --nerd-font)
            install_nerd_font=0
            ;;
        --all)
            install_scripts=0
            install_nerd_font=0
            ;;
    esac

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

if [ $install_scripts = 0 ]; then
    echo "Installing scripts..."

    DEV_SCRIPTS_DIR="/usr/bin/scripts"
    SOURCE_SCRIPTS_DIR="./scripts"
    scripts=$(find "$SOURCE_SCRIPTS_DIR" -type f | sed "s;^${SOURCE_SCRIPTS_DIR}/;;")
    for script in $scripts; do
        dir=$(dirname "$script")
        mkdir -p "$DEV_SCRIPTS_DIR/$dir"

        filename=$(basename "$script")
        cp_bin "$SOURCE_SCRIPTS_DIR/$script" "$DEV_SCRIPTS_DIR/$script" "root"
    done

    check_bashrc
    cp_bin "./.bashrc.d/scripts.sh" "$USER_HOME/.bashrc.d/scripts.sh"
fi

# install Hack nerd font
if [ $install_nerd_font = 0 ]; then
    FONT_FOLDER="$USER_HOME/.local/share/fonts/hack-nerd"
    if ! [ -d "$FONT_FOLDER" ]; then
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
