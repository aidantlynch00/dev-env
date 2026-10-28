{
  flake.homeModules.git = { config, lib, ... }: {
    programs.git = {
      enable = true;
      userName = "Aidan Lynch";
      userEmail = "aidantlynch00@gmail.com";
    };
  };
}
