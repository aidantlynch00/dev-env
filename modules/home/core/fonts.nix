{
  flake.homeModules.fonts = { pkgs, ... }: {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      nerd-fonts.hack
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
