# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  username,
  ...
}:
{

  # Import hardware-configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable connecting to the network before the system is up
  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Define hostname
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable Networking
  # networking.networkmanager.unmanaged = [
  #   "*"
  #   "except:type:wwan"
  #   "except:type:gsm"
  # ];
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ntfs3g
    displaylink
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = [

      # CLI
      pkgs.docker
      pkgs.git
      pkgs.neovim

      # GUI
      inputs.zen-browser.packages.${pkgs.system}.twilight
      pkgs.xfce.thunar
      pkgs.libreoffice
      pkgs.beeper
      pkgs.prismlauncher
      pkgs.obs-studio
      pkgs.vesktop
      pkgs.vlc
      pkgs.inkscape
      pkgs.gimp3
      pkgs.anydesk
      pkgs.vscode
      pkgs.eclipses.eclipse-java
      pkgs.brave
      pkgs.virtualbox

    ];

    shell = pkgs.zsh;
  };

  # Set Zsh as the default shell
  programs.zsh.enable = true;

  # Configure Hardware
  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false; # Puedes poner true si quieres usar los drivers abiertos (beta)
      nvidiaSettings = true;
    };

    bluetooth.enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [
      "displaylink"
      "modesetting"
    ];

  };

  # Remap CapsLock to Escape or Ctrl if chorded
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

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable Ly display manager
  services.displayManager.ly.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable Printer Support
  services.printing.enable = true;

  # Si usas una impresora HP (opcional)
  services.printing.drivers = [ pkgs.hplip ];

  # Para usar CUPS desde la web
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
