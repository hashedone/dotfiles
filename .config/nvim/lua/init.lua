-- Leader before anything (everyone can do mappings properly)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

require 'options'.setup()
require 'plugins'.setup()
require 'keymaps'.setup()
require 'colorscheme'.setup()
require 'completion'.setup()
require 'lsp'.setup()
require 'tscope'.setup()
require 'git'.setup()
require 'neoclip'.setup()
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "cpp", "css", "go", "html", "json", "toml", "javascript", "vim" }
}
require 'treesitter-context'.setup {}
require 'crates'.setup()
require 'auto-session'.setup {
    auto_save_enabled = true,
    auto_restore_enabled = true,
}
require 'statusline'.setup()
require 'colorizer'.setup()

-- Rooter

vim.g.rooter_patterns = { '.git', 'Cargo.toml' }
vim.g.rooter_cd_cmd = 'lcd'

-- Status line
