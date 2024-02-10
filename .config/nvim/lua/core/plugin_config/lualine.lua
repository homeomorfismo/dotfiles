require('lualine').setup{
    options = {
        icons_enabled = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
            {'filename', file_status = true},
            {'diagnostics', sources = {'nvim_lsp'}},
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
}
