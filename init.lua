local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "  -- set before lazy

require("lazy").setup("user.plugins")
require("user.setup")
require "user.options"
require "user.keymaps"
require("leap").add_default_mappings()
require("user.autocommands")
require("user.globals")
