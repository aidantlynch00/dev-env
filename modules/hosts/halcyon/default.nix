{ config, lib, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeConfigurations."alynch@halcyon" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with self.homeModules; [
      alynch
      full
      halcyon
    ];
  };

  flake.homeModules."halcyon" = { config, ... }: {
    home.sessionVariables."ZESTTY_PLUGIN_URL" = lib.mkForce "file:$HOME/.tool-bin/wasm/zestty.wasm";
    home.file.".local/bin/zestty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.tool-bin/current/bin/zestty";
    };

    targets.genericLinux = {
      enable = true;
      nixGL = {
        packages = inputs.nixgl.packages;
        defaultWrapper = "mesa";
        installScripts = [ "mesa" ];
      };
    };
  };
}
