{pkgs, ...}: {
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };
    # adapted for colemak
    bindings = [
      # navigation
      {
        key = "n";
        command = "scroll_down";
      }
      {
        key = "e";
        command = "scroll_up";
      }
      {
        key = "N";
        command = ["select_item" "scroll_down"];
      }
      {
        key = "E";
        command = ["select_item" "scroll_up"];
      }
      # move items
      {
        key = "k";
        command = "move_sort_order_down";
      }
      {
        key = "k";
        command = "move_selected_items_down";
      }
      {
        key = "m";
        command = "move_sort_order_up";
      }
      {
        key = "m";
        command = "move_selected_items_up";
      }
    ];
    settings = {
      # visualiser
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_type = "ellipse";
      visualizer_look = "●●";

      # current item
      current_item_prefix = "$(magenta)$r"; # change accent color

      # selected items
      selected_item_prefix = "\"* \"";
      discard_colors_if_item_is_selected = "yes";

      # now playing
      now_playing_prefix = "\"$b$6  \"";
      now_playing_suffix = "\"$/b\"";
      centered_cursor = true;
      autocenter_mode = "yes";

      # layout
      user_interface = "alternative";
      startup_screen = "playlist";
      startup_slave_screen = "media_library";
      song_columns_list_format = "(10)[blue]{l} (45)[magenta]{t} (15)[white]{a} (30)[white]{b}";

      # display modes
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";

      # colours
      main_window_color = "white";

      # navigation
      lines_scrolled = 1; # default is 5

      # show album artist instead of artist by default
      media_library_primary_tag = "album_artist";
    };
  };
}
