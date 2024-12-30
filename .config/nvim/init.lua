-- Bootstrap lazy.nvim
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

-- Basic settings
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Plugin specification
require("lazy").setup({
  -- UI
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight-storm]]
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
  { "github/copilot.vim", event = "InsertEnter", lazy = false},

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "cpp", "latex" },
        highlight = { enable = true },
      })
    end,
  },

  -- File navigation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive", cmd = "Git" },

  -- Language-specific
  { "lervag/vimtex", ft = "tex" },

  -- Utility
  "Bekaboo/deadcolumn.nvim",
  {
    "m4xshen/hardtime.nvim",
    opts = {
      max_time = 1000,
      max_count = 3,
      disable_mouse = true,
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        cpp = { "clang-format" },
      },
    },
  },
})

-- LSP Configuration
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "clangd", "texlab" },
})

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')
local servers = { 'lua_ls', 'pyright', 'clangd', 'texlab' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Completion setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- VimTex Configuration
vim.g.vimtex_compiler_method = 'latexmk'
-- shell escape for minted
-- vim.g.vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
-- vim.g.vimtex_compiler_latexmk = { 'aux_dir' : '', 'out_dir' : '', 'callback' : 1, 'continuous' : 1, 'executable' : 'latexmk', 'hooks' : [], 'options' : [ '-pdf', '-shell-escape', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', ], }
vim.g.vimtex_compiler_latexmk = {
  executable = 'latexmk',
  continuous = 1,
  hooks = {},
  options = { '-pdf', '-shell-escape', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode' },
}

-- DeadColumn Configuration
require("deadcolumn").setup({
  scope = "line",
  modes = { "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx" },
  blending = {
    threshold = 0.75,
    colorcode = "#000000",
  },
  warning = {
    alpha = 0.4,
    colorcode = "#FF0000",
    offset = 1,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "cpp" then
      vim.opt_local.colorcolumn = "120"
    elseif vim.bo.filetype == "python" then
      vim.opt_local.colorcolumn = "79"
    elseif vim.bo.filetype == "markdown" or vim.bo.filetype == "tex" then
      vim.opt_local.colorcolumn = "80"
    else
      vim.opt_local.colorcolumn = "120"
    end
  end,
})
-- Additional keybindings
vim.keymap.set('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
