{ self, ... }:
{
  flake.homeModules.core = {
    imports = with self.homeModules; [
      xdg
      fonts
    ];

    programs.home-manager.enable = true;

    home.stateVersion = "26.05";
  };
}
