{ inputs, ... }:
{
  flake.homeModules.zestty = { config, pkgs, ... }:
  let
    zestty = inputs.zestty.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in
  {
    home.packages = [
      zestty
    ];

    home.file.".local/bin/zestty.wasm" = {
      source = "${zestty}/bin/zestty.wasm";
      executable = true;
    };

    home.sessionVariables = {
      "ZESTTY_DELIM" = "$'\t'";
      "ZESTTY_PROJECT_DELIM" = ":";
      "ZESTTY_PLUGIN_URL" = "file:${config.xdg.binHome}/zestty.wasm";
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
