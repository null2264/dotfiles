-- Loaded by `null.config`
local map = require("null.util").map

-- Map Ctrl+U as U so it can be used as redo
map("n", "<C-u>", "U")
-- Map U as redo
map("n", "U", "<C-r>")

-- Yank and Put
map("n", "<C-y>", '"+y')
map("n", "<C-p>", '"+p')
map("n", "<C-Y>", '"+y')
map("n", "<C-P>", '"+p')

-- Comment a line like how it is on VSC (using vim-commentary)
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })
map("i", "<C-/>", "<esc>gcc", { remap = true })

-- Normal command shortcut for VISUAL mode
map("v", ".", ":normal .<CR>")
