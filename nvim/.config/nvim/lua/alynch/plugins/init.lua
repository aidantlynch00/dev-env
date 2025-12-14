-- require plugin configurations
local require_configs = function()
    require("alynch.plugins.treesitter")
    require("alynch.plugins.tokyonight")
    require("alynch.plugins.telescope")
    require("alynch.plugins.harpoon")
    require("alynch.plugins.lsp")
    require("alynch.plugins.aerial")
    require("alynch.plugins.neotree")
    require("alynch.plugins.lualine")
    require("alynch.plugins.obsidian")
end

local bootstrap_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local bootstrapped = bootstrap_packer()

return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"

    -- notes
    use "kkharji/sqlite.lua"
    use "MeanderingProgrammer/render-markdown.nvim"
    use "obsidian-nvim/obsidian.nvim"

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    }


    use "tpope/vim-surround"
    use "tpope/vim-repeat"

    use {
        "nvim-lualine/lualine.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
            opt = true
        }
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = {
            "nvim-lua/plenary.nvim"
        }
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    }

    -- configure LSPs
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use {
        "ms-jpq/coq_nvim",
        requires = {
            "ms-jpq/coq.artifacts"
        }
    }

    -- symbol tree
    use "stevearc/aerial.nvim"

    -- colorschemes
    use "folke/tokyonight.nvim"

	-- sync packer after bootstrapping
	if bootstrapped then
		require("packer").sync()
	end

    require_configs()
end)
