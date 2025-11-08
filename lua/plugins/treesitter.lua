return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc" },  -- Add your desired languages here, or "all"
        sync_install = false,
        auto_install = true,  -- Automatically install missing parsers when entering a buffer
        ignore_install = {},  -- Languages to ignore
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        -- Add other modules as needed (e.g., incremental_selection, textobjects)
      })
    end,
  },
}
