{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
          inherit
            inputs
            username
            ;
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {  # HM wiring
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs username self system; }; # if your home.nix needs inputs
            home-manager.users.${username} = import ./home.nix;     # <- reuse your same file
          }
        ];

      };

    };
}
