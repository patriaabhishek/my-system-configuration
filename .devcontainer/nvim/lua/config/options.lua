vim.g.mapleader = " "

-- All paths configured in lua/core/env.lua
local env = require("core.env")

vim.g.python3_host_prog = env.python

vim.env.PATH = table.concat({
  env.python_venv .. "/bin",
  env.node_bin,
  env.goroot .. "/bin",
  env.gopath .. "/bin",
  vim.env.PATH,
}, ":")

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

opt.number = true
opt.relativenumber = false

opt.termguicolors = true
opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

opt.signcolumn = "yes"

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 250

opt.cursorline = true

opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

opt.mouse = "a"

opt.showmode = false

opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.fillchars = { eob = " " }
