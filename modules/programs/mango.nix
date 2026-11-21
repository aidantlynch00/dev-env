{ inputs, ... }: {
  flake.homeModules.mango = { config, pkgs, ... }:
  let
    mango = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
  in
  {
    imports = [ inputs.mangowm.hmModules.mango ];

    wayland.windowManager.mango = {
      enable = true;
      systemd.enable = true;
      package = (config.lib.nixGL.wrap mango);

      settings = {
        # Window Effects
        blur = 1;
        blur_layer = 0;
        blur_optimized = 1;
        blur_params = {
          num_passes = 1;
          radius = 5;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.2;
        };

        shadows = 0;
        layer_shadows = 0;
        shadow_only_floating = 1;
        shadows_size = 10;
        shadows_blur = 15;
        shadows_position_x = 0;
        shadows_position_y = 0;

        border = {
          radius = 8;
          px = 2;
        };
        no_radius_when_single = 0;
        focused_opacity = 0.95;
        unfocused_opacity = 0.95;

        # Animations (supported types: zoom, slide)
        animations = 1;
        layer_animations = 1;
        animation = {
          fade_in = 1;
          fade_out = 1;
          type = {
            open = "slide";
            close = "slide";
          };

          duration = {
            move = 200;
            open = 200;
            tag = 200;
            close = 200;
          };

          curve = {
            open = "0.46,1.0,0.29,1";
            move = "0.46,1.0,0.29,1";
            tag = "0.46,1.0,0.29,1";
            close = "0.08,0.92,0,1";
          };
        };

        tag_animation_direction = 0;
        zoom = {
          initial_ratio = 0.3;
          end_ratio = 0.8;
        };

        fade_in_begin_opacity = 0.5;
        fade_out_begin_opacity = 0.8;

        # Window Behavior
        no_border_when_single = 0;
        focus = {
          on_activate = 0;
          cross_monitor = 0;
          cross_tag = 0;
        };
        enable_floating_snap = 1;
        snap_distance = 32;
        cursor_size = 24;
        drag_tile_to_tile = 1;

        # Scroller Layout
        scroller = {
          focus_center = 0;
          prefer_center = 0;
          structs = 16;
          default_proportion_single = 1.0;
          default_proportion = 1.0;
          proportion_preset = "0.5,1.0";
        };
        edge_scroller_pointer_focus = 0;

        # Master-Stack Layout
        new_is_master = 1;
        default_master_factor = 0.55;
        default_master_count = 1;

        # Overview
        hotarea_size = 10;
        enable_hotarea = 0;

        # Tags
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

        # Appearance
        # Theme (tokyonight)
        shadows_color = "0x15161eff";
        root_color = "0x1a1b26ff";
        border_color = "0x586691ff";
        focus_color = "0x7aa2f7ff";
        maximized_screen_color = "0xbb9af7ff";
        urgent_color = "0xf7768eff";
        scratchpad_color = "0x9ece6aff";
        global_color = "0x003dbeff";
        overlay_color = "0x4f00deff";

        gap = {
          inner = {
            horizontal = 8;
            vertical = 8;
          };
          outer = {
            horizontal = 8;
            vertical = 8;
          };
        };

        scratchpad = {
          width_ratio = 0.8;
          height_ratio = 0.9;
        };

        # Input
        axis = {
          scroll_factor = 1.0;
          bind_apply_timeout = 100;
        };

        # Trackpad
        disable_trackpad = 0;
        trackpad = {
          scroll_factor = 1.0;
          natural_scrolling = 0;
          disable_while_typing = 1;
          left_handed = 0;
          middle_button_emulation = 0;
        };
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        swipe_min_threshold = 1;

        # Mouse
        mouse = {
          natural_scrolling = 0;
          left_handed = 0;
        };

        sloppy_focus = 1;
        warp_cursor = 1;

        # Keyboard
        repeat = {
          rate = 35;
          delay = 400;
        };

        cursor_hide_on_keypress = 1;
        numlock_on = 0;
        xkb_rules_layout = "us";

        # Misc
        sync_obj_enable = 1; # can help with stutters when gaming
        allow_tearing = 1;

        # Key bindings
        bind = [
          # compositor controls
          "CTRL+SUPER,q,quit"
          "CTRL+SUPER,r,reload_config"

          # switch layout
          "CTRL+SUPER,t,setlayout,tile"
          "CTRL+SUPER,s,setlayout,scroller"
          "CTRL+SUPER,p,switch_proportion_preset,"

          # gaps
          "CTRL+SUPER,g,togglegaps"

          # monitor switch
          "CTRL+SUPER,h,focusmon,left"
          "CTRL+SUPER,j,focusmon,down"
          "CTRL+SUPER,k,focusmon,up"
          "CTRL+SUPER,l,focusmon,right"
          "CTRL+SUPER+SHIFT,h,tagmon,left"
          "CTRL+SUPER+SHIFT,j,tagmon,down"
          "CTRL+SUPER+SHIFT,k,tagmon,up"
          "CTRL+SUPER+SHIFT,l,tagmon,right"

          # switch to tag
          "SUPER,1,view,1,0"
          "SUPER,2,view,2,0"
          "SUPER,3,view,3,0"
          "SUPER,4,view,4,0"
          "SUPER,5,view,5,0"
          "SUPER,6,view,6,0"
          "SUPER,7,view,7,0"
          "SUPER,8,view,8,0"
          "SUPER,9,view,9,0"

          # move window to tag
          "SUPER+SHIFT,1,tag,1,0"
          "SUPER+SHIFT,2,tag,2,0"
          "SUPER+SHIFT,3,tag,3,0"
          "SUPER+SHIFT,4,tag,4,0"
          "SUPER+SHIFT,5,tag,5,0"
          "SUPER+SHIFT,6,tag,6,0"
          "SUPER+SHIFT,7,tag,7,0"
          "SUPER+SHIFT,8,tag,8,0"
          "SUPER+SHIFT,9,tag,9,0"

          # switch window focus
          "SUPER,h,focusdir,left"
          "SUPER,j,focusdir,down"
          "SUPER,k,focusdir,up"
          "SUPER,l,focusdir,right"
          "SUPER,Left,focusdir,left"
          "SUPER,Down,focusdir,down"
          "SUPER,Up,focusdir,up"
          "SUPER,Right,focusdir,right"
          "SUPER,n,focusstack,next"
          "SUPER,p,focusstack,prev"

          # move window
          "SUPER+SHIFT,h,move_client,left"
          "SUPER+SHIFT,j,move_client,down"
          "SUPER+SHIFT,k,move_client,up"
          "SUPER+SHIFT,l,move_client,right"
          "SUPER+SHIFT,Left,move_client,left"
          "SUPER+SHIFT,Down,move_client,down"
          "SUPER+SHIFT,Up,move_client,up"
          "SUPER+SHIFT,Right,move_client,right"
          "SUPER+SHIFT,n,exchange_stack_client,next"
          "SUPER+SHIFT,p,exchange_stack_client,prev"

          # applications
          "SUPER,q,killclient"
          "SUPER,b,spawn,firefox"
          "SUPER,t,spawn,foot"

          # scratchpad
          "SUPER,s,toggle_scratchpad"

          # brightness
          "NONE,XF86MonBrightnessUp,spawn_shell,brightnessctl set +5%"
          "NONE,XF86MonBrightnessDown,spawn_shell,brightnessctl set 5%-"

          # volume
          "NONE,XF86AudioRaiseVolume,spawn_shell,pamixer --increase 5"
          "NONE,XF86AudioLowerVolume,spawn_shell,pamixer --decrease 5"
          "NONE,XF86AudioMute,spawn_shell,pamixer --toggle-mute"

          # media
          "NONE,XF86AudioPlay,spawn_shell,playerctl play-pause"
          # "NONE,XF86AudioPause,spawn_shell,playerctl play-pause"
          "NONE,XF86AudioNext,spawn_shell,playerctl next"
          "NONE,XF86AudioPrev,spawn_shell,playerctl previous"

          # movewin
          # "CTRL+SHIFT,Up,movewin,+0,-50"
          # "CTRL+SHIFT,Down,movewin,+0,+50"
          # "CTRL+SHIFT,Left,movewin,-50,+0"
          # "CTRL+SHIFT,Right,movewin,+50,+0"

          # resizewin
          # "CTRL+ALT,Up,resizewin,+0,-50"
          # "CTRL+ALT,Down,resizewin,+0,+50"
          # "CTRL+ALT,Left,resizewin,-50,+0"
          # "CTRL+ALT,Right,resizewin,+50,+0"
        ];

        mousebind = [
          "SUPER,btn_left,moveresize,curmove"
          # "NONE,btn_middle,togglemaxmizescreen,0"
          "SUPER,btn_right,moveresize,curresize"
          # "NONE,btn_left,toggleoverview,-1"
          # "NONE,btn_right,killclient,0"
        ];

        axisbind = [
          "SUPER,UP,viewtoleft,0"
          "SUPER,DOWN,viewtoright,0"
        ];
      };
    };
  };
}
