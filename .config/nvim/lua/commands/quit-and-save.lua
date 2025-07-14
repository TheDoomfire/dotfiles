vim.api.nvim_create_user_command("ByeBye", function(opts)
  vim.cmd("wa")

  -- Capture GitPush success status
  local success = pcall(function()
    if #opts.fargs > 0 then
      vim.cmd("GitPush " .. table.concat(opts.fargs, " "))
    else
      vim.cmd("GitPush")
    end
  end)

  if success then
    vim.cmd("qa")
  else
    vim.notify("💤 Staying open due to push failure", vim.log.levels.WARN)
  end
end, { nargs = "*" })
