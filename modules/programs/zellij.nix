{
  flake.homeModules.zellij = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/zellij";
  in
  {
    programs.zellij.enable = true;

    xdg.configFile."zellij" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.config/zellij";
    };

    home.shellAliases.zj = "zellij";
  };
}
