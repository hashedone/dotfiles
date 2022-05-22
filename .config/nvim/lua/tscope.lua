local M = {}

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local actions_layout = require 'telescope.actions.layout'
local utils = require 'telescope.utils'
local themes = require 'telescope.themes'
local wk = require 'which-key'

local keys = vim.keymap

function M.project_files()
    local _, ret, _ = utils.get_os_command_output {
        'git', 'rev-parse', '--is-inside-work-tree'
    }
    local gopts = {
        prompt_title = 'Git files'
    }
    if ret == 0 then
        builtin.git_files(gopts)
    else
        builtin.find_files()
    end
end

function M.grep_prompt()
    builtin.grep_string {
        shorten_path = true,
        search = vim.fn.input("Rg> ")
    }
end

function M.vim_config()
    vim.cmd "lcd ~/.config/nvim"
    builtin.find_files {
        cwd = '~/.config/nvim/'
    }
end

function M.setup()
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                },
            }
        },
        extensions = {
            ["ui-select"] = {
                themes.get_cursor({})
            }
        }
    })

    telescope.load_extension 'fzf'
    telescope.load_extension 'ui-select'
    telescope.load_extension 'repo'
    telescope.load_extension 'neoclip'
    telescope.load_extension 'notify'

    keys.set('n', '<C-p>', M.project_files)
    keys.set('n', '<C-g>', M.grep_prompt)

    wk.register({
        t = {
            name = "telescope",
            h = { builtin.help_tags, "Help" },
            r = { function() telescope.extensions.repo.list { search_dirs = { '~/git', '~/confio/git' } } end, "Repos" },
            c = { telescope.extensions.neoclip.default, "Clipboard" },
            f = { builtin.find_files, "Files" },
            b = { builtin.buffers, "Buffers" },
            H = { builtin.oldfiles, "Files history" },
            C = { M.vim_config, "Config" },
            s = { builtin.search_history, "Search history" },
            m = { builtin.marks, "Marks" },
            q = { builtin.quickfix, "Quickfix" },
            j = { builtin.jumplist, "Jumps" },
            R = { builtin.registers, "Registers" },
            t = { builtin.resume, "Resume" },
            M = { builtin.reloader, "Lua modules" },
        }
    }, { prefix = "<Leader>" })
end

return M
