{
  ...
}:
{

  programs.nixvim = {

    imports = [
      ./nixvim-config.nix
    ];

    defaultEditor = true;
    enable = true;
    nixpkgs.useGlobalPackages = true;

  };

}
