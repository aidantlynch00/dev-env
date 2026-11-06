{ config, lib, inputs, self, ... }:
let
  system = builtins.head config.systems;
in
{
  flake.homeConfigurations."alynch@alynch-ud1" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with self.homeModules; [
      work
      alynch
      alynch-ud1
    ];
  };

  flake.homeModules."alynch-ud1" = { config, ... }: {
    programs.git.settings.user = {
      name = lib.mkForce "Aidan Lynch";
      email = lib.mkForce "Aidan.Lynch@intusurg.com";
    };

    home.sessionPath = [ "$HOME/.local/bin" ];
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
