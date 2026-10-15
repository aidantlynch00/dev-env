{ config, pkgs, inputs, ... }:
{
  home.stateVersion = "26.05";
  home.username = "alynch";
  home.homeDirectory = "/home/alynch";

  # Import all dev-env home-manager modules (programs enabled by default)
  imports = [
    inputs.dev-env.flake.modules.homeManager.ghostty
    inputs.dev-env.flake.modules.homeManager.fastfetch
    inputs.dev-env.flake.modules.homeManager.git
    inputs.dev-env.flake.modules.homeManager.nvim
    inputs.dev-env.flake.modules.homeManager.starship
    inputs.dev-env.flake.modules.homeManager.yazi
    inputs.dev-env.flake.modules.homeManager.zellij
  ];

  # Git user info (override in machine-specific config if needed)
  programs.git.userName = "alynch";
  programs.git.userEmail = "alynch@example.com";

  # Core packages
  home.packages = with pkgs; [
    # Language runtimes (replacing mise)
    nodejs_20
    python3
    rustup
    go
    jdk21
  ];

  # Shell
  programs.bash.enable = true;

  # XDG
  xdg.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [
    nerd-fonts-hack
    noto-fonts
    noto-fonts-emoji
  ];
}
