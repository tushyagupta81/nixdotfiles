{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: true;
  home = {
    username = "tushya-linux";
    homeDirectory = "/home/tushya";
    stateVersion = "24.05";
    file = {
      ".config" = {
        source= ./configs;
        recursive = true;
      };
      ".config/fish/themes/vibrant.theme" = {
        source = ./vibrant.theme;
      };
      ".zshrc" = {
        source = ./.zshrc;
      };
      ".wezterm.lua" = {
        source = ./.wezterm.lua;
      };
      ".jupyter" = {
        source = ./.jupyter;
        recursive = true;
      };
      # ".tmux.conf" = {
      #   source = ./.tmux.conf;
      # };
    };
  };
  xdg.enable = true;
  programs.fish.enable = true;
  programs.home-manager.enable = true;
  imports = [./modules/home-manager ./modules/home-manager/linux.nix];
}
