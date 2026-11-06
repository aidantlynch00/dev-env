{
  flake.homeModules.ghostty = { config, pkgs, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/ghostty";
  in
  {
    programs.ghostty = {
      enable = true;
      package = (config.lib.nixGL.wrap pkgs.ghostty);
    };

    xdg.configFile."ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/ghostty";
    };
  };
}
