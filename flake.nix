{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
          inherit unstable inputs username;
        };

        modules = [
          ./configuration.nix
        ];

      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit unstable inputs username;
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

        activate-home = self.homeConfigurations.${username}.activationPackage;
      };

    };
}
