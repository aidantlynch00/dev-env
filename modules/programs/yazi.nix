{
  flake.homeModules.yazi = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/yazi";
  in
  {
    programs.yazi.enable = true;

    xdg.configFile."yazi" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.config/yazi";
    };

    home.file.".bashrc.d/yazi.sh" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.bashrc.d/yazi.sh";
      executable = true;
    };
  };
}
