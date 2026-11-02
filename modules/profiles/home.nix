{ config, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeConfigurations.home = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with self.homeModules; [
      core
      development
      tui
      cli
      alynch
      ghostty
      fastfetch
      git
      nvim
      opencode
      starship
      yazi
      zellij
      bash
    ];
  };
}
