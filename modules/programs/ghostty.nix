{
  flake.homeModules.ghostty = { config, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/ghostty";
  in
  {
    programs.ghostty.enable = true;

    xdg.configFile."ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/ghostty";
    };
  };
}
