#!/usr/bin/env bash
# Install the Aperture KDE Plasma 6 theme into the current user's home.
# Usage: ./install.sh [--apply]
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
data="${XDG_DATA_HOME:-$HOME/.local/share}"
conf="${XDG_CONFIG_HOME:-$HOME/.config}"

install_dir() { mkdir -p "$2"; cp -r "$1/." "$2/"; }

install_dir "$here/color-schemes"                         "$data/color-schemes"
install_dir "$here/plasma/desktoptheme/Aperture"          "$data/plasma/desktoptheme/Aperture"
install_dir "$here/plasma/look-and-feel/Aperture"         "$data/plasma/look-and-feel/Aperture"
install_dir "$here/plasma/wallpapers/Aperture"            "$data/wallpapers/Aperture"
install_dir "$here/plasma/wallpapers/org.aperture.animated" "$data/plasma/wallpapers/org.aperture.animated"
install_dir "$here/icons/hicolor"                         "$data/icons/hicolor"
install_dir "$here/kvantum/Aperture"                      "$conf/Kvantum/Aperture"
install_dir "$here/syntax-highlighting"                   "$data/org.kde.syntax-highlighting/themes"
install_dir "$here/konsole"                               "$data/konsole"
sed -i "s#@KONSOLE_DIR@#$data/konsole#" "$data/konsole/Aperture.colorscheme"
rm -f "$data/konsole/aperture-bg.png.bak"

gtk-update-icon-cache -f -t "$data/icons/hicolor" >/dev/null 2>&1 || true
echo "Aperture installed."

if [[ "${1:-}" == "--apply" ]]; then
  kwriteconfig6 --file "$conf/Kvantum/kvantum.kvconfig" --group General --key theme Aperture
  lookandfeeltool -a Aperture
  plasma-apply-wallpaperimage "$data/wallpapers/Aperture/contents/images/3840x2160.png"
  kwriteconfig6 --file kscreenlockerrc --group Greeter --key WallpaperPlugin org.aperture.animated
  kwriteconfig6 --file kscreenlockerrc --group Greeter --group Wallpaper --group org.aperture.animated --group General --key Centered true
  for k in font toolBarFont menuFont; do kwriteconfig6 --file kdeglobals --group General --key $k "Noto Sans,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"; done
  kwriteconfig6 --file kdeglobals --group General --key fixed "Noto Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  kwriteconfig6 --file kdeglobals --group General --key AccentColor "255,116,13"
  kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile "Profile 1.profile"
  for f in katerc kwriterc; do
    kwriteconfig6 --file $f --group "KTextEditor Renderer" --key "Color Theme" Aperture
  done
  echo "Applied. Log out and back in to load everything."
else
  echo "Run './install.sh --apply' or pick \"Aperture\" in System Settings > Appearance."
fi
