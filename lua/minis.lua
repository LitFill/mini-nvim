--- list of mini.nvim family ofplugins I want to be activated
---@type string[]
local enabled_modules = {
    "ai",
    "align",
    "bracketed",
    "comment",
    "completion",
    "cursorword",
    "diff",
    "doc",
    "extra",
    "files",
    "git",
    "icons",
    "indentscope",
    "jump",
    "jump2d",
    "move",
    "notify",
    "operators",
    "pairs",
    "pick",
    "splitjoin",
    "starter",
    "statusline",
    "surround",
    "tabline",
    "trailspace",
}

for _, module in ipairs(enabled_modules) do
    local mod = "mini." .. module
    require(mod).setup()
end

local miniclue = require "mini.clue"
miniclue.setup {
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
}

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup {
    snippets = {
        -- Load custom file with global snippets first (adjust for Windows)
        gen_loader.from_file "~/.config/nvim/snippets/global.json",

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        gen_loader.from_lang(),
    },
}

require("mini.files").setup {
    windows = {
        preview = true,
        width_preview = 60,
    },
}
