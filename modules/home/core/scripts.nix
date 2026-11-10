{ lib, ... }: let
  scripts = builtins.readDir ./scripts;
in {
  flake.homeModules.scripts = {
    xdg.localBinInPath = true;
    home.file = lib.mapAttrs' (name: _: lib.nameValuePair ".local/bin/${name}" {
      source = ./scripts/${name};
      executable = true;
    }) scripts;
  };
}
