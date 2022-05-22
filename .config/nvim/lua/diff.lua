local M = {}

local diffview = require 'diffview'

function M.setup()
    diffview.setup {
        enhanced_diff_hl = true,
    }
end
