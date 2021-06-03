{ config, lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = false;
    initExtra =
      ''
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down

        bindkey '^ ' autosuggest-accept

        HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=blue,bold"
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"
        ZSH_AUTOSUGGEST_STRATEGY=( history )
        export PATH="$HOME/.config/emacs/bin:$PATH"

        ${fileContents ./ssh-agent.sh}
        ${fileContents ./fzf.sh}

      '';
    sessionVariables = {
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = 1;
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "fg=blue,bold";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "fg=red,bold";
    };
    shellAliases = {
      ls = "exa --long --icons --header --git";
      config = "git --git-dir=$HOME/dotfiles/ --work-tree=$HOME";
    };
    plugins = [
      {
        name = "zsh-fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
  };

  home.packages = with pkgs; [
    starship
    autojump
    zsh-completions
    zsh-command-time
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    nix-zsh-completions

  ];

}
