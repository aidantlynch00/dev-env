{
  flake.homeModules.fzf = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/fzf";
  in
  {
    programs.fzf.enable = true;

    home.file.".bashrc.d/fzf.sh" = {
      source = lib.file.mkOutOfStoreSymlink "${filePath}/.bashrc.d/fzf.sh";
      executable = true;
    };
  };
}
