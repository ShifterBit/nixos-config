{
  programs.git = {
    enable = true;

    extraConfig = {
      pull.rebase = false;
    };
    ignores = [
    # swap
    "[._]*.s[a-v][a-z]"
    "[._]*.sw[a-p]"
    "[._]s[a-v][a-z]"
    "[._]sw[a-p]"
    # session
    "Session.vim"
    # temporary
    ".netrwhist"
    "*~"
    # projectiles files
    ".projectile"

    # directory configuration
    ".dir-locals.el"
    "*~"
    "\#*\#"
    "/.emacs.desktop"
    "/.emacs.desktop.lock"
    "*.elc"
    "auto-save-list"
    "tramp"
    ".\#*"
    # Logs and databases #
    ######################
    "*.log"
    "*.sql"
    "*.sqlite"

    # OS generated files #
    ######################
    ".DS_Store"
    ".DS_Store?"
    "._*"
    ".Spotlight-V100"
    ".Trashes"
    "ehthumbs.db"
    "Thumbs.db"
    ];
  };
}
