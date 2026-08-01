{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      affinity-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "donato";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          affinity-nix.overlays.default
          (final: prev: {
            inherit unstable;
          })
        ];
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "docker-28.5.2"
          "electron-39.8.10"
        ];
      };
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations.nixos = lib.nixosSystem {

        specialArgs = { inherit inputs username self; };

        modules = [
          ./hosts/nixos
          { nixpkgs.pkgs = pkgs; }
          home-manager.nixosModules.home-manager
          {
            # HM wiring
            home-manager.extraSpecialArgs = { inherit inputs username self; };
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./users/donato;
          }
        ];

      };

    };
}
