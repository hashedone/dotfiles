local material = require 'material.colors'

local colors = {
    --    bg_a = '#252a30',
    --    bg_b = '#2f3538',
    --    bg_c = '#2d3338',
    bg_a = material.bg_alt,
    bg_b = '#252a30',
    bg_c = '#2d3338',
    fg_c = material.text,
    modes = {
        n = material.blue,
        i = material.green,
        v = material.purple,
        r = material.red,
        c = material.yellow,
        t = material.orange,
        inactive = material.disabled
    },
}

vim.api.nvim_set_hl(0, 'DiffAdd', { fg = material.green })
vim.api.nvim_set_hl(0, 'DiffChange', { fg = material.darkyellow })
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = material.red })

return {
    normal = {
        a = { bg = colors.bg_a, fg = colors.modes.n, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.n },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    insert = {
        a = { bg = colors.bg_a, fg = colors.modes.i, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.i },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    visual = {
        a = { bg = colors.bg_a, fg = colors.modes.v, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.v },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    replace = {
        a = { bg = colors.bg_a, fg = colors.modes.r, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.r },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    command = {
        a = { bg = colors.bg_a, fg = colors.modes.c, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.c },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    terminal = {
        a = { bg = colors.bg_a, fg = colors.modes.t, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.t },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
    inactive = {
        a = { bg = colors.bg_a, fg = colors.modes.inactive, gui = 'bold' },
        b = { bg = colors.bg_b, fg = colors.modes.inactive },
        c = { bg = colors.bg_c, fg = colors.fg_c },
    },
}
