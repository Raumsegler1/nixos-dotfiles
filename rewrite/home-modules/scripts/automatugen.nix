{ pkgs, config, ... }: {

  home.packages = [
    (pkgs.writeShellScriptBin "automatugen" ''
  if [ -z "$1" ]; then
    echo "Usage: automatugen <path-to-image> [extra-matugen-flags...]"
    exit 1
  fi

  WALLPAPER="$1"
  shift # 1. Remove the wallpaper path from the list of arguments

  # 2. Get brightness
  BRIGHTNESS=$(LC_NUMERIC=C ${pkgs.imagemagick}/bin/magick "$WALLPAPER" -colorspace gray -format "%[fx:100*mean]" info:)

  # 3. Decide Mode
  if (( $(echo "$BRIGHTNESS > 65" | ${pkgs.bc}/bin/bc -l) )); then
      MODE="light"
  else
      MODE="dark"
  fi

  echo "Detected: $BRIGHTNESS% ($MODE)"

  # 4. Run Matugen with Mode AND all extra flags ("$@")
  ${pkgs.matugen}/bin/matugen image "$WALLPAPER" -m "$MODE" "$@"
'')
  ];
}
