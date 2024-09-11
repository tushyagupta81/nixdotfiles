{
  description = "Home Manager configuration of tushya";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations."tushya-linux" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home_linux.nix ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
    homeConfigurations."tushya-darwin" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home_darwin.nix ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
