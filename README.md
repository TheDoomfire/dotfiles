# Dotfiles

This is my personal dotfiles repository.

## TODO:

- Add .config/autostart ? 
- Add mint config ?
- Bootstrap file. To download the repo and run the install script?

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
