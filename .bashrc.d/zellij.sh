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

        # Attach to an existing project session if it exists and is running.
        # If a session is dead it will be deleted and a new one will be started.
        # Otherwise create a new one with the project ID as the session name.
        new_session=1
        session=$(zellij list-sessions 2> /dev/null | grep "$id")
        if [ -z "$session" ]; then
            new_session=0
        elif echo "$session" | grep -q "EXITED"; then
            new_session=0
            zellij delete-session "$id" > /dev/null
        fi

        if [ $new_session -eq 1 ]; then
            zellij attach "$id"
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
