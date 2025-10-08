-- Autocommands

--- Helper function for making autocommands
---@param trigger string|string[]
---@return fun(opts: vim.api.keyset.create_autocmd): integer
local mk_aucmd = function(trigger)
    ---@param opts vim.api.keyset.create_autocmd
    return function(opts)
        return vim.api.nvim_create_autocmd(trigger, opts)
    end
end

mk_aucmd "BufWritePre" {
    pattern = "*",
    callback = require("mini.trailspace").trim,
}

local haskell_config = require "config.haskell"

mk_aucmd "FileType" {
    pattern = { "haskell", "cabal", "*.hs", "*.cabal" },
    callback = haskell_config.setup_haskell_keymaps,
}

-- -- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "rust", "cargo", "*rs", "Cargo.toml" },
--     callback = function()
--         vim.o.makeprg = "cargo build"
--     end,
-- })

mk_aucmd {"BufEnter", "BufWinEnter"} {
    pattern = "*",
    callback = function()
        vim.o.winbar = "%{%v:lua.GetShortPath()%}"
    end,
}

--- Create a custom user command
---@param name string
---@return fun(command: string|fun(args: vim.api.keyset.create_user_command.command_args)):fun(opts: vim.api.keyset.user_command)
local mk_usercmd = function(name)
    return function(command)
        return function(opts)
            vim.api.nvim_create_user_command(name, command, opts)
        end
    end
end

local open_file_with_unison = function(opts)
    local filename = opts.args
    local win = vim.api.nvim_get_current_win()
    vim.cmd "vsplit | term ucm"
    vim.defer_fn(function()
        vim.api.nvim_set_current_win(win)
        vim.cmd("e " .. vim.fn.fnameescape(filename))
    end, 200)
end

mk_usercmd "WithUnison" (open_file_with_unison) {
    nargs = 1,
    desc = "Open a unison file with lsp"
}

local signcolumnGroup =
    vim.api.nvim_create_augroup(
        "PersistentSigncolumn",
        { clear = true }
    )

mk_aucmd "BufEnter" {
    group = signcolumnGroup,
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" and vim.wo.signcolumn ~= "yes:2" then
            vim.opt.signcolumn = "yes:2"
        end
    end,
    desc = "Ensure signcolumn is always 'yes:2' in normal buffers",
}

mk_aucmd "BufReadPost" {
    pattern = "*.m",
    callback = function()
        local file_path = vim.api.nvim_buf_get_name(0)
        local dir_path = vim.fn.fnamemodify(file_path, ":h")
        local dir_name = vim.fn.fnamemodify(dir_path, ":t")
        vim.opt_local.makeprg = "mmc --make " .. vim.fn.escape(dir_name, " ")
    end,
}

mk_usercmd "Cd" "cd %:h" {
    nargs = 0,
    desc = "cd to current opened file"
}

mk_aucmd "BufEnter" {
    pattern = "*.csv",
    callback = function()
        require("csvview").setup {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
            cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
        }
        vim.cmd "CsvViewToggle display_mode=border header_lnum=1"
    end,
}

--- add desc to opts for set
---
---@param opts? vim.keymap.set.Opts
---@param description string
---@return vim.keymap.set.Opts
local function desc(description, opts)
    if not opts then return { desc = description } end
    opts.desc = description
    return opts
end

mk_aucmd { "BufRead", "BufNewFile" } {
    pattern = "*.agda",
    callback = function()
        local map    = vim.keymap.set
        local bufopt = { buffer = true }
        local d = function(msg) desc(msg, bufopt) end

        map('n', '<leader>l', ':CornelisLoad<CR>',             d "Cornelis: Load file"            )
        map('n', '<leader>r', ':CornelisRefine<CR>',           d "Cornelis: Refine"               )
        map('n', '<leader>d', ':CornelisMakeCase<CR>',         d "Cornelis: Case split"           )
        map('n', '<leader>,', ':CornelisTypeContext<CR>',      d "Cornelis: Type and Context"     )
        map('n', '<leader>.', ':CornelisTypeContextInfer<CR>', d "Cornelis: Type, Context, Infer" )
        map('n', '<leader>s', ':CornelisSolve<CR>',            d "Cornelis: Solve goal"           )
        map('n', '<leader>a', ':CornelisAuto<CR>',             d "Cornelis: Auto proof search"    )
        map('n', 'gd',        ':CornelisGoToDefinition<CR>',   d "Cornelis: Go to Definition"     )
        map('n', '[/',        ':CornelisPrevGoal<CR>',         d "Cornelis: Previous Goal"        )
        map('n', ']/',        ':CornelisNextGoal<CR>',         d "Cornelis: Next Goal"            )
        map('n', '<C-A>',     ':CornelisInc<CR>',              d "Cornelis: Increment"            )
        map('n', '<C-X>',     ':CornelisDec<CR>',              d "Cornelis: Decrement"            )

        mk_aucmd "BufWritePost" {
            pattern = "*.agda",
            command = "CornelisLoad",
        }

        vim.g.cornelis_agda_prefix    = "\\"
        vim.g.cornelis_max_size       = 30
        vim.g.cornelis_max_width      = 40
        vim.g.cornelis_split_location = 'right'
    end,
}

mk_aucmd "QuitPre"
    { pattern = "*.agda"
    , command = "CornelisCloseInfoWindows"
    }
