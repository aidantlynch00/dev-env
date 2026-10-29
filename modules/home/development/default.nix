{ self, pkgs, ... }:
{
  flake.homeModules.development = {
    imports = with self.homeModules; [
      languages
    ];
  };
}
