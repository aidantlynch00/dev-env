{ self, ... }:
{
  flake.homeModules.core = {
    imports = with self.homeModules; [
      scripts
      fonts
      xdg
    ];

    programs.home-manager.enable = true;

    home.stateVersion = "26.05";
  };
}
