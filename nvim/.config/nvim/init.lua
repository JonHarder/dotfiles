vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.hidden = true

vim.opt.relativenumber = true

vim.g.mapleader = ' '

-- keybindings
vim.keymap.set('n', '<leader>s', '<cmd>write<cr>', {desc = 'Save'})

-- Window management
vim.keymap.set('n', '<leader>w', '<C-w><C-w>', {})
vim.keymap.set('n', '<leader>1', ':only<cr>', {})
vim.keymap.set('n', '<leader>2', ':sp<cr>', {})
vim.keymap.set('n', '<leader>3', ':vsp<cr>', {})
vim.keymap.set('n', '<leader>.', ':sp<cr>', {})
vim.keymap.set('n', '<leader>/', ':vsp<cr>', {})
vim.keymap.set('n', '<leader>"', ':clo<cr>', {})
vim.keymap.set('n', '<leader>\'', ':only<cr>', {})
vim.keymap.set('n', '<leader>d', ':bd<cr>', {})


-- 'packer' package management initialization
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- plugins
return require('packer').startup(function(use)
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'

  -- THEMES
  -- use 'joshdick/onedark.vim'
  -- vim.cmd 'colorscheme onedark'

  use 'rebelot/kanagawa.nvim'
  vim.cmd 'colorscheme kanagawa'
  -- use 'marko-cerovac/material.nvim'
  -- vim.g.material_style = "oceanic"
  -- vim.cmd 'colorscheme material'

  -- Modeline
  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true
        }
      })
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {"c", "lua", "ruby"},
        run = ':TSUpdate',
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
    end,
  })

  use {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {}, -- loads default behavior
          ["core.concealer"] = {}, -- adds pretty icons to your documents
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Highlighting
  -- use({ -- Unified highlight for all filetypes
  --   "nvim-treesitter/nvim-treesitter",
  --   run = ":TSUpdate",
  --   config = function()
  --     require("treesitter")
  --   end,
  -- })

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'danesirhculofyxk' }
      vim.keymap.set('n', '  ', ':HopWord<cr>', {})
    end
  }

  use {
     'nvim-telescope/telescope.nvim',
     tag = '0.1.0',
     requires = { {'nvim-lua/plenary.nvim'} },
     config = function()
        local tele = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', tele.find_files, {})
        vim.keymap.set('n', '<leader>fg', tele.live_grep, {})
        vim.keymap.set('n', '<leader>b', tele.buffers, {})
     end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
