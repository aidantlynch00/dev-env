{
  flake.homeModules.fzf = {
    programs.fzf.enable = true;

    home.sessionVariables."FZF_CTRL_R_OPTS" = "--height 7";
    home.file.".bashrc.d/fzf.sh" = {
      executable = true;
      text = ''
        eval "$(fzf --bash)"
      '';
    };
  };
}
