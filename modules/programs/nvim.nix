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
      defaultEditor = true;
      sideloadInitLua = true;
    };

    home.packages = with pkgs; [
      tree-sitter
      dotnet-sdk_11
      nodejs
    ];

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/nvim";
    };
  };
}
