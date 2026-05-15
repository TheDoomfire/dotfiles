# Dotfiles

This is my personal dotfiles repository.

## How to use


## TODO:

- Add .config/autostart ? 
- Add mint config ?
- Bootstrap file. To download the repo and run the install script?

**Apps: from .config**
- libreoffice (for dark mode)

### Neovim

- Add colors to .md files.
- Auto import functions you use if its found somewhere else.
- Add a way to surround a word/line with something. Like " " or whatever.
- add so I can add something like bash to markdown code blocks

#### Snippets


## Installation

Already have this locally?
```bash
bash install.sh
```

Download it:
```bash
git clone git@github.com:TheDoomfire/dotfiles.git ~/.dotfiles
~/.dotfiles/.config/system-settings/install.sh
```

Or try this:
```bash
git clone https://github.com/TheDoomfire/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

## Fixes

Older one folder version? The one without /home and /system

Uinstall stow:
```bash
stow -D .
find ~ -maxdepth 2 -xtype l -delete
```

Getting errors?
```bash
find ~ -maxdepth 2 -xtype l -delete
```

Need to re stow?
```bash
stow -R -v -t ~ home
```
