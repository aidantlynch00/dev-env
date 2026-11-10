{
  flake.homeModules.nvim = { config, pkgs, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/nvim";
  in
  {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      viAlias = true;
      vimAlias = true;
      sideloadInitLua = true;
    };

    home.packages = with pkgs; [
      tree-sitter
      dotnet-sdk
      nodejs
    ];

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/nvim";
    };

    home.sessionVariables.EDITOR = "nvim";
  };
}
