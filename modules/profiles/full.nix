{ config, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeModules.full = {
    imports = with self.homeModules; [
      core
      development
      graphical
      terminal
    ];
  };
}
