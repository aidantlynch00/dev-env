{ self, ... }:
{
  flake.homeModules.shell = {
    imports = with self.homeModules; [
      bash
      fastfetch
      starship
    ];
  };
}
