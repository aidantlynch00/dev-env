{ config, lib, ... }: let
  filePath = "${config.home.homeDirectory}/.dev-env/files/starship";
in
{
  programs.starship.enable = true;

  xdg.configFile."starship" = {
    source = lib.mkOutOfStoreSymlink "${filePath}/.config/starship";
  };
}
