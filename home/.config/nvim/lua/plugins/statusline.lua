local my_config = require("config")

-- For pretty status lines.
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Cache for git behind/ahead status, refreshed async
    local git_sync_status = ''

    local function refresh_git_sync_status()
      local cwd = vim.fn.getcwd()
      if vim.fn.isdirectory(cwd .. '/.git') == 0 then
        git_sync_status = ''
        return
      end

      -- fetch quietly in the background, then compute ahead/behind
      vim.fn.jobstart('git fetch --quiet', {
        on_exit = function()
          vim.fn.jobstart(
            { 'git', 'rev-list', '--left-right', '--count', 'HEAD...@{u}' },
            {
              stdout_buffered = true,
              on_stdout = function(_, data)
                if not data or not data[1] or data[1] == '' then
                  git_sync_status = ''
                  return
                end
                local ahead, behind = data[1]:match('(%d+)%s+(%d+)')
                local parts = {}
                if behind and tonumber(behind) > 0 then
                  table.insert(parts, '⇣' .. behind)
                end
                if ahead and tonumber(ahead) > 0 then
                  table.insert(parts, '⇡' .. ahead)
                end
                git_sync_status = table.concat(parts, ' ')
              end,
            }
          )
        end,
      })
    end

    -- Refresh on entering nvim, switching buffers, or focusing the window again
    vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'FocusGained' }, {
      callback = refresh_git_sync_status,
    })

    require('lualine').setup({
      options = {
        theme = 'auto',
      },
      sections = {
        lualine_b = {
          'branch',
          'diff',
          {
            function()
              return git_sync_status
            end,
            color = { fg = my_config.ui.warning },
          },
        },
      },
    })
  end,
}
