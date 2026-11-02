{ self, ... }:
{
  flake.homeModules.development = { pkgs, ...}: {
    imports = with self.homeModules; [
      languages
    ];

    home.packages = with pkgs; [
      lazygit
    ];
  };
}
