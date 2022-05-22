local lualine = require 'lualine'
local material = require 'material.colors'
-- local staline = require 'staline'

local M = {}

function M.setup()
    lualine.setup {
        options = {
            -- Disable sections and component separators
            component_separators = '\u{e0bb}',
            section_separators = { left = '\u{e0bc}', right = '\u{e0ba}' },
            theme = require 'statusline.theme',
        },
        sections = {
            lualine_a = {
                { function() return '▊' end, separator = '', padding = { left = 0, right = 1 } },
                require 'statusline.mode',
            },
            lualine_b = {
                { 'filetype', icon_only = true, separator = '' },
                { 'filename', path = 1, shorting_target = "15", symbols = { modified = ' \u{2022}', readonly = ' \u{f023}' } },
                { 'filesize' },
            },
            lualine_c = {
                { 'branch', separator = '' },
                { 'diff', symbols = { added = '+ ', modified = '\u{2022} ', removed = '- ' } },
            },

            lualine_x = {
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = ' ', warn = ' ', info = ' ' },
                    diagnostics_color = {
                        color_error = { fg = material.red },
                        color_warn = { fg = material.yellow },
                        color_info = { fg = material.cyan },
                    },
                    separator = '',
                },
                {
                    function()
                        local msg = 'No Active Lsp'
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,
                    icon = ' ',
                    cond = function() return next(vim.lsp.get_active_clients()) ~= nil end,
                },
            },
            lualine_y = {
                { 'fileformat', separator = '' },
                { 'encoding' },
            },
            lualine_z = {
                { 'location' },
                { 'progress', separator = '', },
                { function() return '▊' end, separator = '', padding = { left = 1, right = 0 } },
            }
        }
    }
end

return M
