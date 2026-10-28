{ self, ... }:
{
  flake.homeModules.core = { pkgs, ... }: {
    imports = with self.homeModules; [
      xdg
      fonts
    ];

    home.stateVersion = "26.05";
  };
}
