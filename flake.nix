{
  description = "Yuya's dotfiles managed with Nix Flakes";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # For overriding inputs whose flakes eagerly evaluate x86_64-darwin, which nixpkgs >= 26.11 dropped
    systems.url = "github:nix-systems/triplet";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned to a release tag; bump manually to update (nix flake update won't move it)
    herdr = {
      url = "github:ogulcancelik/herdr/v0.7.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned to a release tag; bump manually to update (nix flake update won't move it)
    hunk = {
      url = "github:modem-dev/hunk/v0.17.3";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.bun2nix.inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      hostname =
        let
          envHostname = builtins.getEnv "HOSTNAME";
        in
        if envHostname != "" then envHostname else throw "HOSTNAME is required";
      username =
        let
          envUser = builtins.getEnv "USER";
        in
        if envUser != "" then envUser else throw "USER is required";

      specialArgs = {
        inherit inputs username system;
        dotfilesDir = self;
      };
    in
    {
      darwinConfigurations.personal = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./nix/darwin
          ./nix/darwin/personal.nix

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = specialArgs;
              users.${username} = import ./nix/home;
            };
          }
        ];
      };

      darwinConfigurations.work = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./nix/darwin
          ./nix/darwin/work.nix

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = specialArgs;
              users.${username} = import ./nix/home;
            };
          }
        ];
      };

      # Expose the package set for convenience
      packages.${system}.default = self.darwinConfigurations.personal.system;

      # Formatter for `nix fmt`
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
