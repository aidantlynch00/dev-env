{ self, ... }:
{
  flake.homeModules.graphical = {
    imports = with self.homeModules; [
      foot
      ghostty
      mango
    ];
  };
}
