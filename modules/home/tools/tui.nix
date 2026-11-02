{
  flake.homeModules.tui = { pkgs, ... }: {
    home.packages = with pkgs; [
      caligula
      lazygit
      slides
    ];
  };
}
