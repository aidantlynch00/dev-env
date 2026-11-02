{ self, ... }:
{
  flake.homeModules.zellij = { config, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/zellij";
  in
  {
    imports = with self.homeModules; [
      zestty
    ];

    programs.zellij.enable = true;

    xdg.configFile."zellij" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/.config/zellij";
    };

    home.shellAliases.zj = "zellij";
  };
}
