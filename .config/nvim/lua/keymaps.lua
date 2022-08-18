local wk = require 'which-key'

local M = {}

function M.setup()
    wk.setup {}

    local opts = { noremap = true, silent = true }
    local term_opts = { silent = true }

    local keys = vim.keymap

    vim.g.mapleader = ';'
    vim.g.maplocalleader = ';'

    -- Navigation

    keys.set('n', '<C-h>', '<C-w><C-h>', opts)
    keys.set('n', '<C-j>', '<C-w><C-j>', opts)
    keys.set('n', '<C-k>', '<C-w><C-k>', opts)
    keys.set('n', '<C-l>', '<C-w><C-l>', opts)

    -- Navigation on wraps

    keys.set({ 'n', 'v' }, 'j', 'gj', opts)
    keys.set({ 'n', 'v' }, 'k', 'gk', opts)

    -- Better terminal navigation

    keys.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    keys.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    keys.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    keys.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

    -- Resize with arrows

    keys.set('n', '<C-Up>', ':resize +2<cr>', opts)
    keys.set('n', '<C-Down>', ':resize -2<cr>', opts)
    keys.set('n', '<C-Left>', ':vertical resize -2<cr>', opts)
    keys.set('n', '<C-Right>', ':vertical resize +2<cr>', opts)

    -- Stay in indent mode in visual

    keys.set("v", "<", "<gv", opts)
    keys.set("v", ">", ">gv", opts)
    keys.set("v", "p", '"_dP', opts)

    -- Move text up and down
    keys.set("v", "<A-j>", ":m .+1<CR>==", opts)
    keys.set("v", "<A-k>", ":m .-2<CR>==", opts)


    -- Utility

    keys.set('n', '<Leader><cr>', ':nohl<cr>', opts)
    keys.set('c', 'mk.', '!mkdir -p <C-r>=expand("%:h")<cr>/', opts)

    -- GH copilot
    keys.set('i', '<M-cr>', 'copilot#Accept("")', {
        silent = true,
        expr = true,
    })
    keys.set('n', '<Leader>cc', ':Copilot<cr?', opts)
end

return M
