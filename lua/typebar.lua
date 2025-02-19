local function elem(x, xs)
    for _, xi in ipairs(xs) do
        if xi == x then
            return true
        end
    end
    return false
end

local M = {}

---@return string
function M.get_path()
    return vim.fn.expand "%:p"
end

---@param path string
---@return string
function M.path_after_proyek(path)
    -- return vim.fn.sub(path, 14)
    return path
end

---@param path string
---@return string
function M.format_path(path)
    if path == "" then
        return ""
    end
    ---@type string[]
    local parts = {}
    for part in string.gmatch(path, "([^/]+)") do
        if not elem(part, {'root'}) then
        table.insert(parts, part)
    end
    end
    local formatted = table.concat(parts, " -> ")
    return "LitFill :: " .. formatted
end

function M.show_path()
    local path = M.path_after_proyek(M.get_path())
    if path == "" then
        return
    end
    local formatted = M.format_path(path)
    vim.o.winbar = formatted
end

return M
