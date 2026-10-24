{
  flake.homeModules.git = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/git";
  in
  {
    # programs.git = {
    #   enable = true;
    #   userName = "alynch";
    #   userEmail = "alynch@example.com";
    # };

    home.file.".gitconfig" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.gitconfig";
    };
  };
}
