{ lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;
in
{
  home-manager.users.tek = {
    imports = [
      ../profiles/git
      ../profiles/direnv
      ../profiles/alacritty
      ../profiles/neovim
      ../profiles/emacs
      ../profiles/zsh
      ../profiles/i3
      ../profiles/syncthing
    ];
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;
  # services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;


  programs.adb.enable = true;

  services.flatpak.enable = true;

  users.users.tek = {
    uid = 1000;
    description = "Tek";
    hashedPassword = fileContents ../../secrets/tek;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "networkmanager"
      "kvm"
      "audio"
      "video"
      "input"
      "wireshark"
      "adbusers"
    ];
    shell = pkgs.zsh;
  };


}
