# Aperture — KDE Plasma 6 global theme

Pure black, logo orange (`#FF740D`) and logo blue (`#008CD4`). One look for the whole desktop:
colors, fonts, Plasma style, application style, wallpaper, lock screen, splash, terminal and editor.

![preview](assets/preview.png)

*Türkçe özet: Plasma 6 için tam siyah zeminli, turuncu-mavi global tema. Renk şeması, font, Plasma ve Kvantum stili, duvar kâğıdı, animasyonlu kilit ekranı, açılış ekranı, Konsole ve Kate temasını içerir. `./install.sh --apply` ile kurulur.*

## What is inside

| Part | Details |
|---|---|
| Color scheme | `Aperture.colors`: `#000000` window and view, orange selection, blue focus and links |
| Plasma style | opaque black panels with an orange outline, popups and notifications with a blue outline |
| Application style | Kvantum theme `Aperture` (based on KvFlat), visible control borders on black |
| Fonts | Noto Sans 10 (UI), Noto Sans Mono 10 (fixed) |
| Wallpaper | static wallpaper for the desktop, plus an animated wallpaper plugin for the lock screen |
| Lock screen | `org.aperture.animated`: breathing logo, ripples, glow that drifts from orange to blue |
| Splash | logo with a glow; the outer ring of the logo fills up as the session loads |
| Konsole | `Aperture.colorscheme` with a faint logo in the corner |
| Kate / KWrite | `Aperture.theme` syntax highlighting |
| Icons / cursor | `kora` icons and `Breeze_Light` cursor (not bundled, see requirements) |

## Requirements

- KDE Plasma 6 (developed on 6.8)
- [Kvantum](https://github.com/tsujan/Kvantum) (`sudo pacman -S kvantum`)
- Noto Sans and Noto Sans Mono (`noto-fonts`)
- optional: the `kora` icon theme. Without it the theme falls back to the default icons.

## Install

```sh
git clone https://github.com/alazndy/aperture-plasma.git
cd aperture-plasma
./install.sh --apply     # installs into ~/.local/share and ~/.config, then applies it
```

Without `--apply` the files are only copied and you can pick **Aperture** under
System Settings → Appearance → Global Theme. Log out and back in once so that
the splash, cursor and application style load together.

Remove it with `./uninstall.sh`.

### Login screen (Plasma Login Manager)

The login screen is configured by the system and needs administrator rights, so the
installer does not touch it. Open System Settings → Login Screen and press
**Apply Plasma Settings…** to copy colors and fonts to it.

## Notes

- The lock screen uses the animated wallpaper plugin. The desktop uses a static image; to animate
  the desktop too, choose **Aperture Animated** under Wallpaper.
- The animation only changes opacity and scale, so it is light on the CPU.
- The logo in `assets/logo.png` is used for the wallpaper, splash, start-menu icon and Konsole background.

## License

MIT, see [LICENSE](LICENSE). `assets/logo.png` is the project logo and is covered by the same license.
