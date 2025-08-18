return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
      })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      custom_highlights = function(colors)
        return {
          Comment = { bg = colors.white, fg = colors.white },
          -- TabLineSel = { bg = colors.pink },
          -- CmpBorder = { fg = colors.surface2 },
          -- Pmenu = { bg = colors.none },
        }
      end,
      term_colors = true,
      transparent_background = true,
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        telescope = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        fidget = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  }
}
