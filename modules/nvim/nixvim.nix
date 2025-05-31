{
  ...
}:
{

  imports = [
    ./plugins
    ./general-mappings.nix
    ./options.nix
  ];

  programs.nixvim = {

    enable = true;
    enableMan = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus,unnamed";
    nixpkgs.useGlobalPackages = true;
    colorschemes.catppuccin.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    extraConfigVim = ''
      set guicursor=n-v-c:blinkon1,i:ver25
    '';
  };

}
