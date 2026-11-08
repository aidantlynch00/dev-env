{ self, ... }:
{
  flake.homeModules.tui = { pkgs, ... }: {
    imports = with self.homeModules; [
      yazi
    ];

    home.packages = with pkgs; [
      caligula
      lazygit
      slides
    ];
  };
}
