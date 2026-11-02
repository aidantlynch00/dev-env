{ config, lib, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeConfigurations."alynch@alynch-ud1" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with self.homeModules; [
      work
      alynch
      {
        programs.git.settings.user = {
          name = lib.mkForce "Aidan Lynch";
          email = lib.mkForce "Aidan.Lynch@intusurg.com";
        };
      }
    ];
  };
}
