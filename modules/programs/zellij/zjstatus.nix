{ inputs, ... }:
{
  flake.homeModules.zjstatus = { pkgs, ... }: let
    zjstatus = inputs.zjstatus.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in
  {
    home.packages = [
      zjstatus
    ];

    home.file.".local/bin/zjstatus.wasm" = {
      source = "${zjstatus}/bin/zjstatus.wasm";
      executable = true;
    };
  };
}
