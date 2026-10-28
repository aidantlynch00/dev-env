{ self, ... }:
{
  flake.homeModules.development = { pkgs, ... }: {
    imports = with self.homeModules; [
      languages
    ];
  };
}
