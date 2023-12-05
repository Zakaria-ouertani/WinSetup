local N = require 'multicursors.normal_mode'
local I = require 'multicursors.insert_mode'
local multicursors = require('multicursors')

multicursors.setup {
    normal_keys = {
        [','] = {
            method = N.clear_others,
            opts = { desc = 'Clear others' },
        },
    },
    iansert_keys = {
        ['<CR>'] = {
            method = I.Cr_method,
            opts = { desc = 'New line' },
        },
    },
}

vim.keymap.set({'v', 'n'}, '<Leader>m', multicursors.start, { desc = 'Create a selection for selcted text or word under the cursor' })
