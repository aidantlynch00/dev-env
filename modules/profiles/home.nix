{ self, inputs, ... }:
{
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
