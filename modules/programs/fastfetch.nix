{
  flake.homeModules.fastfetch = { config, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/fastfetch";
  in
  {
    programs.fastfetch.enable = true;

    xdg.configFile."fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/fastfetch";
    };
  };
}
