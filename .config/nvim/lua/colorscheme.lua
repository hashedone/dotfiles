local M = {}

function M.setup()
    vim.g.material_style = 'oceanic'

    require('material').setup({
        italics = {
            comments = true,
        }
    })

    vim.cmd 'colorscheme material'
end

return M
