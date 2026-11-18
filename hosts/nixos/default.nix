# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
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

  # ╭─────────────────────────────────────────────────────────╮
  # │ Machine
  # ╰─────────────────────────────────────────────────────────╯

  documentation.man.enable = true;
  documentation.man.generateCaches = true;

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = false;

      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";

        splashImage = ../../assets/splash-screen/catppucin.png;
        splashMode = "stretch";

        # Keep the graphical menu visible.
        timeoutStyle = "menu";

        # Nice high-resolution menu.
        gfxmodeEfi = "auto";
        gfxpayloadEfi = "keep";

        # Don't clutter the menu with hundreds of old generations.
        configurationLimit = 20;

        # KDE Breeze GRUB theme.
        theme = ../../assets/fallout-grub-theme;
      };

      # Give you time to select a generation.
      timeout = 3;
    };
    plymouth.enable = true;

    # Reduce kernel/systemd noise behind Plymouth
    consoleLogLevel = 3;
    initrd.verbose = false;
  };

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
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedTCPPortRanges = [ ];
  networking.firewall.allowedUDPPortRanges = [ ];
  networking.firewall.interfaces.raspi.allowedTCPPorts = [
    8080
    49374
    22
  ];

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

  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.donato = {
    isNormalUser = true;
    description = "donato";
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

  # ╭─────────────────────────────────────────────────────────╮
  # │ Programs
  # ╰─────────────────────────────────────────────────────────╯

  environment.systemPackages = with pkgs; [
    sdl3.lib
    hyprpaper
    ntfs3g
    man-pages
    man-pages-posix
  ];

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = [ pkgs.thunar-archive-plugin ];
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
  };

  # ╭─────────────────────────────────────────────────────────╮
  # │ Services
  # ╰─────────────────────────────────────────────────────────╯

  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    envfs.enable = true;
    displayManager.ly.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    extraConfig.pipewire."90-echo-cancel" = {
      "context.modules" = [
        {
          name = "libpipewire-module-echo-cancel";

          args = {
            "library.name" = "aec/libspa-aec-webrtc";

            # Important: use whatever is playing through the real
            # default output as the AEC reference signal.
            "monitor.mode" = true;

            "audio.rate" = 48000;

            "capture.props" = {
              "node.name" = "echo_cancel.capture";
              "node.passive" = true;
            };

            "source.props" = {
              "node.name" = "echo_cancel.source";
              "node.description" = "Microphone (Echo Cancelled)";

              # Make applications prefer this source over the raw mic.
              "priority.session" = 2000;
              "priority.driver" = 2000;
            };
          };
        }
      ];
    };
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  services.tlp = {
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

  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 7;
    criticalPowerAction = "PowerOff";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Map CapsLock to Escape or Ctrl when chording
  services.interception-tools =
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

  # ╭─────────────────────────────────────────────────────────╮
  # │ Other
  # ╰─────────────────────────────────────────────────────────╯

  virtualisation = {
    docker.enable = true;
    # virtualbox.host = {
    #   enable = true;
    #   enableKvm = true;
    #   addNetworkInterface = false;
    # };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "gtk";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
