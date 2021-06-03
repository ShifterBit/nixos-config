{ lib, pkgs, config, ... }:

{

  imports = [ ./bluetooth ./dnscrypt ];
  networking.networkmanager.enable = true;


}
