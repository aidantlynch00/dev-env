#.bashrc

export ZESTTY_DELIM=$'\t'
export ZESTTY_PROJECT_DELIM=":"
export ZESTTY_PLUGIN_URL="file:~/.tool-bin/wasm/zestty.wasm"

alias zc="zestty create"
alias za="zestty attach"

PICKER="$HOME/.tool-bin/current/bin/zestty pick"
alias zz="$PICKER zellij"
alias zp="$PICKER projects"
alias zw="$PICKER worktrees"
alias zs="$PICKER submodules"
