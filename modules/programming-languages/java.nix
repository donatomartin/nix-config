{ pkgs, ... }:
{
  home.packages = [
    pkgs.openjdk21
    pkgs.maven
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.openjdk21}";
  };
}
