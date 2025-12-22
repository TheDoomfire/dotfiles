-- local M = {}

-- -- Check if the current directory is a Git repository
-- local function is_git_repo()
--   local cwd = vim.fn.getcwd()
--   local git_dir = cwd .. "/.git"
--   return vim.loop.fs_stat(git_dir) ~= nil
-- end

-- -- Execute Git pull and handle conflicts
-- function M.auto_pull()
--   if not is_git_repo() then
--     return
--   end

--   -- Run git pull
--   vim.fn.jobstart({ "git", "pull" }, {
--     cwd = vim.fn.getcwd(),
--     on_exit = function(_, code, _)
--       if code ~= 0 then
--         vim.notify("Git pull failed!", vim.log.levels.ERROR)
--         return
--       end

--       -- Check for merge conflicts
--       vim.fn.jobstart({ "git", "diff", "--check", "--quiet" }, {
--         cwd = vim.fn.getcwd(),
--         on_exit = function(_, conflict_code, _)
--           if conflict_code == 0 then
--             vim.notify("✅ Auto-pulled successfully!", vim.log.levels.INFO)
--           else
--             vim.notify("⚔️ Merge conflicts detected!", vim.log.levels.WARN)
--           end
--         end,
--       })
--     end,
--   })
-- end

-- return M



-- local M = {}

-- -- Check if the current directory is a Git repository
-- local function is_git_repo()
--   local cwd = vim.fn.getcwd()
--   return vim.loop.fs_stat(cwd .. "/.git") ~= nil
-- end

-- -- Check for uncommitted changes (working tree or index)
-- local function has_local_changes()
--   local cwd = vim.fn.getcwd()
--   -- Exit code 0 = no changes; 1 = changes present
--   local ok = vim.fn.systemlist("git diff-index --quiet HEAD --", cwd) == {}
--     and vim.fn.jobwait({ vim.fn.jobstart({ "git", "diff-index", "--quiet", "--cached", "HEAD", "--" }, { cwd = cwd }) }, 1000)[1] == 0
--   -- Alternatively, use porcelain mode:
--   -- local stats = vim.fn.systemlist("git status --porcelain", cwd)
--   -- local ok = vim.tbl_isempty(stats)
--   return not ok
-- end

-- -- Execute Git pull and handle conflicts, only if clean
-- function M.auto_pull()
--   if not is_git_repo() then
--     return
--   end

--   if has_local_changes() then
--     vim.notify("⚠️ Local changes detected — aborting auto‑pull!", vim.log.levels.WARN)
--     return
--   end

--   -- Run git pull
--   vim.fn.jobstart({ "git", "pull" }, {
--     cwd = vim.fn.getcwd(),
--     on_exit = function(_, code, _)
--       if code ~= 0 then
--         vim.notify("❌ Git pull failed!", vim.log.levels.ERROR)
--         return
--       end

--       -- Check for merge conflicts
--       vim.fn.jobstart({ "git", "diff", "--check", "--quiet" }, {
--         cwd = vim.fn.getcwd(),
--         on_exit = function(_, conflict_code, _)
--           if conflict_code == 0 then
--             vim.notify("✅ Auto‑pulled successfully!", vim.log.levels.INFO)
--           else
--             vim.notify("⚔️ Merge conflicts detected!", vim.log.levels.WARN)
--           end
--         end,
--       })
--     end,
--   })
-- end

-- return M
