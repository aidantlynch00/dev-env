{ config, lib, ... }: let
  filePath = "${config.home.homeDirectory}/.dev-env/files/fastfetch";
in
{
  programs.fastfetch.enable = true;

  xdg.configFile."fastfetch" = {
    source = lib.mkOutOfStoreSymlink "${filePath}/.config/fastfetch";
  };
}
