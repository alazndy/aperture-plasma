#!/usr/bin/env bash
# Remove the Aperture theme files installed by install.sh.
set -euo pipefail
data="${XDG_DATA_HOME:-$HOME/.local/share}"
conf="${XDG_CONFIG_HOME:-$HOME/.config}"
rm -rf "$data/plasma/desktoptheme/Aperture" "$data/plasma/look-and-feel/Aperture" \
       "$data/wallpapers/Aperture" "$data/plasma/wallpapers/org.aperture.animated" \
       "$conf/Kvantum/Aperture" "$data/color-schemes/Aperture.colors" \
       "$data/konsole/Aperture.colorscheme" "$data/konsole/aperture-bg.png" \
       "$data/org.kde.syntax-highlighting/themes/Aperture.theme"
find "$data/icons/hicolor" -name 'aperture-logo.png' -delete 2>/dev/null || true
echo "Aperture removed. Switch to another global theme in System Settings."
