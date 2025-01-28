# .bashrc
ZELLIJ_PROJECT_FILE=~/.zellij_projects.csv
if ! [ -f $ZELLIJ_PROJECT_FILE ]; then
    touch $ZELLIJ_PROJECT_FILE
fi

alias zj="zellij"

fp() {
    read -r id path layout < <(\
        cat $ZELLIJ_PROJECT_FILE | \
        tr "," " " | \
        fzf --delimiter=" " \
            --nth=1 \
            --with-nth=1 \
            --query="$1" \
            --no-multi \
            --cycle \
            --select-1 \
            --height=7 \
            --layout=reverse \
            --color=fg:#c0caf5 \
            --color=gutter:-1 \
            --color=header:#ff9e64 \
            --color=hl+:#2ac3de \
            --color=hl:#2ac3de \
            --color=info:#545c7e \
            --color=marker:#ff007c \
            --color=pointer:#ff007c \
            --color=prompt:#2ac3de \
            --color=query:#c0caf5:regular \
            --color=separator:#2ac3de \
    )

    if [ -n "$id" ]; then
        pushd $path > /dev/null

        # attach to an existing project session if it exists, otherwise create
        # a new one with the project ID as the session name
        if zellij list-sessions 2> /dev/null | awk '{ print $1 }' | grep -q "$id"; then
            zellij attach --force-run-commands "$id"
        elif [ -n "$layout" ]; then
            zellij --session "$id" --new-session-with-layout "$layout"
        else
            zellij --session "$id"
        fi

        popd > /dev/null
    else
        echo "No project selected!"
    fi
}
