{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "/home/john/.config/alacritty/current-theme.toml" ];
      window.opacity = 1.0;
    };
  };

  home.activation.alacrittyTheme =
    config.lib.dag.entryAfter [ "linkGeneration" ] ''
      theme_dir="/home/john/dotfiles/alacritty/themes"
      current="/home/john/.config/alacritty/current-theme.toml"
      current_name="/home/john/.config/alacritty/current-theme-name"

      if [ ! -f "$current" ]; then
        cp "$theme_dir/catppuccin_frappe.toml" "$current"
        chmod u+w "$current"
        echo "catppuccin_frappe" > "$current_name"
      fi
    '';
}
