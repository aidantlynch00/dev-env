# .bashrc

STARSHIP_DIR=$HOME/.config/starship
if [ "$ZELLIJ" = "0" ]; then
    export STARSHIP_CONFIG=$STARSHIP_DIR/short.toml
else
    export STARSHIP_CONFIG=$STARSHIP_DIR/default.toml
fi

eval "$(starship init bash)"
