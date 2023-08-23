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

