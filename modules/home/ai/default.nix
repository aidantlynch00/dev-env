{ self, ... }:
{
  flake.homeModules.ai = {
    imports = with self.homeModules; [
      opencode
    ];
  };
}
