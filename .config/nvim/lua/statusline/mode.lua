return {
    function()
        local mode_icon = {
            n       = ' ',
            no      = ' ',
            nov     = ' ',
            noV     = ' ',
            ['no␖']= ' ',
            niI     = ' ',
            niR     = ' ',
            niV     = ' ',

            i  = ' ',
            ic = ' ',
            ix = ' ',
            s  = ' ',
            S  = ' ',

            v      = ' ',
            V      = ' ',
            ['␖']= ' ',
            r      = '﯒ ',
            ['r?'] = ' ',
            c      = ' ',
            t      = ' ',
            ['!']  = ' ',
            R      = ' ',
        }

        return mode_icon[vim.fn.mode()]
    end,
}
