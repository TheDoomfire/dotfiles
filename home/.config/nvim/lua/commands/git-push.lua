local M = {}
-- Define a custom command "GitPush" with optional commit message
vim.api.nvim_create_user_command("GitPush", function(opts)
  -- Get the commit message from arguments or default to "misc"
  local message = #opts.fargs > 0 and table.concat(opts.fargs, " ") or "misc - [vim]"

  -- Run git add .
  local add_success = os.execute("git add .")
  if add_success ~= 0 then
    print("❌ Failed to add changes!")
    return
  end

  -- Run git commit
  local commit_success = os.execute(string.format('git commit -m "%s"', message))
  if commit_success ~= 0 then
    print("❌ Commit failed!")
    return
  end
  -- Run git push

  local push_success = os.execute("git push")
  if push_success ~= 0 then
    print("❌ Push failed! Check for conflicts or upstream issues.")
    return
  end

  print("✅ Successfully added, committed, and pushed!")
end, { nargs = "*" }) -- Accepts any number of arguments

return M
