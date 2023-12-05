require 'nvim-treesitter.configs'.setup {
    --ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "html", "php", "javascript", "python", "css", "bash", "latex"},
    sync_install = false,
    --auto_install = true,
    ignore_install = { "latex" },
    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex", "markdown" }
    }
}
