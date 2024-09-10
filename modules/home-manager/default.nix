{pkgs, ...}: {
  imports = [./tmux ./fish ./nvim];
  home.packages = with pkgs; [
    rustc
    cargo
    python3
    fish
    pnpm
    unzip
    bat
    tmux
    fastfetch
    eza
    git
    newsboat
    nodejs_22
    fnm
    btop
    mysql
    ripgrep
    thefuck
    mpv
    neovim
    gcc
    luarocks
    lazygit
    zoxide
    fzf
    starship
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  programs.git = {
    enable = true;
    userEmail = "tushyagupta81@gmail.com";
    userName = "Tushya Gupta";
  };
}

