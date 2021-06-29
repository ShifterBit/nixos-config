{ lib, pkgs, config, ... }:

{

  services.mongodb.enable = true;

  # services.ipfs.enable = true;


  environment.systemPackages = with pkgs; [

    # Language Servers
    rnix-lsp
    clang-tools
    rust-analyzer
    nodePackages.pyright
    haskellPackages.haskell-language-server
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.vue-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    sumneko-lua-language-server

    # Linters
    nodePackages.stylelint
    nodePackages.eslint
    ormolu
    python38Packages.pylint
    yamllint
    lua51Packages.luacheck
    lua51Packages.lua
    nixfmt
    nixpkgs-fmt
    editorconfig-core-c
    shellcheck

    # Package Managers/Programming Languages
    nodejs
    rustup
    yarn
    racket
    haskellPackages.stack
    ghc

    # Debuggers
    gdb

    # Docs
    zeal

  ];

}
