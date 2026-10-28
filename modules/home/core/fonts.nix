{
  flake.homeModules.fonts = { pkgs, ... }: {
    fonts.fonts = with pkgs; [
      nerd-fonts-hack
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
