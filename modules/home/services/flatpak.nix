{ inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;

    uninstallUnmanaged = true;

    packages = [
      "com.bambulab.BambuStudio"
      "org.vinegarhq.Sober"
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  home.sessionSearchVariables.XDG_DATA_DIRS = [
    "$HOME/.local/share/flatpak/exports/share"
    "/var/lib/flatpak/exports/share"
  ];
}
