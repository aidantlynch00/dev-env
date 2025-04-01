# .bashrc
ZELLIJ_PROJECT_FILE=~/.zellij_projects.csv
if ! [ -f $ZELLIJ_PROJECT_FILE ]; then
    touch $ZELLIJ_PROJECT_FILE
fi

alias zj="zellij"

if [ "$ZELLIJ" = "0" ]; then
    _zellij_switch_session() {
        name=$1
        path=$2
        layout=$3

        options="--session $name"
        [ -n "$path" ] && [ -d "$path" ] && options="$options --cwd $path"
        [ -n "$layout" ] && options="$options --layout $layout"

        zellij pipe --plugin zellij-switch -- "$options"
    }

    _create_session() {
        _zellij_switch_session $@
    }

    _attach_session() {
        _zellij_switch_session $@
    }
else
    _create_session() {
        name=$1
        path=$2
        layout=$3

        [ -n "$path" ] && [ -d "$path" ] && pushd $path &> /dev/null

        if [ -n "$layout" ]; then
            zellij --session "$name" --new-session-with-layout "$layout"
        else
            zellij --session "$name"
        fi

        [ -n "$path" ] && [ -d "$path" ] && popd &> /dev/null
    }

    _attach_session() {
        name=$1

        zellij attach "$name"
    }
fi

_open_session() {
    project=$1
    name=$2
    path=$3
    layout=$4

    # Attach to an existing project session if it exists and is running.
    # If a session is dead it will be deleted and a new one will be started.
    # Otherwise create a new one with the project ID as the session name.
    session_state="dne"
    session=$(zellij list-sessions --no-formatting 2> /dev/null | grep "$name")
    if echo "$session" | grep -q "EXITED"; then
        session_state="dead"
    elif [ -n "$session" ]; then
        session_state="active"
    fi

    case $session_state in
        "dne")
            if [ "$project" = "0" ]; then
                _create_session "$name" "$path" "$layout"
            fi
            ;;
        "dead")
            if [ "$project" = "0" ]; then
                zellij delete-session "$name" > /dev/null
                _create_session "$name" "$path" "$layout"
            else
                _attach_session "$name"
            fi
            ;;
        "active")
            _attach_session "$name"
            ;;
    esac
}

zs() {
    project_list=$(cat $ZELLIJ_PROJECT_FILE)
    active_list=$(zellij list-sessions --no-formatting --short)

    name=$(
        printf "$project_list\n$active_list" |
        cut --delimiter "," --fields "1" |
        sort -u |
        fzf --query="$1" \
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
            --color=separator:#2ac3de
    )

    if [ -n "$name" ]; then
        project_line=$(echo "$project_list" | grep "$name," | head -n1)
        if [ -n "$project_line" ]; then
            IFS="," read -r name path layout < <(echo "$project_line")
            _open_session 0 $name $path $layout
        else
            _open_session 1 $name
        fi
    else
        echo "No session selected!"
    fi
}
