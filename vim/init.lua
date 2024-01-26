-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.backspace = "2"
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.list = true
vim.opt.listchars = 'tab:»·,trail:·,nbsp:·'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.linebreak = true

-- search substitute
vim.opt.hlsearch = false
vim.opt.smartcase = true

-- Spell Check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
-- z=       : update misspelled word
-- ]s       : next misspelled word
-- [s       : previous misspelled word
-- :spellr  : spell repeat
-- zg       : add word to en.utf-8.add


-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader
vim.g.mapleader = ' '
vim.keymap.set({'n', 'x', 'o'}, ';', ':')

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Clipboard Interaction
vim.keymap.set({'n', 'x'}, 'gp', '"+p')
vim.keymap.set({'n', 'x'}, 'gy', '"+y')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', {desc = 'Quit'})
vim.keymap.set('n', '<leader>f', '<cmd>Format<cr>')

-- File Navigation
vim.keymap.set('n', '<F2>', '<cmd>e .<cr>', {desc = 'Open file exlorer'})
vim.keymap.set('n', '<space><space>', '<F2>', {remap = true, desc = 'Open file explorer'})
vim.keymap.set('n', '<leader>p', '<C-^>', {desc = 'Go to last file'})

-- Window Sizing
vim.keymap.set('n', '<leader>+', '<C-w>+', {desc = 'Increase window height'})
vim.keymap.set('n', '<leader>-', '<C-w>-', {desc = 'Decrease window height'})
vim.keymap.set('n', '<leader>>', '<C-w>>', {desc = 'Increase window width'})
vim.keymap.set('n', '<leader><', '<C-w><', {desc = 'Decrease window width'})
vim.keymap.set('n', '<leader>=', '<C-w>=', {desc = 'Equalize window sizes'})


-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
vim.keymap.set('n', '<leader>so', '<cmd>ReloadConfig<cr>')

local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- TODO: lint:fix

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
  -- Theme
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } },

  -- Navigation
  { 'christoomey/vim-tmux-navigator' },

  -- Code manipulation
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'wellle/targets.vim' },
  { 'numToStr/Comment.nvim', opts = {}, lazy = false },
  { 'mhartington/formatter.nvim' },

  -- Linting
  { 'mfussenegger/nvim-lint' },

  -- Fuzzy finding
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

  -- Git
  { 'tpope/vim-fugitive' },

  -- Utilities
  { 'moll/vim-bbye' },
  { 'nvim-lua/plenary.nvim' },

  -- AI
  { 'github/copilot.vim' },

  -- LSP support
  { 'neovim/nvim-lspconfig' },
  { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }, opts = {} },

  -- Auto complete
  { 'hrsh7th/nvim-compe' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
}

opts = {}

require('lazy').setup(plugins, opts)

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
-- vim.cmd [[ set background=light ]]
vim.cmd [[ colorscheme rose-pine ]]

-- TODO: toggle between light and dark theme


---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false
require('lualine').setup({
  options = {
    theme = 'rose-pine',
    component_separators = '|',
    section_separators = '',
  }
})


---
-- netrw (file explorer)
---
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30


---
-- indent-blankline
---
require('ibl').setup({
  enabled = false,
  indent = { char = '|' },
  scope = {
    show_start = false,
    show_end = false,
    highlight = { "Function", "Label" },
  }
})


---
-- text-objects (treesitter)
---
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'css',
    'json',
    'lua',
  },
})


---
-- Comments
---
require('Comment').setup({})


---
-- Fuzzy Finder (telescope)
---
vim.keymap.set('n', '<leader>o', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

require('telescope').load_extension('fzf')


---
-- vim-bbye
---
vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')


---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require('luasnip.loaders.from_vscode').lazy_load()


---
-- nvim-cmp (autocomplete)
---
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

-- See :help cmp-config
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  -- See :help cmp-mapping
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})


---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = '»'})

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', 'gj', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    bufmap('n', 'gk', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
  end
})

---
-- LSP servers
---

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Prevent multiple instance of lsp servers
-- if file is sourced again
if vim.g.lsp_setup_ready == nil then
  vim.g.lsp_setup_ready = true

  -- See :help lspconfig-setup
  lspconfig.html.setup({capabilities = lsp_capabilities,})
  lspconfig.cssls.setup({capabilities = lsp_capabilities,})
  lspconfig.eslint.setup({capabilities = lsp_capabilities,})
end

-- typescript
require('typescript-tools').setup({})

-- LSP Floating Windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)


-- ---
-- -- Formatting (formatter)
-- ---
local prettierConfig = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0))},
    stdin = true
  }
end

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    json = {prettierConfig},
    html = {prettierConfig},
    javascript = {prettierConfig},
    typescript = {prettierConfig},
    typescriptreact = {prettierConfig},
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

---
-- Linting (nvim-lint)
--
require('lint').linters_by_ft = {
  typescript = {'eslint_d', 'eslint',},
  javascript = {'eslint_d', 'eslint' },
}
