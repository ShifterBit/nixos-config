{ config, pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      dunst
      nitrogen
      feh
      i3lock-fancy
      rofi
      arandr
      acpi
      alacritty
      i3status-rust
      brightnessctl
    ];
  };

  services.autorandr.enable = true;

  programs.light.enable = true;
}

