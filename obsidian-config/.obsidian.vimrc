" --- Clipboard ---
" unnamedplus isn't always supported; unnamed is the standard for sync
set clipboard=unnamed

" --- Leaders ---
" In the emulator, you must unmap space before using it as a leader
unmap <Space>
" Note: The plugin doesn't use 'mapleader' variables like Neovim. 
" You just use <Space> directly in your mappings.

" --- Navigation ---
" Since Obsidian is a prose editor, you'll likely want these:
nmap j gj
nmap k gk
