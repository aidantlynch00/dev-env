{ inputs, ... }: {
  flake.homeModules.mango = {
    imports = [ inputs.mangowm.hmModules.mango ];

    wayland.windowManager.mango = {
      enable = true;
      systemd.enable = true;

      settings = {
        # Appearance
        border_radius = 8;
        border_px = 4;
        focused_opacity = 1.0;
        unfocused_opacity = 1.0;
        gap_inner_horizontal = 4;
        gap_inner_vertical = 4;
        gap_outer_horizontal = 8;
        gap_outer_vertical = 8;

        # Keyboard
        repeat_rate = 25;
        repeat_delay = 600;
        xkb_rules_layout = "us";

        # Layouts
        tag_num = 9;
        tag_rule = [
          "id:1,layout_name:scroller"
          "id:2,layout_name:scroller"
          "id:3,layout_name:scroller"
          "id:4,layout_name:scroller"
          "id:5,layout_name:scroller"
          "id:6,layout_name:scroller"
          "id:7,layout_name:scroller"
          "id:8,layout_name:scroller"
          "id:9,layout_name:scroller"
        ];

        # Key bindings
        bind = [
          "SUPER,1,view,1,0"
          "SUPER,2,view,2,0"
          "SUPER,3,view,3,0"
          "SUPER,4,view,4,0"
          "SUPER,5,view,5,0"
          "SUPER,6,view,6,0"
          "SUPER,7,view,7,0"
          "SUPER,8,view,8,0"
          "SUPER,9,view,9,0"
          "SUPER+CTRL,r,reload_config"
          "SUPER,Return,spawn,ghostty"
          "SUPER,q,killclient"
          "SUPER+CTRL,q,quit"
          "SUPER,Tab,focusstack,next"
          "SUPER+SHIFT,Left,move_client,left"
          "SUPER+SHIFT,Right,move_client,right"
          "SUPER+SHIFT,Up,move_client,up"
          "SUPER+SHIFT,Down,move_client,down"
        ];
      };
    };
  };
}
