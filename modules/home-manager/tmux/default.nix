{pkgs, ...}:
let
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-super-fingers";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "artemave";
        repo = "tmux_super_fingers";
        rev = "2771f791a03880b3653c043cff48ee81db66212b";
        sha256 = "sha256-GnVlV8JRKVx6muVKYvqkCSMds7IBTYp1NFEgQnnuYEc=";
      };
    };
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    plugins = with pkgs;
      [
        {
          plugin = tmux-super-fingers;
          extraConfig = "set -g @super-fingers-key f";
        }
        tmuxPlugins.better-mouse-mode
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = '' 
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator " "
            set -g @catppuccin_window_middle_separator " █"
            set -g @catppuccin_window_number_position "right"
            
            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"
            
            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"
            
            set -g @catppuccin_status_modules_right "directory session"
            set -g @catppuccin_status_left_separator  " "
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_status_connect_separator "no"
            
            set -g @catppuccin_directory_text "#{pane_current_path}"
            set -g @catppuccin_flavour "mocha"
            set -g @catppuccin_status_background "default"
          '';
        }
        # {
        #   plugin = tmuxPlugins.continuum;
        #   extraConfig = ''
        #     set -g @continuum-restore 'on'
        #     set -g @continuum-boot 'on'
        #     set -g @continuum-save-interval '10'
        #   '';
        # }
      ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf
      
      set -g mouse on
      
      set -g prefix C-s
      
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      
      bind-key ! kill-server
      
      bind-key -n "^@" run-shell -b "tmux-toggle-term float"
      
      set -g status-position top
      
      set -g status-bg default
    '';
  };
}
