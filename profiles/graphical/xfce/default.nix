{ pkgs, ... }: {
  services.xserver.windowManager.xfce = {
    enable = true;
    thunarPlugins = with pkgs; [ xfce.thunar-volman xfce.thunar-archive-plugin ];
  };
}
