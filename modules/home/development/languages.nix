{
  flake.homeModules.languages = { pkgs, ... }: {
    home.packages = with pkgs; [
      nodejs
      python3
      rustup
      jdk21
    ];
  };
}
