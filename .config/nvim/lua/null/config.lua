require("null.remap")

local o = vim.opt
local g = vim.g

o.nu = true
o.relativenumber = true

g.mapleader = " "
g.guifont = { "Sarasa UI J", ":h16" }

require("oil").setup()
