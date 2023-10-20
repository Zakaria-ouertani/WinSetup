vim.opt.termguicolors = true
local bufferline = require("bufferline")
bufferline.setup{
    options = {
        separator_style = "slope",
        numbers = function(opts)
            return opts.ordinal
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                or (e == "warning" and " " or "i" )
                s = s .. n .. sym
            end
            return s
        end
    },
}
