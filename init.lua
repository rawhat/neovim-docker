vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

  use({
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").load()
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        }
      })
    end,
  })
end)
