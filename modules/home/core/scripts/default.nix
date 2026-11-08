{
  flake.homeModules.scripts = {
    xdg.localBinInPath = true;
    home.file.".local/bin/reload-hm-vars" = {
      source = ./reload-hm-vars;
      executable = true;
    };
  };
}
