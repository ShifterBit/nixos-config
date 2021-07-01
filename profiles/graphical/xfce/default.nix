{ pkgs, ... }: {
  services.xserver.desktopManager.xfce = {
    enable = true;
    thunarPlugins = with pkgs; [ xfce.thunar-volman xfce.thunar-archive-plugin ];
  };
  environment.systemPackages = with pkgs; [
    plank
    picom
    xfce.xfce4-notifyd
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-power-manager
  ];
}
