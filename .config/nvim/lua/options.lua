-- Basic options setup

local M = {}

function M.setup()
    vim.opt.cmdheight = 2
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    vim.opt.scrolloff = 10
    vim.opt.sidescrolloff = 8
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.syntax = "on"

    vim.opt.lcs = "tab:→-,trail:·,nbsp:_"

    vim.opt.autoindent = true
    vim.opt.copyindent = true
    vim.opt.expandtab = true
    vim.opt.modeline = true
    vim.opt.smartindent = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.foldmethod = "syntax"

    vim.opt.showmatch = true
    vim.opt.matchtime = 0
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.swapfile = false

    vim.opt.fileencoding = "utf-8"
    vim.opt.wrap = false
    vim.opt.linebreak = true

    vim.opt.backspace = "indent,eol,start"

    vim.opt.smartcase = true
    vim.opt.ignorecase = true
    vim.opt.hlsearch = false
    vim.opt.incsearch = true

    vim.opt.splitright = true
    vim.opt.splitbelow = true

    vim.opt.tagcase = "smart"

    vim.opt.mouse = "a"

    vim.opt.conceallevel = 2

    vim.opt.foldlevelstart = 99

    vim.opt.clipboard = "unnamedplus"
    vim.opt.completeopt = { "menuone", "noselect", "preview", "noinsert" }

    vim.opt.pumheight = 10
    vim.opt.showmode = false

    vim.opt.showtabline = 2

    vim.opt.undofile = true

    vim.opt.termguicolors = true
    vim.opt.laststatus = 3

    vim.cmd "set whichwrap+=<,>,[,],h,l"
    vim.cmd [[set iskeyword+=-]]

    vim.diffopt = "vertical"
end

return M
