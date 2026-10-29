{ self, config, lib, ... }:
{
  flake.homeModules.zellij = let
    filePath = "${config.home.homeDirectory}/.dev-env/files/zellij";
  in
  {
    imports = with self.homeModules; [
      zestty
    ];

    programs.zellij.enable = true;

    xdg.configFile."zellij" = {
      source = lib.mkOutOfStoreSymlink "${filePath}/.config/zellij";
    };

    home.shellAliases.zj = "zellij";
  };
}
