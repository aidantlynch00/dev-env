{ self, ... }:
{
  flake.homeModules.graphical = {
    imports = with self.homeModules; [
      ghostty
      mango
    ];
  };
}
