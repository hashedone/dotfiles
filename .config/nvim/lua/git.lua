local M = {}

local gitsigns = require 'gitsigns'

local telescope = require 'telescope.builtin'
local wk = require 'which-key'

function M.setup()
    gitsigns.setup()

    wk.register({
        g = {
            name = "git",
            l = { telescope.git_commits, "Log" },
            b = { telescope.git_branches, "Branches" },
            s = { telescope.git_stash, "Stash" },
            S = { telescope.git_status, "Status" },
        }
    }, { prefix = "<Leader>" })
end

return M
