{
  flake.homeModules.ghostty = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/ghostty";
  in
  {
    programs.ghostty.enable = true;

    xdg.configFile."ghostty" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.config/ghostty";
    };
  };
}
