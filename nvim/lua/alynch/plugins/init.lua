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

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    }

    use "mbbill/undotree"

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
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            "nvim-lua/plenary.nvim"
        }
    }

    use "folke/tokyonight.nvim"

	-- sync packer after bootstrapping
	if bootstrapped then
		require("packer").sync()
	end

    -- require plugin configurations
    require("alynch.plugins.tokyonight")
    require("alynch.plugins.lualine")
end)
