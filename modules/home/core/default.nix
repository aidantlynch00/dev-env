{ self, pkgs, ... }:
{
  flake.homeModules.core = {
    imports = with self.homeModules; [
      xdg
      fonts
    ];

    home.stateVersion = "26.05";
  };
}
