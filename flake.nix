{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-unstable,
      home-manager,
      nixvim,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import nixos-unstable {
        system = system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        modules = [ ./configuration.nix ];
      };

      homeConfigurations.donato = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit unstable;
        };

        modules = [
          ./home.nix
          nixvim.homeManagerModules.default
          catppuccin.homeModules.catppuccin
        ];
      };

      packages.${system}.nixvim = pkgs.writeShellScriptBin "nixvim" ''
        exec ${pkgs.neovim}/bin/nvim "$@"
      '';

    };
}
