{ self, ... }:
{
  flake.homeModules.core = {
    imports = with self.homeModules; [
      fonts
      nix
      scripts
      xdg
    ];

    programs.home-manager.enable = true;

    home.stateVersion = "26.05";
  };
}
