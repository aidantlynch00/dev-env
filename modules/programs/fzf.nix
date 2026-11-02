{
  flake.homeModules.fzf = {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      historyWidget.bash.options = [ "--height 7" ];
    };
  };
}
