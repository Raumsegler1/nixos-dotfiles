{ pkgs, config, ... }: {

  home.packages = [
    (pkgs.writeShellScriptBin "wallpaper-picker" ''
      #!/usr/bin/env bash

      # --- CONFIGURATION ---
      WALLPATH="${config.home.homeDirectory}/Pictures/Wallpapers"
      ROFI_CONF="${config.home.homeDirectory}/.config/rofi/wallpaper.rasi"

      if [ ! -d "$WALLPATH" ]; then
          echo "Error: Directory $WALLPATH not found."
          exit 1
      fi

      # --- EXECUTION ---
      # CHANGE: Used -printf "%P\n" to keep the subfolder structure (e.g. "Anime/ghibli.jpg")
      SELECTED_FILE=$(find -L "$WALLPATH" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -printf "%P\n" | sort | while read -r rfile; do
          echo -en "$rfile\0icon\x1f$WALLPATH/$rfile\n"
      done | ${pkgs.rofi}/bin/rofi -dmenu -i -show-icons -config "$ROFI_CONF" -p "Wallpaper")

      # --- APPLY ---
      if [ -n "$SELECTED_FILE" ]; then
          FULL_PATH="$WALLPATH/$SELECTED_FILE"

          awww img "$FULL_PATH" --transition-type grow --transition-pos top-right --transition-duration 2 --transition-fps 60
          ln -sf "$FULL_PATH" "$WALLPATH/current.set"
          
          matugen image "$FULL_PATH"
      fi
    '')
  ];
}
