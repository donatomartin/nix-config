{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
      username = "donato";

      # Refuse to evaluate this system from a dirty Git tree.
      gitRev =
        if self ? rev then
          self.rev
        else if builtins.getEnv "ALLOW_DIRTY" == "1" then
          self.dirtyRev or "dirty"
        else
          throw ''
            Refusing to build NixOS from a dirty Git tree.

            Commit or stash your changes first.
          '';

      shortGitRev = builtins.substring 0 8 gitRev;

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
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

          ({ config, ... }: {
            nixpkgs.pkgs = pkgs;

            system.configurationRevision = gitRev;

            system.nixos.label = "${config.system.nixos.release}-git-${shortGitRev}";
          })

          home-manager.nixosModules.home-manager

          {
            home-manager.extraSpecialArgs = {
              inherit inputs username self;
            };

            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./users/donato;
          }
        ];

      };

    };
}
