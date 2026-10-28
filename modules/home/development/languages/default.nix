{
  flake.homeModules.languages = { pkgs, ... }: {
    home.packages = with pkgs; [
      nodejs_20
      python3
      rustup
      jdk21
    ];
  };
}
