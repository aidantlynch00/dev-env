{ config, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeConfigurations."alynch@chicane" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with self.homeModules; [
      alynch
      full
      chicane
    ];
  };

  flake.homeModules.chicane = { };
}
