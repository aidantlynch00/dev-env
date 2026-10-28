{
  flake.homeModules.git = { config, lib, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Aidan Lynch";
      userEmail = "aidantlynch00@gmail.com";
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
