{
  flake.homeModules.fastfetch = { config, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/fastfetch";
  in
  {
    programs.fastfetch.enable = true;

    xdg.configFile."fastfetch/config.jsonc" = {
      source = ./config.jsonc;
    };
  };
}
