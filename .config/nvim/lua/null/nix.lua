local o = vim.opt
local g = vim.g

o.undodir = vim.fn.stdpath("data") .. "/null/undo"
o.directory = vim.fn.stdpath("data") .. "/null/swap"
o.backupdir = vim.fn.stdpath("data") .. "/null/backup"
o.viewdir = vim.fn.stdpath("data") .. "/null/view"
