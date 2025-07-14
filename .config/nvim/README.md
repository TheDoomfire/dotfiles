# Beginner Neovim Config

Learning configurations.

## TODO:

Learn vim motions.

### Add these

**General**

- **Auto imports** - Auto add imports if I type a function name. Or just warn and let me choose what to import.
- **Git pull** - Auto pull on start (if no conflicts).
- **Show vim modes more clearly** I only show at bottom but perhaps on top too and maybe somewhere else?
- **List all projects** that have a .git folder? So I can pick what to work on today.
- **Easy Git** I do git push/pull daily. Hopefully somewhere where the commands is saved if I have to do stuff I dont do reguarly.
- **Close Brackets** - Close for example a function, so the code dont show up.
- **Multiline edit** - Edit multiple lines at once.

- **Auto Sessions** add this on start :lua MiniSessions.write("main") it can be any name! But only need to run if Sessions.vim dosn't exist.


**Python**

- **.venv at start** I want my virtual enviroment to just work on start.

**Start**
Choose project, open projects with everything open.

**While**
Auto prettify, lint, save.

**End**
Write to file, format/lint, push to git.

### Fixes

- Telescope

1. Remove .git (and all .gitignore) from search.

- Neo tree

1. Show all files if there is place for it.
1. Have the **file system reveal left** on start. To show the file tree at start.

## Keys

1. :q - closes
1. :w - writes/saves

1. hjkl - move cursor around. Like arrow keys.
1. dd - deletes the line.
1. yyp - yank line + past down.
1. ciw - change word.

**Windows**

1. :vnew - new window
1. ctrl+w - switches.
1. ctrl+w+c - closes window.
1. CTRL+w+T - moves window to tab.
1. - x - Swaps window to the next window.
1. - - (hjkl) - move to h, j, k, l.
1. - - (r/R) - Rotate clockwise/counter-clockwise.

**Tabs**

1. :tabnew - new tab.
1. gt - switches tabs.
