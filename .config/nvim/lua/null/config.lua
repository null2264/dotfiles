local o = vim.opt
local g = vim.g

o.encoding = "utf-8"
o.hls = true

o.number = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "number"

o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.splitbelow = true
o.splitright = true

-- Remove ugly tilde at the end of a file
-- REF: https://vi.stackexchange.com/a/29181
o.fillchars = "eob: "

g.mapleader = " "
g.guifont = { "Sarasa UI J", ":h16" }

require("null.remap")
