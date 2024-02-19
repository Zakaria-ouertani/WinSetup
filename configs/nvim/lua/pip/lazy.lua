return {
	
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	-- {
	--     'altermo/ultimate-autopair.nvim',
	--     event = { 'InsertEnter', 'CmdlineEnter' },
	--     branch = 'v0.6',
	--     config = function()
	--         require('ultimate-autopair').setup({
	--             -- Config goes here
	--         },)
	--     end,
	-- },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },             -- Required
			{ 'williamboman/mason.nvim' },           -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },     -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' },     -- Required
		},
	},
	{ "mfussenegger/nvim-lint" },
	{ 'mhartington/formatter.nvim' },
	{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		tag = 'v0.9.1'

	},
	{ "mbbill/undotree" },
	{ "akinsho/toggleterm.nvim" },
	{ 'talha-akram/noctis.nvim' },
	{ "akinsho/bufferline.nvim" },
	{
		"tpope/vim-fugitive",
		"tpope/vim-repeat",
		"tpope/vim-speeddating"
	},

	{ "kylechui/nvim-surround" },
	{ "glts/vim-radical" },
	{ "folke/which-key.nvim" },
	{ "sontungexpt/url-open" },
	{ "nvim-lualine/lualine.nvim" },
	{ "echasnovski/mini.comment" },
	--    {
	--        "luckasRanarison/nvim-devdocs",
	--        dependencies = {
	--            "nvim-lua/plenary.nvim",
	--            "nvim-telescope/telescope.nvim",
	--            "nvim-treesitter/nvim-treesitter",
	--        },
	--        config = function()
	--            require("nvim-devdocs").setup()
	--        end
	--    },
	{
		'filipdutescu/renamer.nvim',
		branch = 'master',
		dependencies = { { 'nvim-lua/plenary.nvim' }}
	},
	{ "olrtg/nvim-emmet" },
	{
		"smoka7/multicursors.nvim",
		dependencies = {
			"smoka7/hydra.nvim"
		},
	},
	{ "ray-x/lsp_signature.nvim"},
	{
		'nvimdev/hlsearch.nvim',
		event = 'BufRead',
		config = function()
			require('hlsearch').setup()
		end
	},

	{ "hinell/move.nvim" },
	{ "mrjones2014/legendary.nvim" },
	{ "LinArcX/telescope-command-palette.nvim" },
	{ 'rmagatti/auto-session', },
	{ 'AckslD/nvim-FeMaco.lua', },
	{ 'stevearc/overseer.nvim' },
	{ 'Zeioth/compiler.nvim' },
	{
		"stevearc/dressing.nvim",
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" }})
				return vim.ui.select(...)
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap"
		}
	}
}
