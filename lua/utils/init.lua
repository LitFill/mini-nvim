---@return string
function GetShortPath()
    local buf_path = vim.api.nvim_buf_get_name(0)
    if buf_path == "" then
        return "" -- Jika buffer kosong, tidak tampilkan apa-apa
    end

    local home = vim.fn.expand "$HOME"
    local project_home = home .. "/proyek"

    if buf_path:find("^" .. vim.pesc(project_home)) then
        buf_path = buf_path:gsub("^" .. vim.pesc(project_home) .. "/", "")
    elseif buf_path:find("^" .. vim.pesc(home)) then
        buf_path = buf_path:gsub("^" .. vim.pesc(home) .. "/", "")
    end

    local display_path1 = buf_path:gsub("//", "/")
    local display_path = display_path1:gsub("/", " -> ")

    return "%#MiniIconsPurple#  LitFill :: " .. display_path
end

function ToggleSplitDirection()
    if vim.fn.winnr '$'  ~= 2 then
        print "Error: Requires exactly two windows"
        return
    end
    local win_pos1 = vim.fn.win_screenpos(1)
    local win_pos2 = vim.fn.win_screenpos(vim.fn.winnr '$')
    if win_pos1[1] == win_pos2[1] then  -- Vertical split
        if vim.fn.winnr() == 1 then
            vim.cmd 'wincmd K'
        else
            vim.cmd 'wincmd J'
        end
    else  -- Horizontal split
        if vim.fn.winnr() == 1 then
            vim.cmd 'wincmd H'
        else
            vim.cmd 'wincmd L'
        end
    end
end

function ListBuffers()
    local buffers = vim.fn.getbufinfo()
    for _, buf in ipairs(buffers) do
        local mod = buf.changed == 1 and '[+]' or ''
        print(buf.bufnr .. ': ' .. buf.name .. ' ' .. mod)
    end
end

function DeleteInactiveBuffers()
    local buffers = vim.fn.getbufinfo()
    for _, buf in ipairs(buffers) do
        if buf.hidden == 1 and buf.changed == 0 then
            vim.cmd('bdelete ' .. buf.bufnr)
        end
    end
    print ""
    print 'Inactive buffers deleted'
end

function SwitchBuffer()
    local bufnum = vim.fn.input 'Buffer number: '
    if tonumber(bufnum) and vim.fn.bufexists(tonumber(bufnum)) == 1 then
        vim.cmd('buffer ' .. bufnum)
    else
        print ' Invalid buffer'
    end
end

function WipeoutBuffers()
    vim.cmd 'silent! %bdelete|edit #|normal `"'
end
