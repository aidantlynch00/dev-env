{ self, ... }: {
  flake.homeModules.dev-tools = { pkgs, ... }: {
    imports = with self.homeModules; [
      git
      nvim
      zellij
    ];

    home.packages = with pkgs; [
      just
      lazygit
    ];
  };
}
