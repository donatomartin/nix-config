{ pkgs, ... }:
{
  home.packages = [
    pkgs.temurin-bin-21
    pkgs.maven
    pkgs.lombok
    pkgs.jdt-language-server
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin-21}";

  };
}
