{
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
  };

  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
    "org.vinegarhq.Sober"
  ];
}
