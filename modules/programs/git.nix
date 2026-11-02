{
  flake.homeModules.git = { config, lib, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings.user = {
        name = "Aidan Lynch";
        email = "aidantlynch00@gmail.com";
      };
    };

    programs.difftastic = {
      enable = true;
      git = {
        enable = true;
        mode = "external";
      };
    };
  };
}
