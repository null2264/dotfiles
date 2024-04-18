local o = vim.opt
local g = vim.g

o.encoding = "utf-8"
o.hls = true
o.nu = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.splitbelow = true
o.splitright = true

g.mapleader = " "
g.guifont = { "Sarasa UI J", ":h16" }

require("null.remap")
