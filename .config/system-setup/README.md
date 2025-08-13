# Bootstrap OS

Run this after a fresh OS install to install and configure the OS.

## Install
```bash
git clone git@github.com:TheDoomfire/dotfiles.git
~/.dotfiles/.config/system-settings/install.sh
```

## Finding System Settings

Monitor settings changes:

1. **Monitor settings changes**:
   ```bash
   dconf watch /```
1. **Convert it**:
```bash
/org/cinnamon/desktop-effects-workspace false  
↓ becomes ↓  
gsettings set org.cinnamon desktop-effects-workspace false```

1. **Add it to:**: `/system-settings/ANY-NAME.sh`
