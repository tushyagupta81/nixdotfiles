{pkgs, ...}: {
  imports = [./fish/fish_darwin.nix];
  home.packages = with pkgs; [
    jq
    # darwin.xcode
    # cocoapods
  ];
}

