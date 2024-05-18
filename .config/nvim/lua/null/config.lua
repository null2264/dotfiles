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

o.list = true
-- > Visualize indent trails with dots
o.listchars:append("space:⋅")
o.listchars:append("trail:⋅")
o.listchars:append("tab:▎―")
-- > Remove ugly tilde at the end of a file
-- > REF: https://vi.stackexchange.com/a/29181
o.fillchars:append("eob: ")

g.mapleader = " "
g.guifont = { "Sarasa UI J", ":h16" }

require("null.remap")
