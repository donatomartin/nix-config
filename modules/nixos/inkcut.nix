{ pkgs, ... }:
let
  inkcutDesktop = pkgs.makeDesktopItem {
    name = "inkcut";
    desktopName = "Inkcut";
    genericName = "Vector slicer";
    comment = "Launch Inkcut";

    exec = "${pkgs.inkcut}/bin/inkcut";
    icon = "inkcut";
    terminal = false;

    categories = [
      "Graphics"
    ];
  };
in
{
  environment.systemPackages = [
    pkgs.inkcut
    inkcutDesktop
  ];

  services = {
    udev = {
      extraRules = ''
        SUBSYSTEM=="tty", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5750", MODE="0660", GROUP="dialout", SYMLINK+="secabo"
      '';
    };
  };

}
