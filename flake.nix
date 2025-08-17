{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-unstable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "donato";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            unstable = import nixos-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
      };
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations.nixos = lib.nixosSystem {

        specialArgs = {
          inherit inputs username;
        };

        modules = [
          ./configuration.nix
        ];

      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            inputs
            username
            self
            system
            ;
        };

        modules = [
          ./home.nix
        ];

      };

      packages.${system} = {

        nixvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          pkgs = pkgs;
          module = import ./modules/nvim/nixvim-config.nix;
        };

        vscodenixvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          pkgs = pkgs;
          module = import ./modules/nvim/vscodenixvim-config.nix;
        };

        activate-home = self.homeConfigurations.${username}.activationPackage;
      };

    };
}
