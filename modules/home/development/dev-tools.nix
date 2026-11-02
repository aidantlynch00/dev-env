{
  flake.homeModules.dev-tools = { pkgs, ... }: {
    home.packages = with pkgs; [
      just
      lazygit
    ];
  };
}
