{ pkgs, ... }:
let
  cursorTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "el-capitan-cursor";
    version = "unstable";

    src = fetchGit {
      url = "https://github.com/donatomartin/OSX-ElCap-Cursors.git";
      rev = "3eef2baa4533336114e0f302a56c0b8d2e1a8154";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p "$out/share/icons/El-Capitan"
      cp -r cursors "$out/share/icons/El-Capitan/"

      cat > "$out/share/icons/El-Capitan/index.theme" <<EOF
      [Icon Theme]
      Name=El Capitan - Cursor
        Comment=El Capitan cursor theme
        EOF
    '';
  };
in
{
  home.pointerCursor = {
    gtk.enable = true;
    name = "El-Capitan";
    size = 12;
    package = cursorTheme;
  };

}
