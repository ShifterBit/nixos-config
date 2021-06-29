{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  environment = {

    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      git
      gotop
      gptfdisk
      iputils
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      usbutils
      utillinux
      whois

      # Extra CLI Tools
      neovim
      pandoc
      wget
      git
      neofetch
      axel
      aria
      bat
      exa
      tokei
      viu
      ripgrep
      fd
      fzf
      tree
      silver-searcher
      httplz
      p7zip

      # Cachix
      cachix
    ];

  };


  fonts = {
    fonts = with pkgs; [
      powerline-fonts
      dejavu_fonts

      font-awesome_4
      (
        nerdfonts.override {
          fonts = [ "JetBrainsMono" "DejaVuSansMono" "FiraCode" "Iosevka" ];
        }
      )
      iosevka
      twemoji-color-font
      noto-fonts-emoji-blob-bin
      emojione
    ];

    fontconfig.defaultFonts = {

      monospace = [ "DejaVu Sans Mono for Powerline" ];

      sansSerif = [ "DejaVu Sans" ];

    };
  };

  nix = {

    autoOptimiseStore = true;

    gc.automatic = true;

    optimise.automatic = true;

    useSandbox = true;

    allowedUsers = [ "@wheel" ];

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

  };

  # programs.bash = {
  #   promptInit = ''
  #     eval "$(${pkgs.starship}/bin/starship init bash)"
  #   '';
  #   interactiveShellInit = ''
  #     eval "$(${pkgs.direnv}/bin/direnv hook bash)"
  #   '';
  # };

  services.earlyoom.enable = true;

}
