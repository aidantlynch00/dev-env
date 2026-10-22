{ config, lib, ... }: let
  filePath = "${config.home.homeDirectory}/.dev-env/files/fzf";
in
{
  programs.fzf.enable = true;

  home.file.".bashrc.d/fzf.sh" = {
    source = lib.mkOutOfStoreSymlink "${filePath}/.bashrc.d/fzf.sh";
    executable = true;
  };
}
