{ config, lib, ... }: let
  filePath = "${config.home.homeDirectory}/.dev-env/files/yazi";
in
{
  programs.yazi.enable = true;

  xdg.configFile."yazi" = {
    source = lib.mkOutOfStoreSymlink "${filePath}/.config/yazi";
  };
}
