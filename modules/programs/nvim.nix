{ config, lib, ... }: let
  filePath = "${config.home.homeDirectory}/.dev-env/files/nvim";
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = lib.mkOutOfStoreSymlink "${filePath}/.config/nvim";
  };

  home.sessionVariables.EDITOR = "nvim";
}
