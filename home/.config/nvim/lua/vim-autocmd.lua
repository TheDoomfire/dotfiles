-- TEMPLATES

-- ADD: Templates for:
-- README.md
-- .gitignore

-- Define your template directory for easier access
local template_dir = os.getenv("HOME") .. "/.config/nvim/templates/"

-- TODO: Add more templates
local templates = {
  py = "python.tpl",
  -- js = "javascript.tpl",
  -- html = "html.tpl",
  astro = "astro.tpl",
  md = "markdown.tpl",
  -- njk = "nunjucks.tpl",
  sh = "bash.tpl",
}

local config_templates = {
  py = "python_config.tpl",
  -- js = "js_config.tpl",
}

-- Extract keys and turn them into patterns
local function get_patterns(t1, t2)
  local patterns = {}
  local seen = {} -- To avoid duplicates if 'py' is in both tables

  local function add_keys(t)
    for ext, _ in pairs(t) do
      if not seen[ext] then
        table.insert(patterns, "*." .. ext)
        seen[ext] = true
      end
    end
  end

  add_keys(t1)
  add_keys(t2)
  return patterns
end


local function apply_variables()
  local vars = {
    ["{{DATE}}"] = os.date("%Y-%m-%d"),
    ["{{YEAR}}"] = os.date("%Y"),
    -- ["{{TITLE}}"] = vim.fn.expand("%:t:r"), -- Filename without extension
    ["{{FILETYPE}}"] = vim.bo.filetype,
    ["{{TITLE}}"] = (function()
      -- Get filename without extension
      local name = vim.fn.expand("%:t:r")

      -- 1. Replace dashes and underscores with spaces
      name = name:gsub("[%-_]", " ")

      -- 2. Capitalize the first letter of each word
      -- %f[%a] is a frontier pattern that finds the start of a word
      name = name:gsub("%f[%a]%a", string.upper)

      return name
    end)(),
    ["{{GIT_USER}}"] = vim.fn.system("git config user.name"):gsub("\n", ""),
  }

  for i = 1, vim.api.nvim_buf_line_count(0) do
    local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    for placeholder, value in pairs(vars) do
      line = line:gsub(placeholder, value)
    end
    vim.api.nvim_buf_set_lines(0, i - 1, i, false, { line })
  end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = get_patterns(templates, config_templates),
  callback = function()
    -- Only proceed if the file is empty
    if vim.fn.line("$") ~= 1 or vim.fn.getline(1) ~= "" then
      return
    end

    local extension = vim.fn.expand("%:e")
    local filename = vim.fn.expand("%:t")
    local template_file = templates[extension]

    -- Checks if 'config' is in the name AND we have a template for that extension
    if filename:find("config") and config_templates[extension] then
      template_file = config_templates[extension]
    end

    -- If we found a matching template, read it into the buffer
    if template_file then
      local path = template_dir .. template_file
      -- Check if the template file actually exists before trying to read it
      if vim.fn.filereadable(path) == 1 then
        -- Insert template content
        vim.cmd("0r " .. path)
        -- Process the placeholders
        apply_variables()
      end
    end
  end,
})

-- -- Have to add BufReadPost to make it work if I generate a file with a plugin.
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
--     pattern = "*.py",
--     callback = function()
--         -- Only insert template if the file is empty
--         if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
--             vim.cmd("0r ~/.config/nvim/templates/python.tpl")
--         end
--     end,
-- })
