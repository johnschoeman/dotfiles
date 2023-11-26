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

-- Delete Text
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})

-- File Navigation
vim.keymap.set('n', '<F2>', '<cmd>Lexplore<cr>', {desc = 'Open file exlorer'})
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

-- TODO: Resize panes

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
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } },
  { 'christoomey/vim-tmux-navigator' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'wellle/targets.vim' },
  { 'numToStr/Comment.nvim', opts = {}, lazy = false },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  { 'tpope/vim-fugitive' },
  { 'moll/vim-bbye' },
  { 'github/copilot.vim' },
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
    theme = 'tokyonight',
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
  indent = {
    char = '|',
  },
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

-- ========================================================================== --
-- ==                           LANGUAGE SERVER                            == --
-- ========================================================================== --

