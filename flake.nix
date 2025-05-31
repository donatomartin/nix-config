{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      nixos-unstable,
      home-manager,
      ...
    }@inputs:
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

        specialArgs = {
          inherit unstable inputs;
        };

        modules = [
          ./configuration.nix
        ];

      };

      homeConfigurations.donato = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit unstable inputs;
        };

        modules = [
          ./home.nix
        ];
      };

      packages.${system}.nixvim = pkgs.writeShellScriptBin "nixvim" ''
        exec ${pkgs.neovim}/bin/nvim "$@"
      '';

    };
}
