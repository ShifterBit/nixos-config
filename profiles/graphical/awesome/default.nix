{ config, pkgs, ... }:

{

  services.xserver.windowManager.awesome.enable = true;

  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    rofi
    feh
    nitrogen
    dunst
    brightnessctl
    i3lock-fancy
    dmenu
    mpd
    mpc_cli
    scrot
    unclutter
    xorg.xbacklight
    xsel
    slock
    glib
  ];

  programs.light.enable = true;
}
