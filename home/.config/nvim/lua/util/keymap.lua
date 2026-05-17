local M = {}

-- Instead of using vim.keymap.set, use this function to set the leader key
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Runs a table of mappings
function M.mode_map(mode, mappings)
    for _, m in ipairs(mappings) do
        -- m[1] = lhs, m[2] = rhs, m[3] = opts
        M.map(mode, m[1], m[2], m[3])
    end
end


function M.bulk_map(map_table)
    for mode, mappings in pairs(map_table) do
        for _, m in ipairs(mappings) do
            -- m[1] = lhs, m[2] = rhs, m[3] = opts (if provided)
            M.map(mode, m[1], m[2], m[3])
        end
    end
end

return M
