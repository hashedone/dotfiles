-- Use a protected call so we don't error out on first use
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local M = {}

local function bootstrap()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    end
end

local function setup_autocmd()
    vim.cmd [[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
    ]]
end

local function init()
    packer.init {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }
end

local function setup_plugins()
    return packer.startup(function(use)
        use 'wbthomason/packer.nvim' -- Packer self-manage
        use 'marko-cerovac/material.nvim' -- Colorscheme
        use 'nvim-lua/plenary.nvim' -- Utility

        use 'folke/which-key.nvim' -- Better keybindings

        use 'rcarriga/nvim-notify' -- Notifications
        use 'nvim-lua/popup.nvim' -- Better popups

        use "hrsh7th/nvim-cmp" -- The completion plugin
        use "hrsh7th/cmp-buffer" -- buffer completions
        use "hrsh7th/cmp-path" -- path completions
        use "hrsh7th/cmp-cmdline" -- cmdline completions
        use "L3MON4D3/LuaSnip" --snippet engine
        use "saadparwaiz1/cmp_luasnip" -- snippet completions

        -- LSPs config
        use 'neovim/nvim-lspconfig'
        use 'williamboman/nvim-lsp-installer'
        use 'hrsh7th/cmp-nvim-lua'
        use 'hrsh7th/cmp-nvim-lsp'

        use 'BurntSushi/ripgrep' -- Grepping
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Better FZF
        use 'kyazdani42/nvim-web-devicons' -- Devicons

        use 'nvim-telescope/telescope.nvim' -- Telescope
        use 'cljoly/telescope-repo.nvim' -- Repo jumping for telescope
        use 'nvim-telescope/telescope-ui-select.nvim' -- Better inline popuips
        use 'airblade/vim-rooter' -- Project switching
        use 'AckslD/nvim-neoclip.lua' -- Clippboard lookup

        -- Treesitter
        use 'nvim-treesitter/nvim-treesitter'
        use 'romgrk/nvim-treesitter-context'

        use 'lukas-reineke/lsp-format.nvim' -- Autoformatting
        use 'simrat39/rust-tools.nvim' -- Rust tooling
        use 'jose-elias-alvarez/null-ls.nvim' -- Some formatting stuff
        use 'saecki/crates.nvim' -- Rust Cargo.toml utilities
        use 'mfussenegger/nvim-dap' -- Debugging adapter

        use 'lewis6991/gitsigns.nvim' -- Git integration
        use 'ellisonleao/glow.nvim' -- Markdown

        -- Status line
        use 'tamton-aquib/staline.nvim'
        use 'nvim-lualine/lualine.nvim'

        -- Session
        use 'rmagatti/auto-session'

        -- Colors
        use 'norcalli/nvim-colorizer.lua'

        -- Git diff
        use 'sindrets/diffview.nvim'
        use 'tpope/vim-fugitive'

        -- Coverage
        use 'stevearc/flow-coverage.nvim'

        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end)
end

function M.setup()
    bootstrap()
    setup_autocmd()
    init()
    return setup_plugins()
end

return M
