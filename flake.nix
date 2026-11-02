{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      gitRev = if self ? rev then self.rev else self.dirtyRev or "dirty";
      shortGitRev = builtins.substring 0 8 gitRev;
      # Allow unfree packages on unstable
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      # Allow unfree packages on unstable
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        # Allow listed insecure pacakges
        config.permittedInsecurePackages = [
          "docker-28.5.2"
          "electron-39.8.10"
        ];
        # Define overlay
        overlays = [
          (final: prev: {
            inherit unstable;
          })
        ];
      };
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations.nixos = lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs self;
            };
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.donato = import ./home/donato/personal.nix;
          }
          ({ config, ... }: {
            nixpkgs.pkgs = pkgs;
            system.configurationRevision = gitRev;
            system.nixos.label = "${config.system.nixos.release}-git-${shortGitRev}";
          })
        ];
      };

      nixosConfigurations.wsl = lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/wsl
          home-manager.nixosModules.home-manager
          inputs.nixos-wsl.nixosModules.default
          {
            home-manager.extraSpecialArgs = {
              inherit inputs self;
            };
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.donato = import ./home/donato/work.nix;
          }
        ];
      };

    };
}
