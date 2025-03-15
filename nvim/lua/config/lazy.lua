vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },

  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },

    -- Gruvbox Material theme
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_background = "material"
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_transparent_background = 1
      end,
    },
    {
      "wolandark/Mitra-Vim",
    },
    { "raphamorim/lucario" },
    {
      "neanias/everforest-nvim",
      version = false,
      lazy = false,
      priority = 1000,
      config = function()
        require("everforest").setup()
        vim.cmd.colorscheme("everforest")
      end,
    },
    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
    {
      "sainnhe/sonokai",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.sonokai_enable_italic = true
      end,
    },
    { "chriskempson/base16-vim" },
    {
      "morhetz/gruvbox",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme gruvbox]])
      end,
    },
    { "rebelot/kanagawa.nvim", name = "kanagawa", lazy = false, priority = 1000 },
    {
      "maxmx03/solarized.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function(_, opts)
        vim.o.termguicolors = true
        vim.o.background = "dark"
        require("solarized").setup(opts)
      end,
    },
    -- Ensure everforest theme loads on startup
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "everforest",
      },
    },

    -- Treesitter configuration
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "bash", "c", "html", "lua", "python" },
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        })
      end,
    },

    -- ToggleTerm configuration
    {
      "akinsho/toggleterm.nvim",
      tag = "*",
      config = function()
        require("toggleterm").setup({
          direction = "float",
          float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.7),
            winblend = 20,
          },
          open_mapping = [[<leader>td]],
        })
      end,
      keys = {
        {
          "<leader>td",
          "<cmd>ToggleTerm<CR>",
          desc = "Open a horizontal terminal",
        },
      },
    },
    {
      "water-sucks/darkrose.nvim",
      lazy = false,
      priority = 1000,
    },

    -- live-server.nvim configuration
    {
      "barrett-ruth/live-server.nvim",
      build = { "bun install live-server" },
      cmd = { "LiveServerStart", "LiveServerStop" },
      config = function()
        require("live-server").setup({
          port = 8080, -- Custom port
          root = ".", -- Serve files from the current directory
        })
      end,
      keys = {
        { "<leader>sl", "<cmd>LiveServerStart<CR>", desc = "Start Live Server" },
        { "<leader>sc", "<cmd>LiveServerStop<CR>", desc = "Stop Live Server" },
      },
    },
  },

  defaults = {
    lazy = false,
    version = false,
  },

  install = { colorscheme = { "everforest", "tokyonight", "habamax" } },

  checker = {
    enabled = true,
    notify = false,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
vim.cmd("colorscheme base16-horizon-dark")
