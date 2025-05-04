{ pkgs, ... }:
{
  home.packages = [
    pkgs.nodejs_22
    pkgs.pnpm
    pkgs.nodePackages.typescript
  ];
}
