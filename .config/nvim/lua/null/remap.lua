-- Loaded by `null.config`
local map = require("null.util").map

-- Map Ctrl+U as U so it can be used as redo
map("n", "<C-u>", "U")
-- Map U as redo
map("n", "U", "<C-r>")

-- Yank and Put
map("nv", "<C-y>", '"+y')
map("n", "<C-p>", '"+p')
map("nv", "<C-Y>", '"+y')
map("n", "<C-P>", '"+p')

-- Comment a line like how it is on VSC (using vim-commentary)
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })
map("i", "<C-/>", "<esc>gcc", { remap = true })

-- Normal command shortcut for VISUAL mode
map("v", ".", ":normal .<cr>")

-- Clear search
map("n", "<leader>c", "<cmd>noh<cr>")

-- Navigate splits
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Ctrl+P or Ctrl+N alternatives
-- map("i", "<expr><Up>", vim.fn.pumvisible() == 1 and "<C-n>" or "<Up>")
-- map("i", "<expr><Down>", vim.fn.pumvisible() == 1 and "<C-p>" or "<Down>")
-- map("i", "<expr><Tab>", vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>")
-- map("i", "<expr><S-Tab>", vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>")

-- Enter to complete
-- map("i", "<expr><cr>", vim.fn.pumvisible() == 1 and "<C-y>" or "<cr>")
