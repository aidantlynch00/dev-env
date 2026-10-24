{ self, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations.home = inputs.home-manager.lib.homeManagerConfiguration {
    modules = with self.homeModules; [
      core
      ghostty
      fastfetch
      git
      nvim
      starship
      yazi
      zellij
      bash
    ];
  };
}
