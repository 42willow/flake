# Colemak layout:                  |                 QWERTY layout:
# `12345 67890-=     Move Around:  |  (instead of)   `12345 67890-=
#  qwfpg jlUy;[]\         e        |       k          qwert yuiop[]\
#  arstd hNEIo'         h   i      |     h   l        asdfg HJKL;'
#  zxcvb km,./            n        |       j          zxcvb nm,./
# nnoremap n h|xnoremap n h|onoremap n h|
# nnoremap u k|xnoremap u k|onoremap u k|
# nnoremap e j|xnoremap e j|onoremap e j|
# nnoremap i l|xnoremap i l|onoremap i l|
# inoremap <M-n> <Left>|cnoremap <M-n> <Left>|
# inoremap <M-u> <Up>|cnoremap <M-u> <Up>|
# inoremap <M-e> <Down>|cnoremap <M-e> <Down>|
# inoremap <M-i> <Right>|cnoremap <M-i> <Right>|
{...}: {
  programs.nixvim.keymaps = [
    # Colemak keybinds
    # TODO
    # down
    {
      mode = "n";
      key = "n";
      action = "j";
    }
    {
      mode = "i";
      key = "<M-n>";
      action = "<Down>";
    }
    # up
    {
      mode = "n";
      key = "e";
      action = "k";
    }
    {
      mode = "i";
      key = "<M-e>";
      action = "<Up>";
    }
    # right
    {
      mode = "n";
      key = "i";
      action = "l";
    }
    {
      mode = "i";
      key = "<M-i>";
      action = "<Right>";
    }
    # left
    {
      mode = "i";
      key = "<M-h>";
      action = "<Left>";
    }
  ];
}
