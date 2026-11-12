{config, ...}: {
  programs.zsh = {
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initContent = ''
      PROMPT_NEEDS_NEWLINE=false

      precmd() {
        if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
          echo
        fi
        PROMPT_NEEDS_NEWLINE=true
      }

      clear() {
        PROMPT_NEEDS_NEWLINE=false
        command clear
      }
    '';
  };
}
