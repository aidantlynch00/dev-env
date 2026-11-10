{ inputs, ... }:
{
  flake.homeModules.zestty = { pkgs, ... }:
  let
    zestty = inputs.zestty.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in
  {
    home.packages = [
      zestty
    ];

    home.sessionVariables = {
      "ZESTTY_DELIM" = "$'\t'";
      "ZESTTY_PROJECT_DELIM" = ":";
      "ZESTTY_PLUGIN_URL" = "file:${zestty}/bin/zestty.wasm";
    };

    home.shellAliases = {
      zc = "zestty create";
      za = "zestty attach";
      zz = "zestty pick zellij";
      zp = "zestty pick projects";
      zw = "zestty pick worktrees";
      zs = "zestty pick submodules";
    };
  };
}
