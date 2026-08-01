# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  username,
  inputs,
  ...
}:
{

  # Nixos imports
  imports = [

    # Import hardware-configuration
    ./hardware-configuration.nix

    inputs.nix-flatpak.nixosModules.nix-flatpak

    # Modules
    ../../modules/nixos/inkcut.nix
    ../../modules/nixos/flatpak.nix

  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable connecting to the network before the system is up
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services."home-manager-donato".serviceConfig = {
    TimeOutStartSec = "25min";
  };

  # Enable experimental
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.trustedInterfaces = [ "zt+" ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedTCPPortRanges = [ ];
  networking.firewall.allowedUDPPortRanges = [ ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  documentation = {
    enable = true;
    man.enable = true;
    man.cache.enable = true;
    man.cache.generateAtRuntime = true;
    dev.enable = true;
    nixos.enable = true;
  };

  console.keyMap = "es";

  environment.systemPackages = with pkgs; [
    hyprpaper
    ntfs3g
    man-pages
    man-pages-posix
    linux-manual
    wikiman
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
      "uucp"
      "vboxusers"
      "input"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };

  # Configure Hardware
  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false; # Puedes poner true si quieres usar los drivers abiertos (beta)
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    bluetooth.enable = true;
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    nix-ld.enable = true;
    steam.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [ thunar-archive-plugin ];
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
    };
  };

  services = {

    envfs.enable = true;
    tailscale.enable = true;

    gnome.gnome-keyring.enable = true;

    blueman.enable = true;

    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "quiet";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
      };
    };

    upower = {
      enable = true;
      usePercentageForPolicy = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 7;
      criticalPowerAction = "PowerOff";
    };

    displayManager.ly.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [
        "modesetting"
        "nvidia"
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Map CapsLock to Escape or Ctrl when chording
    interception-tools =
      let
        itools = pkgs.interception-tools;
        itools-caps = pkgs.interception-tools-plugins.caps2esc;
      in
      {
        enable = true;
        plugins = [ itools-caps ];
        # requires explicit paths: https://github.com/NixOS/nixpkgs/issues/126681
        udevmonConfig = pkgs.lib.mkDefault ''
          - JOB: "${itools}/bin/intercept -g $DEVNODE | ${itools-caps}/bin/caps2esc -m 1 | ${itools}/bin/uinput -d $DEVNODE"
            DEVICE:
              EVENTS:
                EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
        '';
      };

  };

  virtualisation = {
    docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableKvm = true;
    #   addNetworkInterface = false;
    # };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];
  xdg.portal.config.common.default = "gtk";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
