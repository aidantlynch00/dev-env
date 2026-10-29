{
  flake.homeModules.yazi = { config, lib, ... }: let
    filePath = "${config.home.homeDirectory}/.dev-env/files/yazi";
  in
  {
    programs.yazi.enable = true;

    xdg.configFile."yazi" = {
      source = lib.file.mkOutOfStoreSymlink "${filePath}/.config/yazi";
    };

    home.shellAliases.y = "yazi";
    home.file.".bashrc.d/yazi.sh" = {
      executable = true;
      text = ''
        yd() {
          set -- "$@" --cwd-file "$(mktemp -t yazi-cwd.XXXXXX)"
          command yazi "$@"
          shift $(($# - 1))
          set -- "$(command cat < "$1"; printf .; rm -f -- "$1")"
          set -- "$${1%.}"
          [ -n "$1" ] && [ "$1" != "$PWD" ] && command cd -- "$1"
        }
      '';
    };
  };
}
