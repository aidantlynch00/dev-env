{
  flake.homeModules.bash = {
    programs.bash = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        lg = "lazygit";
      };

      initExtra = ''
        if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
          source "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi

        for script in $HOME/.bashrc.d/*; do
          if [ -x "$script" ]; then
            source $script
          fi
        done
      '';
    };
  };
}
