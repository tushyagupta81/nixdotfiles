{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    android-tools
    android-studio
    android-studio-tools
  ];
}

