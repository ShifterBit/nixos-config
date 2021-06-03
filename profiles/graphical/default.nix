{ pkgs, config, ... }:

{
  imports = [ ./i3 ./gaming ];

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.displayManager.lightdm.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig.antialias = true;
  fonts.fontconfig.allowBitmaps = true;
  fonts.fontconfig.hinting.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;

  # Enable DConf
  programs.dconf.enable = true;

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };


  # Enable XDG Portal
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
  ];

  environment = {

    etc = {
      "xdg/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-icon-theme-name=Papirus
          gtk-theme-name=Materia-dark
          gtk-cursor-theme-name=Adwaita
        '';
        mode = "444";
      };
    };

    systemPackages = with pkgs; [
      ffmpeg-full
      gnome3.adwaita-icon-theme
      gnome3.networkmanagerapplet
      manpages

      # Themes
      lxappearance
      materia-theme
      papirus-icon-theme

      # PDF Reader
      evince

      # Terminal
      alacritty

      # Element
      element-desktop

      # Browsers
      brave
      firefox-bin
      nyxt

      # Media
      mpv
      youtube-dl
      blueman
      flameshot
      android-file-transfer

      # XDG + Gnome Stuff
      glib
      mime-types
      xdg-user-dirs
      shared-mime-info
      perl532Packages.FileMimeInfo
      polkit_gnome
      gsettings-desktop-schemas

      # LibreOffice
      libreoffice

      # Password Managers
      keepassxc
      keeweb

    ];

  };


}
