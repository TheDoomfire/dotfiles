return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      session_lens = {
        load_on_setup = true, -- Initialize on startup (requires Telescope)
        theme_conf = {
          border = true,
        },
        previewer = false, -- File preview for session picker
-- auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
      },
    })

     -- -- List Sessions - Shows all the sessions.
     --  vim.keymap.set("n", "<Leader>ls", require("auto-session.session-lens").search_session, { noremap = true })

    --       -- Create a custom command to list sessions
    -- vim.api.nvim_create_user_command("SessionSearch", function()
    --   require("auto-session.session-lens").search_session()
    -- end, {}),
    -- })
  end,
}

-- Error: 
--
-- Failed to run `config` for auto-session
--
-- /home/emma/.config/nvim/lua/plugins/sessions.lua:20: module 'auto-session.session-lens' not found:
--         no field package.preload['auto-session.session-lens']
--         cache_loader: module 'auto-session.session-lens' not found
--         cache_loader_lib: module 'auto-session.session-lens' not found
--         no file './auto-session/session-lens.lua'
--         no file '/home/runner/work/neovim/neovim/.deps/usr/share/luajit-2.1/auto-session/session-lens.lua'
--         no file '/usr/local/share/lua/5.1/auto-session/session-lens.lua'
--         no file '/usr/local/share/lua/5.1/auto-session/session-lens/init.lua'
--         no file '/home/runner/work/neovim/neovim/.deps/usr/share/lua/5.1/auto-session/session-lens.lua'
--         no file '/home/runner/work/neovim/neovim/.deps/usr/share/lua/5.1/auto-session/session-lens/init.lua'
--         no file './auto-session/session-lens.so'
--         no file '/usr/local/lib/lua/5.1/auto-session/session-lens.so'
--         no file '/home/runner/work/neovim/neovim/.deps/usr/lib/lua/5.1/auto-session/session-lens.so'
--         no file '/usr/local/lib/lua/5.1/loadall.so'
--         no file './auto-session.so'
--         no file '/usr/local/lib/lua/5.1/auto-session.so'
--         no file '/home/runner/work/neovim/neovim/.deps/usr/lib/lua/5.1/auto-session.so'
--         no file '/usr/local/lib/lua/5.1/loadall.so'
--
-- # stacktrace:
--   - ~/.config/nvim/lua/plugins/sessions.lua:20 _in_ **config**
--   - home/.config/nvim/init.lua:54
