{pkgs, ...}: {
  imports = [./fish/fish_darwin.nix];
  home.packages = with pkgs; [
    # darwin.xcode
    # cocoapods
  ];
}

