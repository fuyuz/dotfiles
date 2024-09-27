local opt = vim.opt
opt.ambiwidth = 'double'

opt.autoindent = true
opt.smartindent = true
opt.cursorline = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.expandtab = true

opt.number = true

opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

opt.list = true
opt.listchars = {
  tab = '»-',
  extends = '»',
  precedes = '«',
  trail = '-',
  eol = '↴',
  nbsp = '%',
}

vim.g.mapleader = " "
vim.g.maplocalleader = ","
