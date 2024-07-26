# dotfiles

My configuration files for Linux.

## Installation

Clone repo and install submodules
```
git clone <url>
cd dotfiles/
git submodules init
git submodules update
```

I use my tool [Dottyper](https://github.com/kompoth/dottyper) to manage this stuff. File `dottyper.yaml` contains instructions for it.

## Submodules

To add a new submodule, execute
```
git submodule add <url>
```
It's better to use http urls as we don't need to edit submodule repos.

To remove a submodule from this repo, execute
```
git rm <path-to-submodule>
rm -rf .git/modules/<path-to-submodule>
git config --remove-section submodule.<path-to-submodule>
```
