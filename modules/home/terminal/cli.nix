{ self, ... }:
{
  flake.homeModules.cli = { pkgs, ... }: {
    imports = with self.homeModules; [
      fzf
    ];

    home.packages = with pkgs; [
      bat
      duf
      dust
      just
      ripgrep
      skim
      tldr
      yq
    ];
  };
}
