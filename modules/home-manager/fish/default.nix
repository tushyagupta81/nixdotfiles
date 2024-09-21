{pkgs, ...}:{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "plugin-foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "7f0cf099ae1e1e4ab38f46350ed6757d54471de7";
          sha256 = "4+k5rSoxkTtYFh/lEjhRkVYa2S4KEzJ/IJbyJl+rJjQ=";
        };
      }
      {
        name = "nvm";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "nvm.fish";
          rev = "a0892d0bb2304162d5faff561f030bb418cac34d";
          sha256 = "4+k5rSoxkTtYFh/lEjhRkVYa2S4KEzJ/IJbyJl+rJjQ=";
        };
      }
    ];
    shellInit = ''
# ~/.config/fish/config.fish
set fish_greeting

# nix
if test -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  fenv source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
end

set -gx FONT "JetBrainsMono Nerd Font"

fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

if test -e "$HOME/.cargo/env.fish"
  source "$HOME/.cargo/env.fish"
end

fish_add_path "$HOME/.nix-profile/bin"
fish_add_path "$HOME/nixdotfiles/scripts"
fish_config theme choose vibrant

alias ls "eza --icons=always"
alias l "eza --icons=always -la"
alias lt "eza --icons=always -Ta -L=2"
alias nv "nvim"
alias enva "source $HOME/nixdotfiles/scripts/envactivate.fish"
alias envl "l $HOME/.virtualenv"

abbr --erase (abbr --list)
abbr --add nconfig cd ~/.config/nvim
abbr --add ws cd ~/programs
abbr --add n newsboat
abbr --add jl jupyter lab
abbr --add smysql brew services run mysql
abbr --add qmysql brew services stop mysql
abbr --add sjl brew services run jupyterlab
abbr --add qjl brew services stop jupyterlab
abbr --add c clear
abbr --add cd.. cd ..
abbr --add envd deactivate
abbr --add pre fzf --preview=\"bat --color=always {}\"

abbr --add gs git status
abbr --add ga git add
abbr --add gp git push
abbr --add gc git commit -m
abbr --add gr git add .\;git commit -m

starship init fish | source
thefuck --alias | source
zoxide init fish --cmd cd | source
fzf --fish | source

if status --is-login
  if not set -q TMUX
    command fastfetch -c ~/.config/fastfetch_conf.jsonc;
  end
end

if status is-interactive
  # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/home/tushya/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
    '';
  };
}
