{ pkgs, ... }: {

  home.file = {
    ".config/i3" = {
      source = ./i3;
      recursive = true;
    };
    ".config/i3status-rust" = {
      source = ./i3status-rust;
      recursive = true;
    };
  };
}
