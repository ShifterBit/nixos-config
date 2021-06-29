{ lib, pkgs, config, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva vaapiIntel libvdpau-va-gl vaapiVdpau ] ++ lib.optionals config.services.pipewire.enable [ pipewire ];
  hardware.pulseaudio.support32Bit = true;


  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    winetricks
    wineWowPackages.staging
  ];

  programs.steam.enable = true;

}
