{
  description = "Yuya's dotfiles managed with Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
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

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

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

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
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
              extraSpecialArgs = specialArgs;
              users.${username} = import ./nix/home;
            };
          }
        ];
      };

      # Expose the package set for convenience
      packages.${system}.default = self.darwinConfigurations.personal.system;
    };
}
