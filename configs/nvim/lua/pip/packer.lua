vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'altermo/ultimate-autopair.nvim',
		event={'InsertEnter','CmdlineEnter'},
		branch='v0.6',
		config=function ()
			require('ultimate-autopair').setup({
				-- Config goes here
			})
		end,
	}

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}
	use {
		"rcarriga/nvim-dap-ui",
		requires = {"mfussenegger/nvim-dap"}
	}

	use {
		"mfussenegger/nvim-lint"
	}

	use {
		'mhartington/formatter.nvim'
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use {
		"mbbill/undotree"
	}

    use {
        "akinsho/toggleterm.nvim"
    }
    use {
        'talha-akram/noctis.nvim'
    }

    use {
        "akinsho/bufferline.nvim"
    }

    use {
        "tpope/vim-fugitive",
        "tpope/vim-repeat",
        "tpope/vim-speeddating"
    }

    use {
        "kylechui/nvim-surround"
    }

    use {
        "glts/vim-radical",
        "glts/vim-magnum"
    }

    use {
        "folke/which-key.nvim"
    }

    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        config = function()
            require("neorg").setup {
                -- configuration here
            }
        end,
    }

    use {
        "sontungexpt/url-open"
    }

    use {
        "nvim-lualine/lualine.nvim"
    }

    use {
        "echasnovski/mini.comment"
    }use {
        "luckasRanarison/nvim-devdocs",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-devdocs").setup()
        end
    }
    use {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        "olrtg/nvim-emmet"
    }
end)
