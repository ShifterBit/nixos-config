{ config, lib, pkgs, suites, ... }:

{
  imports = suites.workstation;


  boot = {
    initrd.luks.devices = {
      crypt = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
        preLVM = true;
      };
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/0554d6af-3b95-4f91-9558-db15526b0a03";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/28F0-C892";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/c0e1325c-437f-4123-b5c7-85067476e92d"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.tlp.enable = true;

}
