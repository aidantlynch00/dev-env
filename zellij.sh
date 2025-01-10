# .bashrc
ZELLIJ_PROJECT_FILE=~/.zellij_projects.csv
if ! [ -f $ZELLIJ_PROJECT_FILE ]; then
    touch $ZELLIJ_PROJECT_FILE
fi

zj() {
    input_id=$1
    use_id=""
    use_path=""
    use_layout=""

    # try to match the first argument with a known project
    if [ -n "$input_id" ]; then
        while IFS="," read -r id path layout; do
            if [ "$id" = "$input_id" ]; then
                use_id=$id
                use_path=$path
                use_layout=$layout
            fi
        done < $ZELLIJ_PROJECT_FILE
    fi

    if [ -n "$use_id" ]; then
        pushd $use_path > /dev/null

        # attach to an existing project session if it exists, otherwise create
        # a new one with the project ID as the session name
        if zellij list-sessions 2> /dev/null | awk '{ print $1 }' | grep -q "$use_id"; then
            zellij attach --force-run-commands "$use_id"
        elif [ -n "$use_layout" ]; then
            zellij --session "$use_id" --new-session-with-layout "$use_layout"
        else
            zellij --session "$use_id"
        fi

        popd > /dev/null
    else
        # in the default case, pass all parameters to zellij
        zellij "$@"
    fi
}
