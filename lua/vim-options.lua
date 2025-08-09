vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.equalalways = false
vim.g.mapleader = ' '
vim.diagnostic.config({
  virtual_text = true,  -- set to false if you dislike inline text
  signs = true,         -- show errors via gutter signs
  underline = true,     -- underline problem text
  update_in_insert = false,
  severity_sort = true,
})

