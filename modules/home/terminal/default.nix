{ self, ... }:
{
  flake.homeModules.terminal = {
    imports = with self.homeModules; [
      cli
      shell
      tui
    ];
  };
}
