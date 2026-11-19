{ inputs, ... }: {
  flake.homeModules.noctalia = { pkgs, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      extraPackages = [ pkgs.gpu-screen-recorder pkgs.slurp ];

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Tokyo Night";
        };

        plugins = {
          enabled = [ ];
          source = [
            {
              name = "official";
              kind = "path";
              location = "${inputs.noctalia-plugins}";
              enabled = true;
            }
          ];
        };
      };
    };
  };
}
