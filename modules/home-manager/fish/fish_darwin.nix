{pkgs, ...}:{
  programs.fish = {
    shellInit = ''
if test -d /home/linuxbrew/.linuxbrew
  set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
else if test -d /opt/homebrew
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
end

set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
set -q MANPATH; or set MANPATH \'\'
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
set -q INFOPATH; or set INFOPATH \'\'
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH
$HOMEBREW_PREFIX/bin/brew shellenv | source
    '';
  };
}
