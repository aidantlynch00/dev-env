{
  flake.homeModules.zestty = {
    home.sessionVariables = {
      "ZESTTY_DELIM" = "$'\t'";
      "ZESTTY_PROJECT_DELIM" = ":";
      "ZESTTY_PLUGIN_URL" = "file:";
    };

    home.shellAliases = {
      zc = "zestty create";
      za = "zestty attach";
      zz = "zestty pick zellij";
      zp = "zestty pick projects";
      zw = "zestty pick worktrees";
      zs = "zestty pick submodules";
    };
  };
}
