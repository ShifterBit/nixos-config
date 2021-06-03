{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  home.file = {
    ".config/emacs" = {
      source = ./emacs-config;
      recursive = true;
    };
  };
}
