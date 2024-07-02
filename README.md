# dotfiles

My configuration files for Linux.

## Installation

I use my tool [Dottyper](https://github.com/kompoth/dottyper) to manage this stuff.

## Notes

### Fonts

I prefere to use [Iosevka Term Extended](https://typeof.net/Iosevka/) in terminal.
It's better to download and install it manually:
```bash
export IOSEVKA_VER=27.3.5
curl -L https://github.com/be5invis/Iosevka/releases/download/v${IOSEVKA_VER}/ttf-iosevka-term-${IOSEVKA_VER}.zip -o iosevka.zip
unzip iosevka.zip -d ~/.local/share/fonts/
fc-cache
```

I use Chromium which might have problems with emojis and some languages.
This can be fixed by installing some font packages:
```bash
sudo pacman -S adobe-source-han-sans-otc-fonts
sudo pacman -S ttf-dejavu
sudo pacman -S noto-fonts-emoji 
```
