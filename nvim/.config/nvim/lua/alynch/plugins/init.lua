vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		-- build libfzf for telescope-fzf-native
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add({
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/kkharji/sqlite.lua",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",

	-- notes
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/obsidian-nvim/obsidian.nvim",

	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
	},

	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/arborist-ts/arborist.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",

	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
	},

	-- configure LSPs
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/seblyng/roslyn.nvim",

    -- completions
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1",
    },

	-- symbol tree
	"https://github.com/stevearc/aerial.nvim",

	-- colorschemes
	"https://github.com/folke/tokyonight.nvim",

	-- other
	"https://github.com/kawre/leetcode.nvim",
})

-- require plugin configurations
require("alynch.plugins.treesitter")
require("alynch.plugins.tokyonight")
require("alynch.plugins.telescope")
require("alynch.plugins.harpoon")
require("alynch.plugins.blink")
require("alynch.plugins.lsp")
require("alynch.plugins.aerial")
require("alynch.plugins.neotree")
require("alynch.plugins.lualine")
require("alynch.plugins.obsidian")
require("alynch.plugins.leetcode")
