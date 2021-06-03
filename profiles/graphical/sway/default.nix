{ lib, config, pkgs, ... }:
let
  inherit (builtins) readFile;
in
{
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock-effects
      swayidle
      waybar
      wl-clipboard
      clipman
      mako
      wofi
      light
      wdisplays
      xwayland
      sway-contrib.grimshot
      acpi
      i3status-rust
      brightnessctl
    ];
  };
}
