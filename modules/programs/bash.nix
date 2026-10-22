{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      lg = "lazygit";
    };

    shellInit = ''
      for script in $HOME/.bashrc.d/*; do
        if [ -x "$script" ]; then
          source $script
        fi
      done
    '';
  };
}
