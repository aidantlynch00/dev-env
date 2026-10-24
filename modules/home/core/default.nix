{
  flake.homeModules.core = { pkgs, ... }: {
    home.stateVersion = "26.05";
    home.username = "alynch";
    home.homeDirectory = "/home/alynch";

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

    # XDG
    xdg.enable = true;

    # Fonts
    fonts.fonts = with pkgs; [
      nerd-fonts-hack
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
