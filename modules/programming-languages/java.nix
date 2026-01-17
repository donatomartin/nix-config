{ pkgs, ... }:
{
  home.packages = [
    pkgs.temurin-bin-21
    pkgs.maven
    pkgs.gradle
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin-21}";
  };
}
