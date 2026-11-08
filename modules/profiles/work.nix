{ config, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeModules.work = {
    imports = with self.homeModules; [
      core
      development
      ghostty
      terminal
    ];
  };
}
