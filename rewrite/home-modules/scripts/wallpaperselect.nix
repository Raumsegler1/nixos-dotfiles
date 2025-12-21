{ pkgs, config, ... }: {

  home.packages = [
    (pkgs.writeShellScriptBin "wallpaper-picker" ''
      #!/usr/bin/env bash

      # --- CONFIGURATION ---
      WALLPATH="${config.home.homeDirectory}/Pictures/Wallpapers"
      ICON_SIZE=256
      
      # Checks
      if [ ! -d "$WALLPATH" ]; then
          echo "Error: Directory $WALLPATH not found."
          exit 1
      fi

      # --- THEME DEFINITION ---
      # This replaces the external .rasi file entirely.
      # We import your Matugen colors first, then define the Grid Layout.
      ROFI_THEME="
      /* Import Matugen Colors (Ensure Matugen generates this file!) */
      @import \"${config.home.homeDirectory}/.config/rofi/colors.rasi\"

      /* Global Config */
      configuration {
          font: \"JetBrainsMono Nerd Font 12\";
          show-icons: true;
      }

      /* Window: Centered, transparent background */
      window {
          width: 80%;
          height: 70%;
          border: 2px;
          border-color: @primary; /* Uses Matugen Color */
          border-radius: 12px;
          background-color: #00000080; /* Fallback transparent bg */
          padding: 20px;
      }

      /* Main container */
      mainbox {
          background-color: transparent;
          children: [ listview ];
      }

      /* Grid Layout */
      listview {
          columns: 5;
          lines: 3;
          cycle: false;
          dynamic: true;
          layout: vertical;
          flow: horizontal;
          spacing: 20px;
          background-color: transparent;
      }

      /* Individual Items (Wallpaper Cards) */
      element {
          orientation: vertical;
          padding: 10px;
          border-radius: 8px;
          background-color: transparent;
          text-color: @on_surface; /* Uses Matugen Color */
          cursor: pointer;
      }

      /* Selection State */
      element selected {
          background-color: @primary;
          text-color: @on_primary;
          border-radius: 12px;
      }

      /* Icon (The Wallpaper Preview) */
      element-icon {
          size: ${toString "\${ICON_SIZE}"}px;
          horizontal-align: 0.5;
          margin: 0 0 10px 0;
          background-color: transparent;
          border-radius: 8px;
      }

      /* Text (Filename) */
      element-text {
          horizontal-align: 0.5;
          vertical-align: 0.5;
          background-color: transparent;
          text-color: inherit;
      }
      "

      # --- EXECUTION ---
      # 1. Find images
      # 2. Format as: Filename \0 icon \x1f /path/to/image
      # 3. Pipe to Rofi with our custom theme variable
      SELECTED_FILE=$(find -L "$WALLPATH" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r rfile; do
          echo -en "$rfile\0icon\x1f$WALLPATH/$rfile\n"
      done | ${pkgs.rofi-wayland}/bin/rofi -dmenu -i -theme-str "$ROFI_THEME" -p "Wallpaper")

      # --- APPLY ---
      if [ -n "$SELECTED_FILE" ]; then
          FULL_PATH="$WALLPATH/$SELECTED_FILE"

          # Set Wallpaper
          awww img "$FULL_PATH" --transition-type grow --transition-pos top-right --transition-duration 2 --transition-fps 60
          
          # Symlink for lockscreen/others
          ln -sf "$FULL_PATH" "$WALLPATH/current.set"
          
          # Generate System Colors
          matugen image "$FULL_PATH"

          # Notify
          #${pkgs.libnotify}/bin/notify-send "Wallpaper Changed" "Set to $SELECTED_FILE" -i "$FULL_PATH"
      fi
    '')
  ];
}