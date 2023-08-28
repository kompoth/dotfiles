# dotfiles

My configuration files for Linux.

## Installation

### New script

It's more reliable, easier to maintain and configure, but maybe it doesn't worth it ...

Requires Python >= 3.11.
```bash
python -m venv venv
pip install -r requirements.txt
python manage.py deploy
deactivate
```

Edit `config_manage.yml` to config dotfiles deployment.

Use `python manage.py clean` to remove installation.

### Old script

Use `install` script to put all files in places.
- -i option creates neccessary links
- -e option loads external repos and scripts
- -c cleans links

## Notes

### urxvt

I use rxvt-unicode-9.30 currently. Version 9.31 has some issues:
- In tiling mode new window is created with blank lines. See [workaround](https://wiki.archlinux.org/title/rxvt-unicode#Wrong_window_geometry).
- With fix above window gets unreasonable dimensions in floating mode.

To get dynamic font size changing in urxvt I use [this plugin](https://github.com/majutsushi/urxvt-font-size).
It works great in tiling mode, but in floating mode it also changes window dimensions.
To fix that you'll have to apply [this patch](https://github.com/majutsushi/urxvt-font-size/issues/10#issuecomment-813040385).
